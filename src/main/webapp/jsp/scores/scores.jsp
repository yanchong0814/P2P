<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<link href="<%=path%>/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script type="text/javascript" src="<%=path%>/js/jquery-2.2.4.js"></script>
<script type="text/javascript"
	src="<%=path%>/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<title>考试系统用户管理</title>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</head>
<body>
	
	<div style="margin-top: 16px;">
	<fieldset style="width: 90%; margin: 0px auto;">
		<legend>成绩管理</legend>
		<div class="row">
		    <form action="<%=path%>/queryAction.do" method="post">
				<div style="width: 90%;margin-left: 2%;">
						<label>学生姓名:</label> <input type="text" id="txtName" placeholder="请输入学生姓名(模糊搜索)" style="width: 20%;"/>
						<label>试卷名称</label> <input type="text" id="txtName" placeholder="请输入试卷名称(模糊搜索)" style="width: 20%;"/>	
						<button name="buttoncx" type="button">查询</button>
				</div>
			</form>
			<div style="width: 98%; margin: 0 auto;">
				<table align="center" class="table  table-bordered table-hover table-condensed" >
					<tr class="success" align="center">
						<td width="70">学生姓名</td>
						<td width="160">試卷名称</td>
						<td width="70">试卷时长</td>
						<td width="50">考试成绩</td>
						<td width="150">考试开始时间</td>
						<td width="70">考试用时</td>
						<td width="120">删除</td>
					</tr>
					<c:forEach items="${list}" var="stu">
						<tr height="24px" align="center">
							<td width="70">${stu.user.uname}</td>
							<td width="160" align="center">${stu.paper.pname }</td>
							<td width="70" align="center">${stu.paper.ptimes}</td>
							<td width="50">${stu.scscores }</td>
							<td width="150" align="center">${stu.scbegintimes}</td>
							<td width="70">${stu.scbetweentime/60000}分钟</td>
							<td  align="center"><a href="<%=path%>/scores/scdeleteAction.do?scid=${stu.scid}">删除</a></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</fieldset>
	</div>
</body>
</html>