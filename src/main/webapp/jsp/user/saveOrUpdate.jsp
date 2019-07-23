<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>学生信息管理</title>
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">  
	<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head> 
<body>
 
	<form action="<%=path%>/stAction.do" method="post">
		<input type="hidden" name="uid" value="${user.uid}">
		<table width="500" align="center">

			<tr height="26px">
			<br ><br ><br >
				<td width="150px" align="right">用户:</td>
				<td width="350px"><input type="hidden" name="param" value="1" />
					<input type="text" class="form-control" name="uname"
					value="${user.uname }" /><br ></td>
			</tr>
			<tr height="26px">
				<td align="right">密码:</td>
				<td><input class="form-control" type="password" name="password"
					value="${user.password }" /><br ></td>
			</tr>

			<tr height="26px">
				<td align="right">电话:</td>
				<td><input type="text" name="telphone" class="form-control"
					value="${user.telphone }" /><br ></td>
			</tr>
			<tr height="26px">
				<td align="right">地址:</td>
				<td><input type="text" name="address" class="form-control"
					value="${user.address }" /><br ></td>
			</tr>
			<tr height="26px" >  
				<td align="right" >性别:</td>
				<td><select name="sex"  style="width: 70px; height: 30px; ">
						<option value="男">男</option>
						<option value="女">女</option>
				</select><br><br></td>
				
			</tr>
			<tr height="26px">
				<td colspan="2" align="center" width="500"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;   <input type="submit" 
					 value="保存"  class="btn btn-primary" /> <input type="button" value="返回"  class="btn btn-primary"
					onclick="window.history.back(-1)" /></td>
			</tr>
		</table>
	</form>
</body>
</html>