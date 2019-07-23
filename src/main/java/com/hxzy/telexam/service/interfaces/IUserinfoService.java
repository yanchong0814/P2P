package com.hxzy.telexam.service.interfaces;

import java.util.List;

import com.hxzy.telexam.beans.PageBean;
import com.hxzy.telexam.beans.Question;
import com.hxzy.telexam.beans.Userinfo;

public interface IUserinfoService {
		
		void add(Userinfo user) throws Exception;
		
		void delete(String id)throws Exception;
		
		List<Userinfo> query(Userinfo user)throws Exception;

		Userinfo toUpdate(Userinfo user)throws Exception;
		
		Userinfo getUserByNameAndPassword(Userinfo user);
				
		public List<Userinfo> pageBean(Userinfo userinfo,PageBean pageBean) throws Exception;

		public int getCount(Userinfo userinfo)throws Exception;

		List<Userinfo> query() throws Exception;
		
		public List<Userinfo> querys(Userinfo userinfo) throws Exception;

}
