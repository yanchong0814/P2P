package com.hxzy.telexam.beans;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.GenericGenerator;

/**
 * 题目实体类
 */
@Entity(name="Question")
@Table(name="t_question")
public class Question {
    private Integer qid;//问题id
    private String qname;//问题描述
    private String qtype;//问题类型
    private String qanswer;//问题答案
    private Double qscore;//问题分值
    private Integer qstage;//阶段类别
    private Integer qcourse;//课程类别
    private List<QuestionAnswer> answer; //问题的备选项目  
    
    @OneToMany(targetEntity=QuestionAnswer.class,cascade=CascadeType.ALL,fetch=FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    @JoinColumn(name="qid")
    public List<QuestionAnswer> getList(){
		return answer;
	}
	public void setList(List<QuestionAnswer> list) {
		this.answer = list;
	}
	
	@Id
	@GenericGenerator(name="generator",strategy="identity")
	@GeneratedValue(generator="generator")
	@Column(name="qid")
	public Integer getQid() {
        return qid;
    }
    public void setQid(Integer qid) {
        this.qid = qid;
    }
    @Column(name="qname")
    public String getQname() {
        return qname;
    }
    public void setQname(String qname) {
        this.qname = qname;
    }
    @Column(name="qtype")
    public String getQtype() {
        return qtype;
    }
    public void setQtype(String qtype) {
        this.qtype = qtype;
    }
    @Column(name="qanswer")
    public String getQanswer() {
        return qanswer;
    }
    public void setQanswer(String qanswer) {
        this.qanswer = qanswer;
    }
    @Column(name="qscore")
    public Double getQscore() {
        return qscore;
    }
    public void setQscore(Double qscore) {
        this.qscore = qscore;
    }
    
    @Column(name="qstage")
	public Integer getQstage() {
		return qstage;
	}
	public void setQstage(Integer qstage) {
		this.qstage = qstage;
	}
	
	 @Column(name="qcourse")
	public Integer getQcourse() {
		return qcourse;
	}
	public void setQcourse(Integer qcourse) {
		this.qcourse = qcourse;
	}
	
	@Override
	public String toString() {
		return "Question [qid=" + qid + ", qname=" + qname + ", qtype=" + qtype + ", qanswer=" + qanswer + ", qscore="
				+ qscore + ", qstage=" + qstage + ", qcourse=" + qcourse + "]";
	}

}
