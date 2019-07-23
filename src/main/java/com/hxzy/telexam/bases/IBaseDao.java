package com.hxzy.telexam.bases;

import java.util.List;

public interface IBaseDao<T>{
    void saveOrUpdate(T t) throws Exception;
    void delete(T t) throws Exception;
    T query(Class<T> clazz,String id) throws Exception;
    List<T> query(String hql) throws Exception;
}
