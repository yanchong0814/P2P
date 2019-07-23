package com.hxzy.telexam.dao.interfaces;

import com.hxzy.telexam.bases.IBaseDao;
import com.hxzy.telexam.beans.Paper;
import com.hxzy.telexam.beans.Question;

import java.util.List;
import java.util.Map;

public interface IPaperDao extends IBaseDao<Paper> {
    List query(Integer type, Integer number,Integer qcourse,Integer qstage) throws Exception;
    List query(Integer id, boolean flags) throws Exception;
    List<Question> query(String qids, boolean flags) throws Exception;
    List<Paper> query(String sql,Integer flags)throws Exception;
}
