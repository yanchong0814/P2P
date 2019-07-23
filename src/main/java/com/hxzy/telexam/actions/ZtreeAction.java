package com.hxzy.telexam.actions;

import com.alibaba.fastjson.JSONArray;
import com.hxzy.telexam.beans.Ztree;
import com.hxzy.telexam.service.interfaces.IZtreeService;
import com.opensymphony.xwork2.ActionSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Controller
@Scope(value="prototype")
public class ZtreeAction extends ActionSupport{

    @Autowired
    private IZtreeService ztreeService;
    private String result;
    public String getResult() {
        return result;
    }
    public void setResult(String result) {
        this.result = result;
    }

    public String query(){
        try {
            List<Ztree> listroot=ztreeService.query(new Ztree("0", null, null, null, null));
            Iterator<Ztree> iterator=listroot.iterator();
            while(iterator.hasNext()) {
                Ztree ztree=iterator.next();
                List<Ztree> listchild=getchild(ztreeService,ztree);
                if (!listchild.isEmpty()) {
                    ztree.setChild(listchild);
                }
            }
            result= JSONArray.toJSONString(listroot);
/*            System.out.println(result);*/
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SUCCESS;
    }

    private List<Ztree> getchild(IZtreeService ztreeService, Ztree ztree) {
        List<Ztree> listroot=new ArrayList<>();
        try {
            listroot=ztreeService.query(ztree);
            Iterator<Ztree> iterator=listroot.iterator();
            while (iterator.hasNext()) {
                Ztree ztree2=iterator.next();
                List<Ztree> listchild=getchild(ztreeService,ztree2);
                if(listchild.isEmpty()) {
                    return listroot;
                }else {
                    ztree2.setChild(listchild);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listroot;
    }
}
