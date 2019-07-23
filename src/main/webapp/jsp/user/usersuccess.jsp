<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>考试系统用户管理</title>
<link href="/telexam/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/telexam/js/jquery-2.2.4.js"></script>
<script type="text/javascript"
	src="/telexam/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">

	$(function(){
		$.ajax({
			type:"post",
			data:{"uname":"1"},
			url:"<%=path%>/stListAction.do",
			dataType:"json",
			success:function(result){
				var res=$.parseJSON(result);//将String 转为json格式
				gettable(res.list);
				getPage(res.pageBean);
			}
		});
})

function reload(){
		$.ajax({
			type:"post",
			data:{"uname":$("#txtName").val(),"telphone":$("#txtType").val()},
			url:"<%=path%>/stListAction.do",
			dataType:"json",
			success:function(result){
				var res=$.parseJSON(result);
				gettable(res.list);
				getPage(res.pageBean);
			}
		});
}
function getPage(pagebean){
	//拼分页
	var page=" 总计："+pagebean.count+" 条, &nbsp;总页数："+pagebean.pageCount+" 页, &nbsp;每页显示："+pagebean.pagesize+" 条, &nbsp;当前：第 -"+pagebean.pageNumber+"- 页"; 
    var sepage="<a href=\"javaScript:trunPage(1)\" >首页</a>&nbsp;&nbsp;"+
    	"<a href=\"javaScript:trunPage("+(pagebean.pageNumber-1)+")\">上一页</a>&nbsp;&nbsp;"+   
        "<a href=\"javaScript:trunPage("+(pagebean.pageNumber+1)+")\">下一页</a>&nbsp;&nbsp;"+ 
        "<a href=\"javaScript:trunPage("+pagebean.pageCount+")\">尾页</a>";
    $("#page").html(page);
	$("#sepage").html(sepage);
}
//分页方法
function trunPage(pageNum){
	$.ajax({
		type:"post",
		data:{"pageNumber":pageNum,"qtype":$("#txtType").val(),"uname":$("#txtname").val()},
		url:"<%=path%>/UserinfoQueryAction.do",
			dataType : "json",
			success : function(result) {
				alert("sd");
				var res = $.parseJSON(result);//将String 转为json格式
				gettable(res.list);
				getPage(res.pageBean);
			}
		});
	}
	
<%-- function gettable(list){	
	//查询数据库，返回集合
	var html=" <thead><tr class=\"success\ align=\"center\"> "+          
		" <th>用户名</th><th>性别</th><th>电话</th><th>地址</th><th>编辑/删除</th> "+  
		" </tr></thead> ";
    var temp="";
	//动态拼，循环
	for(var i in list){
		var stu=list[i]; 
			temp+=" <tr> "+
			" <td width=\"160\">"+stu.uname+"</td> "+ 
			" <td width=\"70\">"+stu.sex+"</td> "+     
			" <td width=\"150\">"+telphone+"</td> "+
			" <td width=\"300\">"+stu.address+"</td> "+
			" <td width=\"120\"><a href=\"<%=path%>/toUpdateAction.do?uid=${('"+stu.uid+"')}\"> 编辑 </a> &nbsp;&nbsp;<a href=\"<%=path%>stdeleteAction.do?uid=${('"+stu.uid+"')}\" > 删除 </a></td> "+
			" </tr> ";
	}       
	$("table").html(html+temp);		
	
} --%>
</script>
</head>

<body>
	<div style="margin-top: 16px;">
		<fieldset style="width: 80%; margin: 0px auto;">
			<legend>用户信息</legend>
			<div class="row">
				<div style="width: 90%; margin-left: 2%;">
					<form action="query.action" method="post">
						<label>用户名</label> <input type="text" id="txtName"
							 placeholder="请输入名称(模糊搜索)" style="width: 20%;" />
						<button type="button">查询</button>
						<input type="button" value="添加"
							onclick="window.location.href='<%=path%>/jsp/user/saveOrUpdate.jsp'" />
					</form>
				</div>
				<div style="width: 98%; margin: 0 auto;">
					<table align="center"
						class="table table-bordered table-hover table-condensed">
						<thead>
						<tr class="success" align="center">
							<td width="70"><b>用户名</b></td>
							<td width="60" align="center"><b>性别</b></td>
							<td width="150"><b>电话</b></td>
							<td width="300"><b>地址</b></td>
							<td width="120"><b>编辑/删除</b></td>
						</tr>
						</thead>
						<c:forEach items="${list}" var="stu">
							
							<tr>
								<td width="160">${stu.uname}</td>
								<td width="70" align="center">${stu.sex }</td>
								<td width="150" align="center">${stu.telphone }</td>
								<td width="300">${stu.address}</td>
								<td width="120" align="center"><a
									href="<%=path %>/toUpdateAction.do?uid=${stu.uid}">编辑</a>&nbsp;&nbsp;
									<a href="<%=path %>/stdeleteAction.do?uid=${stu.uid}">删除</a></td>
							</tr>  
							
						</c:forEach>
					</table> 
				</div>
				<div>
					<div id="pege" style="display: inline-block; float: left;"></div>
					<div id="sepege" style="display: inline-block; float: right;"></div>
				</div>
			</div>
			
		</fieldset>
		</div>
</body>
</html>