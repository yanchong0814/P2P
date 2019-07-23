<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<head>
<title>登录失败</title>
<style type="text/css">
  div{
     margin-top:100px;
     text-align: center;
     color: red;
     font-size: 20px;
  }
</style>
</head>

<body>
	
	<div>
	     登录失败，2秒后自动转到登录页面...
	</div>
	<script type="text/javascript">
		setTimeout(reDo, 2000);
		function reDo() {
			window.location.href = "index.jsp";
		}
	</script>
</body>
</html>
