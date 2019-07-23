package com.hxzy.telexam.service.implement;

import com.hxzy.telexam.beans.PageBean;
import com.hxzy.telexam.beans.Userinfo;
import com.hxzy.telexam.dao.interfaces.IUserinfoDao;
import com.hxzy.telexam.service.interfaces.IUserinfoService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserinfoServiceImpl<T> implements IUserinfoService {
	@Autowired
	private IUserinfoDao usertionDao;

	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {
			Exception.class, RuntimeException.class }) // 标识开启事务
	public void add(Userinfo userinfo) throws Exception {
		String id = userinfo.getUid();
		id = StringUtils.isNotEmpty(id) ? id : null;
		userinfo.setUid(id);
		usertionDao.add(userinfo);
	}

	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {
			Exception.class, RuntimeException.class })
	public void delete(String id) throws Exception {
		usertionDao.delete(id);
	}

	@Override
	@Transactional(propagation = Propagation.NEVER, isolation = Isolation.READ_COMMITTED, rollbackFor = {
			Exception.class, RuntimeException.class })
	public List<Userinfo> query(Userinfo userinfo) throws Exception {
		return usertionDao.query(userinfo);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {
			Exception.class, RuntimeException.class })
	public Userinfo toUpdate(Userinfo userinfo) throws Exception {
		return usertionDao.toUpdate(userinfo);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {
			Exception.class, RuntimeException.class })
	public Userinfo getUserByNameAndPassword(Userinfo user) {
		return usertionDao.getUserByNameAndPassword(user);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {
			Exception.class, RuntimeException.class })
	public List<Userinfo> pageBean(Userinfo userinfo, PageBean pageBean) throws Exception {
		return usertionDao.pageBean(userinfo, pageBean);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {
			Exception.class, RuntimeException.class })
	public int getCount(Userinfo userinfo) {
		return usertionDao.getCount(userinfo);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {
			Exception.class, RuntimeException.class })
	public List<Userinfo> query() throws Exception {
		return usertionDao.query("from Userinfo");
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {
			Exception.class, RuntimeException.class })
	public List<Userinfo> querys(Userinfo userinfo) throws Exception {
		return usertionDao.querys(userinfo);
	}

}
