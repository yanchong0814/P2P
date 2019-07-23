package com.hxzy.telexam.dao.implement;

import com.hxzy.telexam.bases.BaseDao;
import com.hxzy.telexam.beans.Paper;
import com.hxzy.telexam.beans.Question;
import com.hxzy.telexam.dao.interfaces.IPaperDao;
import org.hibernate.*;
import org.hibernate.transform.Transformers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PaperDao extends BaseDao<Paper> implements IPaperDao {
    @Autowired
    private SessionFactory sessionFactory;
    private Session session;

    @Override
    public List query(Integer type,Integer number,Integer qcourse,Integer qstage) throws Exception{
        session = sessionFactory.getCurrentSession();
        List list;
        String sql="select * from t_question t where 1=1 ";
        if(qcourse!=null&&!"".equals(qcourse)){
            sql+=" and t.qcourse = ? ";
        }
        if(qstage!=null&&!"".equals(qstage)){
            sql+=" and t.qstage = ? ";
        }
        if(type!=null&&!"".equals(type)){
            sql+=" and t.qtype = ? ";
        }
        sql+="order by rand() limit ? ";
        SQLQuery query=session.createSQLQuery(sql);
        int i=0;
        if(qcourse!=null&&!"".equals(qcourse)) {
            query.setParameter(i++, qcourse);
        }
        if(qstage!=null&&!"".equals(qstage)) {
            query.setParameter(i++, qstage);
        }
        if(type!=null&&!"".equals(type)) {
            query.setParameter(i++, type);
        }
        query.setParameter(i++,number);
        query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
        list=query.list();
        return list;
    }
    @Override
    public List query(Integer id,boolean flags) throws Exception{
        session = sessionFactory.getCurrentSession();
        List list;
        String sql="select qaid as qaid,qaname as qaname,qid as qid from t_questionanswer  where qid= ? order by qaname asc";
        SQLQuery query=session.createSQLQuery(sql);
        int i=0;
        query.setParameter(i++,id);
        query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
        list=query.list();
        return list;
    }
    @Override
    public List query(String qids,boolean flags) throws Exception{
        session=sessionFactory.getCurrentSession();
        List list;
        if(flags){
            String hql="select * from t_question where qid in ("+qids+")";
            SQLQuery query=session.createSQLQuery(hql);
            query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
            list=query.list();
        }else{
            SQLQuery query=session.createSQLQuery(qids);
            query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
            list=query.list();
        }
        return list;
    }
    @Override
    public List query(String sql,Integer flags)throws Exception{
        session=sessionFactory.getCurrentSession();
        SQLQuery query=session.createSQLQuery(sql);
        query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
        List list=query.list();
        return list;
    }
}
