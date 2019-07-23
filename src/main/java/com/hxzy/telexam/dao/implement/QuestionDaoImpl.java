package com.hxzy.telexam.dao.implement;


import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.transform.Transformers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.hxzy.telexam.beans.PageBean;
import com.hxzy.telexam.beans.Question;
import com.hxzy.telexam.dao.interfaces.IQuestionDao;
/*
 * @chin 
 * 实现IQuestionDao 接口，继承BaseBao实现类
*/
@Repository
public class QuestionDaoImpl implements IQuestionDao{
	
	@Autowired
	private SessionFactory sessionFactory;
	
	private Session session ;

	@Override
	public void delete(Question question) throws Exception {		
		session = sessionFactory.getCurrentSession();
		session.delete(question);
	}

	@Override
	public List<Question> query(Question question) throws Exception {
		session = sessionFactory.getCurrentSession();
		String hql = " select q.qid as qid,q.qname as qname,q.qtype as qtype,qanswer as qanswer,"
				+ "qscore as qscore from Question q where 1=1 ";
		if(StringUtils.isNoneEmpty(question.getQtype())) {
			hql=hql+"and q.qtype = ?";
		}
		if(StringUtils.isNoneEmpty(question.getQname())) {
			hql=hql+"and q.qname like ?";
		}
		int k=0;
		Query query = session.createQuery(hql);
		query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
		if(StringUtils.isNotEmpty(question.getQtype())) {
			query.setParameter(k++, question.getQtype());
		}
		if(StringUtils.isNotEmpty(question.getQname())) {
			query.setParameter(k++, "%"+question.getQname()+"%");
		}
		List<Question> list = query.list();
		return list;
	}

	@Override
	public Question query(Integer id) throws Exception {
		session = sessionFactory.getCurrentSession();
		String hql = " from Question where qid= ? ";
		Query query = session.createQuery(hql);		
		query.setParameter(0, id);
		Question question = (Question) query.uniqueResult();
		return question;
	}

	@Override
	public void delete(Question question, String hql) throws Exception {
		session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		query.setParameter(0, question.getQid());
		query.executeUpdate();
	}

	@Override
	public void saveOrUpdate(Question question) throws Exception {
			session = sessionFactory.getCurrentSession();
			session.saveOrUpdate(question);	
	}

	@Override
	public List<Question> pageBean(Question question,PageBean pageBean) throws Exception {
		
	    session = sessionFactory.getCurrentSession();
	    
	    String hql="from Question q where 1=1 ";
	    
	    if(StringUtils.isNoneEmpty(question.getQcourse()+"")) {
			hql+="and q.qcourse = ?";
		}
	    if(StringUtils.isNoneEmpty(question.getQstage()+"")) {
			hql+="and q.qstage = ?";
		}
	    if(StringUtils.isNoneEmpty(question.getQtype())) {
	    	hql+="and q.qtype = ?";
		}
		if(StringUtils.isNoneEmpty(question.getQname())) {
			hql+="and q.qname like ?";
		}
		hql+=" order by q.qid desc";
		int k=0;
	    Query querypage=session.createQuery(hql);
	    
	    if(StringUtils.isNoneEmpty(question.getQcourse()+"")) {
	    	querypage.setParameter(k++, question.getQcourse());
		}
	    if(StringUtils.isNoneEmpty(question.getQstage()+"")) {
	    	querypage.setParameter(k++, question.getQstage());
		}
	    if(StringUtils.isNotEmpty(question.getQtype())) {
	    	querypage.setParameter(k++, question.getQtype());
		}
		if(StringUtils.isNotEmpty(question.getQname())) {
			querypage.setParameter(k++, "%"+question.getQname()+"%");
		}

	    querypage.setMaxResults(pageBean.getPagesize());	    
	    querypage.setFirstResult(pageBean.getStartRow());
	    List<Question> list=querypage.list();
	    return list;

	}
	
	@Override
	public int getCount(Question question) throws Exception {

	    session = sessionFactory.getCurrentSession();	
	    
	    String hqlcount="select count(*) from Question q where 1=1 ";    
	    if(StringUtils.isNoneEmpty(question.getQcourse()+"")) {
	    	hqlcount+="and q.qcourse = ?";
		}
	    if(StringUtils.isNoneEmpty(question.getQstage()+"")) {
	    	hqlcount+="and q.qstage = ?";
		}
	    if(StringUtils.isNoneEmpty(question.getQtype())) {
	    	hqlcount+="and q.qtype = ?";
		}
		if(StringUtils.isNoneEmpty(question.getQname())) {
			hqlcount+="and q.qname like ?";
		}
		
		int k=0;
		Query querycount = session.createQuery(hqlcount);
		
		if(StringUtils.isNoneEmpty(question.getQcourse()+"")) {
			querycount.setParameter(k++, question.getQcourse());
		}
	    if(StringUtils.isNoneEmpty(question.getQstage()+"")) {
	    	querycount.setParameter(k++, question.getQstage());
		}
	    if(StringUtils.isNotEmpty(question.getQtype())) {
	    	querycount.setParameter(k++, question.getQtype());
		}
		if(StringUtils.isNotEmpty(question.getQname())) {
			querycount.setParameter(k++, "%"+question.getQname()+"%");
		}
		
	    Integer Count=Integer.parseInt(querycount.uniqueResult().toString());
	    return Count;
	}
}
