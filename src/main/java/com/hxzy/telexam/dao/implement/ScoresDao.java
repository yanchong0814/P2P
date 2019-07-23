package com.hxzy.telexam.dao.implement;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hxzy.telexam.bases.BaseDao;
import com.hxzy.telexam.beans.Scores;
import com.hxzy.telexam.beans.Userinfo;
import com.hxzy.telexam.dao.interfaces.IScoresDao;

@Repository
public class ScoresDao extends BaseDao<Scores> implements IScoresDao {
    @Autowired
    private SessionFactory sessionFactory;
    private Session session;
    public int save(Scores scores)throws Exception{
        String sql="insert into t_scores (begintime,betweentime,scores,scid,pid,uid,myanswer) values (?,?,?,?,?,?,?)";
        session=sessionFactory.getCurrentSession();
        SQLQuery query=session.createSQLQuery(sql);
        query.setParameter(0, scores.getScbegintimes());
        query.setParameter(1, scores.getScbetweentime());
        query.setParameter(2, scores.getScscores());
        query.setParameter(3, scores.getScid());
        query.setParameter(4, scores.getPaper().getPid());
        query.setParameter(5, scores.getUser().getUid());
        query.setParameter(6, scores.getMyanswer());
        int n=query.executeUpdate();
        return n;
    }
    @Override
    public List<Scores> query() throws Exception{
    	session=sessionFactory.getCurrentSession();
    	Query query=session.createQuery("from Scores");
    	return query.list();
    }

    public String query(String sql,boolean flags)throws Exception{
        session=sessionFactory.getCurrentSession();
        Query query=session.createSQLQuery(sql);
        String myanswer=(String)query.uniqueResult();
        return myanswer;
    }
	@Override
	public void delete(String id) throws Exception {
			session = sessionFactory.getCurrentSession();
			Scores st = new Scores();
			st.setScid(id);;
			session.delete(st);
		}
		
	}

