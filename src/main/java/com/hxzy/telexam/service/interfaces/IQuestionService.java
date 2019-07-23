package com.hxzy.telexam.service.interfaces;

import java.util.List;

import com.hxzy.telexam.beans.PageBean;
import com.hxzy.telexam.beans.Question;

public interface IQuestionService {
	
	public void saveOrUpdate(Question question) throws Exception;
	
	public List<Question> query(Question question) throws Exception;
	
	public void delete(Question question) throws Exception;
	
	public void update(Question question) throws Exception;
	
	public Question query(Integer id) throws Exception;
	
	public List<Question> pageBean(Question question,PageBean pageBean) throws Exception;
	
	public int getCount(Question question) throws Exception; 
	
}
