<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath(); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=path%>/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script type="text/javascript" src="<%=path%>/js/jquery-2.2.4.js"></script>
<script type="text/javascript"
	src="<%=path%>/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<title>右主页</title>
<style type="text/css">
a:link {
	color: #64a600;
	text-decoration: none;
}
a:visited {
	color: #8e8e8e;
	text-decoration: none;
}
a:hover {
	color: #ff2d2d;
	text-decoration: none;
}
a:active {
	color: #64a600;
	text-decoration: none;
}
</style>
</head>
<body  style="background-color: #F0F0F0;">
<div class="services" >
		<div style="width: 50%; margin: 0px auto ; margin-top: 120px; background-color: #f0f0f0">		
		<div class="row" align="center">
		<div class="col-md-4">
		<div><button type="button" onclick="javascrtpt:location.href='<%=path%>/user/saveOrUpdate.jsp'" style="border-style:none; background-repeat: no-repeat;  " >		
		<img src="/telexam/image/2.png" class="img-thumbnail" style="width: 140px; height: 140px;  "/></button></div>
		<div ><a href="<%=path%>/user/saveOrUpdate.jsp"><span><h4>考生管理</h4></span></a></div>
		</div>		
		<div class="col-md-4"> 
		<div><button type="button" onclick="javascrtpt:location.href='<%=path%>/scores/queryAction.do'" style="border-style:none; background-repeat: no-repeat;  " >		
		<img src="/telexam/image/8.png" class="img-thumbnail" style="width: 140px; height: 140px;  "/></button></div>
		<div ><a href="<%=path%>/scores/queryAction.do"><span><h4>成绩管理</h4></span></a></div>
		</div>
		<div class="col-md-4">
		<div><button type="button" onclick="javascrtpt:location.href='<%=path%>/stListAction.do'" style="border-style:none; background-repeat: no-repeat;  " >		
		<img src="/telexam/image/4.png" class="img-thumbnail" style="width: 140px; height: 140px;  "/></button></div>
		<div ><a href="<%=path%>/stListAction.do"><span><h4>管 理 员</h4></span></a></div>
		</div>		
		</div>
		<div class="row" align="center" style="margin-top: 30px;">
		<div class="col-md-3">
		<div><button type="button" onclick="javascrtpt:location.href='<%=path%>/jsp/questionanswer/questions.jsp'" style="border-style:none; background-repeat: no-repeat;  " >		
		<img src="/telexam/image/3.png" class="img-thumbnail" style="width: 120px; height: 120px;  "/></button></div>
		<div ><a href="<%=path%>/jsp/questionanswer/questions.jsp"><span><h4>题库查询</h4></span></a></div>
		</div>
		<div class="col-md-3">
		<div><button type="button" onclick="javascrtpt:location.href='<%=path%>/jsp/questionanswer/addOrUpdate.jsp'" style="border-style:none; background-repeat: no-repeat;  " >		
		<img src="/telexam/image/1.png" class="img-thumbnail" style="width: 120px; height: 120px;  "/></button></div>
		<div ><a href="<%=path%>/jsp/questionanswer/addOrUpdate.jsp"><span><h4>题库录入</h4></span></a></div>
		</div>
		<div class="col-md-3">
		<div><button type="button" onclick="javascrtpt:location.href='<%=path%>/jsp/paper/paper.jsp'" style="border-style:none; background-repeat: no-repeat;  " >		
		<img src="/telexam/image/5.png" class="img-thumbnail" style="width: 120px; height: 120px;  "/></button></div>
		<div ><a href="<%=path%>/jsp/paper/paper.jsp"><span><h4>生成试卷</h4></span></a></div>
		</div>
		<div class="col-md-3">
		<div><button type="button" onclick="javascrtpt:location.href='<%=path%>/paper/queryPaperAction.do'" style="border-style:none; background-repeat: no-repeat;  " >		
		<img src="/telexam/image/6.png" class="img-thumbnail" style="width: 120px; height: 120px;  "/></button></div>
		<div ><a href="<%=path%>/paper/queryPaperAction.do"><span><h4>试卷管理</h4></span></a></div>
		</div>
		</div>		
		</div>		
</div>
</body>
</html>