package com.hxzy.telexam.dao.implement;

import java.util.List;


import org.apache.commons.lang3.StringUtils;

import com.hxzy.telexam.bases.BaseDao;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.transform.Transformers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hxzy.telexam.beans.PageBean;
import com.hxzy.telexam.beans.Question;
import com.hxzy.telexam.beans.Userinfo;
import com.hxzy.telexam.dao.interfaces.IUserinfoDao;

@Repository
public class UserinfoDaoImpl extends BaseDao<Userinfo> implements IUserinfoDao {
	@Autowired
	private SessionFactory sessionFactory;
	private Session session;

	@Override
	public void add(Userinfo userinfo) throws Exception {
		session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(userinfo);
	}

	@Override
	public void delete(String id) throws Exception {
		session = sessionFactory.getCurrentSession();
		Userinfo st = new Userinfo();
		st.setUid(id);
		session.delete(st);
	}

	@Override
	public List<Userinfo> query(Userinfo userinfo) throws Exception {
		session = sessionFactory.getCurrentSession();
		String hql = "from Userinfo";
		Query query = session.createQuery(hql);
		// query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
		List<Userinfo> list = query.list();
		return list;
	}

	@Override
	public Userinfo toUpdate(Userinfo userinfo) throws Exception {
		session = sessionFactory.getCurrentSession();
		userinfo = (Userinfo) session.get(Userinfo.class, userinfo.getUid());
		return userinfo;
	}

	@Override
	public Userinfo getUserByNameAndPassword(Userinfo user) {
		session = sessionFactory.getCurrentSession();
		String hql = "from Userinfo where Uname=? and password = ? and utype = ? ";
		Query query = session.createQuery(hql)
				.setParameter(0, user.getUname())
				.setParameter(1, user.getPassword())
				.setParameter(2, user.getUtype());
		Userinfo userinfo = (Userinfo) query.uniqueResult();
		return userinfo;
		/*
		 * List list = (List) query.list(); if (list.size() > 0) { return true; } return
		 * false;
		 */
	}
	
	@Override
	public List<Userinfo> querys(Userinfo userinfo) throws Exception {
		session = sessionFactory.getCurrentSession();
		String hql = " select u.uid as uid,u.uname as uname,u.sex as sex,u.telphone as telphone,"
				+ "u.utype as utype from Userinfo u where 1=1 ";
		if(StringUtils.isNoneEmpty(userinfo.getTelphone())) {
			hql=hql+"and u.Telphone = ?";
		}
		if(StringUtils.isNoneEmpty(userinfo.getUname())) {
			hql=hql+"and u.Uname like ?";
		}
		int k=0;
		Query query = session.createQuery(hql);
		query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
		if(StringUtils.isNotEmpty(userinfo.getTelphone())) {
			query.setParameter(k++, userinfo.getTelphone());
		}
		if(StringUtils.isNotEmpty(userinfo.getUname())) {
			query.setParameter(k++, "%"+userinfo.getUname()+"%");
		}
		List<Userinfo> list = query.list();
		return list;
	}


	@Override
	public List<Userinfo> pageBean(Userinfo userinfo, PageBean pageBean) throws Exception {
		session = sessionFactory.getCurrentSession();

		String hql = "from Userinfo u where 1=1 ";

		if (StringUtils.isNoneEmpty(userinfo.getTelphone())) {
			hql += "and u.Telphone = ?";
		}
		if (StringUtils.isNoneEmpty(userinfo.getUname())) {
			hql += "and u.uname like ?";
		}
		hql += " order by u.uid desc";
		int k = 0;
		Query querypage = session.createQuery(hql);

		if (StringUtils.isNotEmpty(userinfo.getTelphone())) {
			querypage.setParameter(k++, userinfo.getTelphone());
		}
		if (StringUtils.isNotEmpty(userinfo.getUname())) {
			querypage.setParameter(k++, "%" + userinfo.getUname() + "%");
		}

		querypage.setMaxResults(pageBean.getPagesize());
		querypage.setFirstResult(pageBean.getStartRow());

		List<Userinfo> list = querypage.list();

		return list;

	}

	@Override
	public int getCount(Userinfo userinfo) {
		session = sessionFactory.getCurrentSession();

		String hqlcount = "select count(*) from Userinfo u where 1=1 ";
		if (StringUtils.isNoneEmpty(userinfo.getTelphone())) {
			hqlcount += "and u.Telphone = ?";
		}
		if (StringUtils.isNoneEmpty(userinfo.getUname())) {
			hqlcount += "and u.uname like ?";
		}

		int k = 0;
		Query querycount = session.createQuery(hqlcount);

		if (StringUtils.isNotEmpty(userinfo.getTelphone())) {
			querycount.setParameter(k++, userinfo.getTelphone());
		}
		if (StringUtils.isNotEmpty(userinfo.getUname())) {
			querycount.setParameter(k++, "%" + userinfo.getUname() + "%");
		}

		Integer Count = Integer.parseInt(querycount.uniqueResult().toString());

		return Count;
	}

}
