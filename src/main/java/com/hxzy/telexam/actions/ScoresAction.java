package com.hxzy.telexam.actions;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.hxzy.telexam.dao.implement.ScoresDao;
import com.hxzy.telexam.service.interfaces.IPaperService;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.alibaba.fastjson.JSONObject;
import com.hxzy.telexam.beans.Paper;
import com.hxzy.telexam.beans.Scores;
import com.hxzy.telexam.beans.Userinfo;
import com.hxzy.telexam.service.interfaces.IScoresService;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

@Controller
@Scope(value="prototype")
public class ScoresAction extends ActionSupport implements ModelDriven<Scores> {
    /**
	 * 
	 */
	private static final long serialVersionUID = 5085446152034192852L;

	@Autowired
    private IScoresService scoresService;
    @Autowired
    private IPaperService paperService;

    private Scores scores=new Scores();
    private String result;
    private String pid;
    public String getPid() {
        return pid;
    }
    public void setPid(String pid) {
        this.pid = pid;
    }
    public String getResult() {
        return result;
    }
    public void setResult(String result) {
        this.result = result;
    }
    
    public String saveAction() {
        try {
            String uuid=UUID.randomUUID().toString().replace("-", "");
            scores.setScid(uuid);
            Userinfo userinfo=(Userinfo) ServletActionContext.getRequest().getSession().getAttribute("userinfo");
            scores.setUser(userinfo);
            Paper paper=new Paper();
            paper.setPid(pid);
            scores.setScbegintimes(new Timestamp(new java.util.Date().getTime()));
            scores.setPaper(paper);
            result=JSONObject.toJSONString(scoresService.saveOrUpdate(scores));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SUCCESS;
    }
    
    public String queryAction() {
    	try {
			List<Scores> list=scoresService.list();
			ServletActionContext.getRequest().setAttribute("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return SUCCESS;
    }
    @Override
    public Scores getModel() {
        return scores;
    }
    
    public String delete() throws Exception {
    	scoresService.delete(scores.getScid());
		return SUCCESS;
	}

	public String paperAction(){
        try {
            Paper paper=paperService.query(pid, true);
            List list=paperService.query(paper.getQids());
            Userinfo userinfo=(Userinfo)ServletActionContext.getRequest().getSession().getAttribute("userinfo");
            String myanswer=scoresService.queryPaper(pid,userinfo.getUid());
            Map<String,Object> map=new HashMap<>();
            map.put("lists",list);
            map.put("myanswer",myanswer);
            result=JSONObject.toJSONString(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SUCCESS;
    }
}
