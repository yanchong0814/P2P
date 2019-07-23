package com.hxzy.telexam.beans;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

/**
 * 用户信息
 */
@Entity
@Table(name = "userinfo")
public class Userinfo implements Serializable {

	private static final long serialVersionUID = 5866268712137826050L;
	/**用户id*/
	private String uid;
	/**用户名*/
	private String uname;
	/**性别*/
	private String sex;
	/**密码*/
	private String password;
	/**电话号码*/
	private String telphone;
	/**住址*/
	private String address;
	/**用户类型*/
	private String utype;
	/**学习课程*/
	private String ucourse;
/*    private Set<Scores> scores;*/
	public Userinfo() {
	}

    @Id
    @GenericGenerator(name = "generater",strategy = "uuid")
    @GeneratedValue(generator = "generater")
    @Column(name = "uid")
    public String getUid() {
        return this.uid;
    }
    public void setUid(String uid) {
        this.uid = uid;
    }

	@Column(name="utype")
	public String getUtype() {
		return utype;
	}
	public void setUtype(String utype) {
		this.utype = utype;
	}

	@Column(name = "uname")
	public String getUname() {
		return this.uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}

	@Column(name = "sex")
	public String getSex() {
		return this.sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}

	@Column(name="password")
	public String getPassword() {
		return this.password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "telphone")
	public String getTelphone() {
		return this.telphone;
	}
	public void setTelphone(String telphone) {
		this.telphone = telphone;
	}

	@Column(name = "address")
	public String getAddress() {
		return this.address;
	}
	public void setAddress(String address) {
		this.address = address;
	}

	@Column(name="ucourse")
	public String getUcourse() {
		return ucourse;
	}
	public void setUcourse(String ucourse) {
		this.ucourse = ucourse;
	}

	@Override
	public String toString() {
		return "Userinfo{" +
				"uid=" + uid +
				", uname=" + uname +
				", sex=" + sex +
				", password=" + password +
				", telphone=" + telphone +
				", address=" + address +
				", utype=" + utype +
				", ucourse=" + ucourse +
				"}";
	}
}