package com.hxzy.telexam.beans;


import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * 考试成绩实体类
 */
@Entity
@Table(name = "t_scores")
public class Scores {
    private String scid;//成绩id
    private Userinfo user;//考生id
    private Paper paper;//试卷id
    private Double scscores;//考试成绩
    private Timestamp scbegintimes;//考试开始时间
    private Long scbetweentime;//考试用时
    private String myanswer;

    @Id
    @GenericGenerator(name = "generator",strategy = "uuid")
    @GeneratedValue(generator = "generator")
    @Column(name = "scid")
    public String getScid() {
        return scid;
    }
    public void setScid(String scid) {
        this.scid = scid;
    }

    @ManyToOne(targetEntity=com.hxzy.telexam.beans.Userinfo.class,cascade =CascadeType.ALL,fetch = FetchType.EAGER)
    @JoinColumn(name = "uid",insertable = false,updatable = false)
    public Userinfo getUser() {
        return user;
    }
    public void setUser(Userinfo user) {
        this.user = user;
    }
    @ManyToOne(targetEntity=com.hxzy.telexam.beans.Paper.class,cascade = CascadeType.ALL,fetch = FetchType.EAGER)
    @JoinColumn(name = "pid",insertable = false,updatable = false)
    public Paper getPaper() {
        return paper;
    }
    public void setPaper(Paper paper) {
        this.paper = paper;
    }
    @Column(name = "scores")
    public Double getScscores() {
        return scscores;
    }
    public void setScscores(Double scscores) {
        this.scscores = scscores;
    }
    @Column(name = "begintime")
    public Timestamp getScbegintimes() {
        return scbegintimes;
    }
    public void setScbegintimes(Timestamp scbegintimes) {
        this.scbegintimes = scbegintimes;
    }
    @Column(name = "betweentime")
    public Long getScbetweentime() {
        return scbetweentime;
    }
    public void setScbetweentime(Long scbetweentime) {
        this.scbetweentime = scbetweentime;
    }
    @Column(name="myanswer")
    public String getMyanswer() {
        return myanswer;
    }
    public void setMyanswer(String myanswer) {
        this.myanswer = myanswer;
    }

    @Override
    public String toString() {
        return "Scores{" +
                "scid=" + scid +
                ", user=" + user +
                ", paper=" + paper +
                ", scscores=" + scscores +
                ", scbegintimes=" + scbegintimes +
                ", scbetweentime=" + scbetweentime +
                ", myanswer=" + myanswer +
                '}';
    }
}
