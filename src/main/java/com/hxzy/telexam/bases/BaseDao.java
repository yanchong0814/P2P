package com.hxzy.telexam.bases;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
 
@Repository
public class BaseDao<T> implements IBaseDao<T> {
	
	@Autowired
	private SessionFactory sessionFactory;
	
	private Session session ;	
	
	@Override
	public void saveOrUpdate(T t) throws Exception {
		session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(t);
	}

	@Override
	public void delete(T t) throws Exception {
		session = sessionFactory.getCurrentSession();		
		session.delete(t);
	}
	
	@Override
	public T query(Class<T> clazz, String id) throws Exception {
		session = sessionFactory.getCurrentSession();
		T t = (T) session.get(clazz, id);
		return t;
	}

	@Override
	public List<T> query(String hql) throws Exception {
		session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);		
		List<T> list = query.list();
		return list;
	}

}
