package com.hxzy.telexam.beans;

import java.io.Serializable;


public class PageBean implements Serializable {

	private static final long serialVersionUID = -1778221793599395834L;

	private int pageNumber;//当前第几页
	
	private int pagesize;//每页记录数
	
	private int StartRow;//起始行
	
	private int endRow;//终行
	
	private int pageCount;//总页数
	
	private int count;//总记录数
	

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getPageCount() {
		this.pageCount=count%pagesize==0?count/pagesize:count/pagesize+1;
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		getPageCount();
		if(pageNumber<=1){
			this.pageNumber=1;
		}else if(pageNumber>=pageCount){
			this.pageNumber=pageCount;
		}else{
			this.pageNumber = pageNumber;
		}
	}

	public int getPagesize() {
		return pagesize;
	}

	public void setPagesize(int pagesize) {
		this.pagesize = pagesize;
	}
//?
	public int getStartRow() {
		this.StartRow=(pageNumber-1)*pagesize;
		return StartRow;
	}

	public void setStartRow(int startRow) {
		StartRow = startRow;
	}
//?
	public int getEndRow() {
		this.endRow=pageNumber*pagesize;
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	@Override
	public String toString() {
		return "PageBean [pageNumber=" + pageNumber + ", pagesize=" + pagesize + ", StartRow=" + StartRow + ", endRow="
				+ endRow + ", pageCount=" + pageCount + ", count=" + count + "]";
	}

}
