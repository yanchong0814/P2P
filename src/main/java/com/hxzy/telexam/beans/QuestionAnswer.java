package com.hxzy.telexam.beans;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 选项实体类
 */
@Entity(name="QuestionAnswer")
@Table(name="t_questionanswer")
public class QuestionAnswer {
    private Integer qaid;//选项id
    private Question quest; //题目id
    private String qaname;//选项描述
    
    @Id
	@GenericGenerator(name="generator",strategy="identity")
	@GeneratedValue(generator="generator")
	@Column(name="qaid")
	public Integer getQaid() {
		return qaid;
	}
	public void setQaid(Integer qaid) {
		this.qaid = qaid;
	}

	@Column(name="qaname")
	public String getQaname() {
		return qaname;
	}
	public void setQaname(String qaname) {
		this.qaname = qaname;
	}
	
	@ManyToOne(targetEntity=Question.class,cascade=CascadeType.ALL)
	@JoinColumn(name="qid")	
	public Question getQuest() {
		return quest;
	}
	public void setQuest(Question quest) {
		this.quest = quest;
	}
	@Override
	public String toString() {
		return "QuestionAnswer [qaid=" + qaid + ", quest=" + quest + ", qaname=" + qaname + "]";
	}

      
}
