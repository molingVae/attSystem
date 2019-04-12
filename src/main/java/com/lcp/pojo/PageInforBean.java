package com.lcp.pojo;

import lombok.Data;

import java.util.List;

@Data
public class PageInforBean {
	private int pageNum;//当前页码
	private int pageRecord;//每页显示的记录的条数
	private int startIndex;//每页显示的第一条记录的编号
	private int totalRecord;//一共需要显示的记录的总条数
	private List list;//要显示的记录的集合
	private int totalPage;//导航栏的总页数
	private int firstPageNum; //导航栏的开始页数
	private int lastPageNum;  //导航栏的结束页数
	
	//根据要显示的记录的总条数、每页显示的记录的条数、当前页码  计算导航栏的总页数、开始页数和结束页数，以及当前页的第一条记录编号
	//可以通过构造方法计算并赋值
	public PageInforBean(int pageNum, int pageRecord, int totalRecord) {
		super();
		this.pageNum = pageNum;
		this.pageRecord = pageRecord;
		this.totalRecord = totalRecord;
		
		//计算导航栏的总页数
		if(totalRecord%pageRecord==0){
			this.totalPage=totalRecord/pageRecord;
		}else{
			this.totalPage=totalRecord/pageRecord+1;
		}
		
		//默认设置导航栏中总共显示7页，则导航栏的开始页数和结束页数初始化为：
		this.firstPageNum=1;
		this.lastPageNum=7;
		
		//计算导航栏的开始页数
		if(totalPage<=7){  //如果记录总共需要显示的页数小于7页，那么，导航栏的第一页为初始值1即可，而最后一页为总共需要显示的页数。
			this.lastPageNum=totalPage;
		}else{    //如果记录总共需要显示的页数大于7页，又分为以下情况：
			//1.假设当前页定位在第4页，那么导航栏中的开始页和结束页：
			this.firstPageNum=pageNum-3;
			this.lastPageNum=pageNum+3;
		    //2.当前页处于第2页之前（当前页-1<0）时，这时，要从第1页开始显示,因为无法从负数进行显示
			if(pageNum-3<=0){
				this.firstPageNum=1;
				this.lastPageNum=7;
			}
			//3. 当前页是倒数最后一页时，那么导航栏最后一页应该为totalPage，然后往前显示7个
			if(lastPageNum>totalPage){
				this.lastPageNum=totalPage;
				this.firstPageNum=totalPage-6;
			}
		}
		
		//计算当前页的第一条记录编号
		this.startIndex=(pageNum-1)*pageRecord+1;
		
	}
	
	
	

	
	
	
	
	
	
}
