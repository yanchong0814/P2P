package com.hxzy.telexam.beans;

import org.hibernate.annotations.GenericGenerator;
import javax.persistence.*;
import java.util.List;

@Entity(name = "Ztree")
@Table(name = "t_ztree")
public class Ztree {
	private String id;
	private String name;
	private String pid;
	private String url;
	private String target;
	private List<Ztree> child;

	public Ztree() {}
	public Ztree(String id, String name, String pid, String url, String target) {
		super();
		this.id = id;
		this.name = name;
		this.pid = pid;
		this.url = url;
		this.target = target;
	}
	@Transient
	public List<Ztree> getChild() {
		return child;
	}
	public void setChild(List<Ztree> child) {
		this.child = child;
	}
	@Id
	@GenericGenerator(name="generator",strategy = "uuid")
	@GeneratedValue(generator = "generator")
	@Column(name="id")
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Column(name="name")
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Column(name="pid")
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	@Column(name="url")
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	@Column(name="target")
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	@Override
	public String toString() {
		return "Ztree [id=" + id + ", name=" + name + ", pid=" + pid + ", url=" + url + ", target=" + target
				+ ", child=" + child + "]";
	}
}
