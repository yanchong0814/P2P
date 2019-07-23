package com.hxzy.telexam.actions;

import com.hxzy.telexam.beans.Paper;
import com.hxzy.telexam.service.interfaces.IPaperService;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

@Controller
@Scope(value="prototype")
public class FileDownAction extends ActionSupport {
    @Autowired
    private IPaperService paperService;

    private String pid;
    public String getPid() {
        return pid;
    }
    public void setPid(String pid) {
        this.pid = pid;
    }

    //文件下载弹出框显示的文件名变量
    private String filepath;
    public String getFileName() {
        // 解决弹出框文件名为乱码的问题。
        ServletActionContext.getResponse().setHeader("charset","ISO8859-1");
        try {
            return new String(this.filepath.getBytes(), "ISO8859-1");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "获取文件名出现了错误!";
    }
    public void setFileName(String fileName) {
        this.filepath = fileName;
    }

    //读取下载文件的输入流
    private InputStream inputStream;
    public InputStream getInputStream() throws Exception {
        //通过ID查询文件路劲与文件名称
        Paper paper=paperService.query(pid,true);
        this.filepath=paper.getUrl();
        File file=new File("/var/source"+File.separator+paper.getUrl());
        InputStream in=new FileInputStream(file);
        return in;
    }

    @Override
    public String execute() throws Exception {
        return SUCCESS;
    }
}
