package com.hxzy.telexam.beans;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Timestamp;

/**
 * 试卷实体类
 */
@Entity
@Table(name = "t_paper")
public class Paper {
    private String pid;//试卷id
    private String pname;//试卷描述
    private Long ptimes;//考试时长
    private String qids;//试卷问题集
    private String status;//试卷状态
    private String url;//附件地址
    private String pcourse;//试卷题目类别
    private Timestamp endtime;//过期时间

    @Id
    @GenericGenerator(name = "generator",strategy = "uuid")
    @GeneratedValue(generator="generator")
    @Column(name = "pid")
    public String getPid() {
        return pid;
    }
    public void setPid(String pid) {
        this.pid = pid;
    }
    @Column(name = "pname")
    public String getPname() {
        return pname;
    }
    public void setPname(String pname) {
        this.pname = pname;
    }
    @Column(name = "qids")
    public String getQids() {
        return qids;
    }
    public void setQids(String qids) {
        this.qids = qids;
    }
    @Column(name = "ptimes")
    public Long getPtimes() {
        return ptimes;
    }
    public void setPtimes(Long ptimes) {
        this.ptimes = ptimes;
    }
    @Column(name="status")
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    @Column(name="url")
    public String getUrl() {
        return url;
    }
    public void setUrl(String url) {
        this.url = url;
    }
    @Column(name = "pcourse")
    public String getPcourse() {
        return pcourse;
    }
    public void setPcourse(String pcourse) {
        this.pcourse = pcourse;
    }
    @Column(name = "endtime")
    public Timestamp getEndtime() {
        return endtime;
    }
    public void setEndtime(Timestamp endtime) {
        this.endtime = endtime;
    }

    @Override
    public String toString() {
        return "Paper{" +
                "pid=" + pid +
                ", pname=" + pname +
                ", ptimes=" + ptimes +
                ", qids=" + qids +
                ", status=" + status +
                ", url=" + url +
                ", pcourse=" + pcourse +
                ", endtime=" + endtime +
                "}";
    }
}