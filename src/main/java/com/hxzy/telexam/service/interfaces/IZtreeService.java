package com.hxzy.telexam.service.interfaces;

import java.util.List;

import com.hxzy.telexam.beans.Ztree;

public interface IZtreeService {
    public List<Ztree> query(Ztree ztree) throws Exception;
}

