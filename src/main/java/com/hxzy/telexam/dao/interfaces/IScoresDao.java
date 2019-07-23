package com.hxzy.telexam.dao.interfaces;

import java.util.List;

import com.hxzy.telexam.bases.IBaseDao;
import com.hxzy.telexam.beans.Scores;

/**
 * @author 家和万事兴
 * @Title: IScoresDao
 * @ProjectName telexam
 * @Description: TODO
 * @date 2018/8/1422:37
 */
public interface IScoresDao extends IBaseDao<Scores> {
    int save(Scores scores)throws Exception;
    List<Scores> query() throws Exception;
	public void delete(String id) throws Exception;
    String query(String sql,boolean flags)throws Exception;

}
