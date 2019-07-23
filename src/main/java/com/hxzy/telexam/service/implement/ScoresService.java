package com.hxzy.telexam.service.implement;

import com.hxzy.telexam.beans.Scores;
import com.hxzy.telexam.dao.interfaces.IScoresDao;
import com.hxzy.telexam.service.interfaces.IScoresService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ScoresService implements IScoresService {
	@Autowired
	private IScoresDao scoresDao;

	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {
			Exception.class, RuntimeException.class })
	public int saveOrUpdate(Scores scores) throws Exception {
		return scoresDao.save(scores);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {
			Exception.class, RuntimeException.class })
	public List<Scores> list() throws Exception {
		return scoresDao.query();
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {
			Exception.class, RuntimeException.class })
	public void delete(String id) throws Exception {
		scoresDao.delete(id);
	}
    @Override
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {
            Exception.class, RuntimeException.class })
	public String queryPaper(String pid,String uid)throws Exception{
		String sql="select myanswer from t_scores where pid='"+pid+"' and uid='"+uid+"'";
		String myanswer=scoresDao.query(sql,true);
		return myanswer;
	}
}
