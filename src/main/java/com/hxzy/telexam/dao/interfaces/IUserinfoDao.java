package com.hxzy.telexam.dao.interfaces;

import java.util.List;
import com.hxzy.telexam.beans.PageBean;
import com.hxzy.telexam.beans.Question;

import com.hxzy.telexam.bases.IBaseDao;

import com.hxzy.telexam.beans.Userinfo;

public interface IUserinfoDao extends IBaseDao<Userinfo> {

	public void add(Userinfo user) throws Exception;

	public void delete(String id) throws Exception;

	public List<Userinfo> query(Userinfo user) throws Exception;

	public Userinfo toUpdate(Userinfo user) throws Exception;

	public Userinfo getUserByNameAndPassword(Userinfo user);

	List<Userinfo> pageBean(Userinfo userinfo, PageBean pageBean) throws Exception;

	public int getCount(Userinfo userinfo);
	
	public List<Userinfo> querys(Userinfo userinfo) throws Exception;

}
