
package com.hxzy.telexam.service.implement;

import com.hxzy.telexam.beans.Ztree;
import com.hxzy.telexam.dao.interfaces.IZtreeDao;
import com.hxzy.telexam.service.interfaces.IZtreeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class ZtreeService implements IZtreeService {
    @Autowired(required=true)
    private IZtreeDao ztreeDao;

    @Override
    @Transactional(propagation= Propagation.REQUIRED,isolation= Isolation.READ_COMMITTED,rollbackFor={Exception.class,RuntimeException.class})//标识开启事务
    public List<Ztree> query(Ztree ztree) throws Exception{
        String hql="from Ztree where pid="+ztree.getId();
        return ztreeDao.query(hql);
    }
}

