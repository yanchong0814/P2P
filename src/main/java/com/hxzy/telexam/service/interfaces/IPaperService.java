package com.hxzy.telexam.service.interfaces;

import com.hxzy.telexam.beans.Paper;
import com.hxzy.telexam.beans.Userinfo;

import java.util.List;
import java.util.Map;

public interface IPaperService {
    List<Paper> query(Paper paper,Userinfo userinfo) throws Exception;
    Paper query(String id,boolean flags) throws Exception;
    int saveOrUpdate(Paper paper) throws Exception;
    Map<String,Object> query(Map<String, Object> map) throws Exception;
    List query(String ids) throws Exception;
    void delete(Paper paper) throws Exception;
    List<Paper> query(Paper paper) throws Exception;
}
