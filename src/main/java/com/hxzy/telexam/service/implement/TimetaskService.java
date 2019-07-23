package com.hxzy.telexam.service.implement;

import com.hxzy.telexam.beans.Paper;
import com.hxzy.telexam.dao.interfaces.IPaperDao;
import com.hxzy.telexam.service.interfaces.ITimetaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

@Service
public class TimetaskService implements ITimetaskService {
    @Autowired
    private IPaperDao paperDao;
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {
            Exception.class, RuntimeException.class })
    public void toPaperStatus() throws Exception{
        /*System.out.println("执行中");*/
        String hql="select * from t_paper where endtime<=current_timestamp and status='1'";
        List list=paperDao.query(hql,false);
        if(!(null==list||list.size()==0)){
            for(Object obj:list){
                Map map=(Map)obj;
                Paper paper=new Paper();
                paper.setPid((String) map.get("pid"));
                paper.setPname((String)map.get("pname"));
                System.out.println(map.get("ptimes"));
                paper.setPtimes(Long.valueOf(map.get("ptimes").toString()));//toString()与String强转区别
                paper.setQids((String)map.get("qids"));
                paper.setStatus("0");
                paper.setUrl((String)map.get("url"));
                paper.setPcourse((String)map.get("pcourse"));
                SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                Timestamp timestamp=new Timestamp(simpleDateFormat.parse(map.get("endtime").toString()).getTime());
                paper.setEndtime(timestamp);
                paperDao.saveOrUpdate(paper);
                System.out.println(paper);
            }
        }
    }
}
