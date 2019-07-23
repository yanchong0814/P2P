package com.hxzy.telexam.dao.interfaces;

import java.util.List;

import com.hxzy.telexam.beans.PageBean;
import com.hxzy.telexam.beans.Question;

/*
 * @chin 
 * IQuestionDao 接口
*/
public interface IQuestionDao {
		
	public void delete(Question question) throws Exception;
	
	public List<Question> query(Question question) throws Exception;
	
	public Question query(Integer id) throws Exception;
	
	public void delete(Question question ,String hql) throws Exception;
	
	public void saveOrUpdate(Question question) throws Exception;
	
	public List<Question> pageBean(Question question,PageBean pageBean) throws Exception;
	
	public int getCount(Question question) throws Exception;
	
}

