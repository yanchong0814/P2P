package com.hxzy.telexam.actions;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hxzy.telexam.beans.Paper;
import com.hxzy.telexam.beans.Userinfo;
import com.hxzy.telexam.service.interfaces.IPaperService;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Scope(value="prototype")
public class PaperAction extends ActionSupport implements ModelDriven<Paper> {
    @Autowired
    private IPaperService paperService;
    private Integer number01;
    private Integer number02;
    private Integer number03;
    private Integer qstage;
    private Integer qcourse;
    private String result;

    private File filepath;
    private String filepathFileName;
    private String path="/var/source";

    private Paper paper=new Paper();

    public Integer getNumber01() {
        return number01;
    }
    public void setNumber01(Integer number01) {
        this.number01 = number01;
    }
    public Integer getNumber02() {
        return number02;
    }
    public void setNumber02(Integer number02) {
        this.number02 = number02;
    }
    public Integer getNumber03() {
        return number03;
    }
    public void setNumber03(Integer number03) {
        this.number03 = number03;
    }
    public String getResult() {
        return result;
    }
    public void setResult(String result) {
        this.result = result;
    }
    public File getFilepath() {
        return filepath;
    }
    public void setFilepath(File filepath) {
        this.filepath = filepath;
    }
    public String getFilepathFileName() {
        return filepathFileName;
    }
    public void setFilepathFileName(String filepathFileName) {
        this.filepathFileName = filepathFileName;
    }
    public String getPath() {
        return path;
    }
    public void setPath(String path) {
        this.path = path;
    }
    public Integer getQstage() {
        return qstage;
    }
    public void setQstage(Integer qstage) {
        this.qstage = qstage;
    }
    public Integer getQcourse() {
        return qcourse;
    }
    public void setQcourse(Integer qcourse) {
        this.qcourse = qcourse;
    }

    public String deleteAction(){
        try {
            paperService.delete(paper);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SUCCESS;
    }

    public String queryPaperAction(){
        try {
            Userinfo userinfo=(Userinfo) ServletActionContext.getRequest().getSession().getAttribute("userinfo");
            List<Paper> list=paperService.query(paper,userinfo);
            result=JSONArray.toJSONString(list);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SUCCESS;
    }

    public String queryAction(){
        Map<String,Object> map=new HashMap<>();
        map.put("qtype1",1);
        map.put("qtype2",2);
        map.put("qtype3",3);
        map.put("number1",number01);
        map.put("number2",number02);
        map.put("number3",number03);
        map.put("qstage",qstage);
        map.put("qcourse", qcourse);
        try {
            Map<String,Object> map1=paperService.query(map);
            result=JSONObject.toJSONString(map1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SUCCESS;
    }

    public String saveAction(){
        if(null!=qcourse) {
            paper.setPcourse(String.valueOf(qcourse));
        }
        if(null!=paper.getUrl()){
            this.filepath=new File(paper.getUrl());
        }
        try {
            if(null!=filepath){
                File file=new File(path);
                if(!file.exists()){
                    file.mkdirs();
                }
                FileUtils.copyFile(filepath,new File(path+File.separator+filepathFileName));
                paper.setUrl(filepathFileName);
            }else{
                if(null!=paper.getPid()){
                    paper.setUrl(paperService.query(paper.getPid(),true).getUrl());
                }else{
                    paper.setUrl(" ");
                }
            }
            paperService.saveOrUpdate(paper);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SUCCESS;
    }

    public String examAction(){
        try {
            paper=paperService.query(paper.getPid(), true);
            List list=paperService.query(paper.getQids());
            Map<String,Object> map=new HashMap<>();
            map.put("paper", paper);
            map.put("lists",list);
            result=JSONObject.toJSONString(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SUCCESS;
    }

    @Override
    public Paper getModel() {
        return paper;
    }
}
