package com.hxzy.telexam.actions;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.alibaba.fastjson.JSONArray;
import com.hxzy.telexam.beans.PageBean;
import com.hxzy.telexam.beans.Question;
import com.hxzy.telexam.beans.QuestionAnswer;
import com.hxzy.telexam.service.interfaces.IQuestionService;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
/*
 * @chin 
 * Actions 前台数据处理控制层
 * 
*/
@Controller
@Scope(value="prototype")
public class QuestionActions extends ActionSupport implements ModelDriven<Question> {

	private static final long serialVersionUID = 8525917499130086203L;
	@Autowired
	private IQuestionService questionService;
	
	private Question question = new Question(); 
	
	private String result;
	
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
	@Override
	public Question getModel() {
		return question;
	}

	public String saveOrUpdate() {
		try {
			String[] strings=ServletActionContext.getRequest().getParameterValues("qaname");
			//String[] strids=ServletActionContext.getRequest().getParameterValues("qaid");
			List<QuestionAnswer> list=new ArrayList<>();			
			/*for(int i=0;i<strids.length;i++) {
				QuestionAnswer questionAnswer = new QuestionAnswer();
				Integer id = Integer.parseInt(strids[i]);
				String namestr=strings[i];
				questionAnswer.setQaid(id);
				questionAnswer.setQaname(namestr);
				list.add(questionAnswer);
			}*/			
			for(String str:strings) {
				QuestionAnswer questionAnswer = new QuestionAnswer();
				questionAnswer.setQaname(str);
				list.add(questionAnswer);
			}
			question.setList(list);			
			questionService.saveOrUpdate(question);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return SUCCESS;
	}
	
	public String update() {		
		
		try {
			Integer id = question.getQid();
			Question quest = questionService.query(id);
			result=JSONArray.toJSONString(quest);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return SUCCESS;
	}
	
	public String delete() {
		Integer id=question.getQid();
		try {
			questionService.delete(question);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return SUCCESS;
		
	}
	
	public String query() {		
		try {
			
			PageBean pageBean = new PageBean();
			//总记录数
			int count=questionService.getCount(question);
			//当前页数
			String spagenumber=ServletActionContext.getRequest().getParameter("pageNumber");
			int pagenumber=Integer.parseInt(spagenumber==null?"1":spagenumber);	
			pageBean.setCount(count);//拿到总记录数
			pageBean.setPagesize(6);//每页记录数
			pageBean.setPageNumber(pagenumber);//拿到当前页数			
			List<Question> pagelist = questionService.pageBean(question,pageBean);
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("list", pagelist);
			map.put("pageBean", pageBean);
			//List<Question> list = questionService.query(question);			
			/*JSONArray json = JSONArray.fromObject(list);
			result=json.toString();*/
			result=JSONArray.toJSONString(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return SUCCESS;
	}
}
