package com.hxzy.telexam.service.implement;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.hxzy.telexam.beans.PageBean;
import com.hxzy.telexam.beans.Question;
import com.hxzy.telexam.beans.QuestionAnswer;
import com.hxzy.telexam.dao.interfaces.IQuestionDao;
import com.hxzy.telexam.service.interfaces.IQuestionService;

@Service
public class QuestionServiceImpl implements IQuestionService {
	@Autowired
	private IQuestionDao questionDao;

	@Override
	@Transactional(propagation= Propagation.REQUIRED,isolation= Isolation.READ_COMMITTED,rollbackFor={Exception.class,RuntimeException.class})//标识开启事务
	public void saveOrUpdate(Question question) throws Exception {
		if(question.getQid()!=null) {			
			//questionDao.delete(question);
			String hql = "delete from QuestionAnswer qa where qa.quest.qid = ?";
			questionDao.delete(question, hql);
		}		
		questionDao.saveOrUpdate(question);
	}

	@Override
	@Transactional(propagation= Propagation.REQUIRED,isolation= Isolation.READ_COMMITTED,rollbackFor={Exception.class,RuntimeException.class})
	public List<Question> query(Question question) throws Exception {		
		
		return questionDao.query(question);
	}

	@Override
	@Transactional(propagation= Propagation.REQUIRED,isolation= Isolation.READ_COMMITTED,rollbackFor={Exception.class,RuntimeException.class})
	public void delete(Question question) throws Exception {
		String hql = "delete from QuestionAnswer qa where qa.quest.qid = ?";
		questionDao.delete(question, hql);
		questionDao.delete(question);
	}

	@Override
	@Transactional(propagation= Propagation.REQUIRED,isolation= Isolation.READ_COMMITTED,rollbackFor={Exception.class,RuntimeException.class})
	public void update(Question question) throws Exception {

		questionDao.saveOrUpdate(question);
	}

	@Override
	@Transactional(propagation= Propagation.REQUIRED,isolation= Isolation.READ_COMMITTED,rollbackFor={Exception.class,RuntimeException.class})
	public Question query(Integer id) throws Exception {
		
		return questionDao.query(id);
	}

	@Override
	@Transactional(propagation= Propagation.REQUIRED,isolation= Isolation.READ_COMMITTED,rollbackFor={Exception.class,RuntimeException.class})
	public int getCount(Question question) throws Exception {
		
		return questionDao.getCount(question);
	}

	@Override
	@Transactional(propagation= Propagation.REQUIRED,isolation= Isolation.READ_COMMITTED,rollbackFor={Exception.class,RuntimeException.class})
	public List<Question> pageBean(Question question,PageBean pageBean) throws Exception {

		return questionDao.pageBean(question,pageBean);
	}

}
