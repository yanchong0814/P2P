package com.hxzy.telexam.service.interfaces;

import java.util.List;

import com.hxzy.telexam.beans.Scores;

/**
 * @author 家和万事兴
 * @Title: IScoresService
 * @ProjectName telexam
 * @Description: TODO
 * @date 2018/8/1422:34
 */
public interface IScoresService {
    int saveOrUpdate(Scores scores) throws Exception;
    List<Scores> list() throws Exception;
	public void delete(String id)throws Exception;
    String queryPaper(String pid,String uid)throws Exception;
}
