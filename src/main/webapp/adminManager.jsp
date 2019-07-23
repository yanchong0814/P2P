<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String path=request.getContextPath();
    %>
    <link href="<%=path%>/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="<%=path%>/js/jquery-2.2.4.js"></script>
    <script type="text/javascript" src="<%=path%>/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <title>考试后台管理系统</title>
    <script type="text/javascript">

    </script>
    <style>

    </style>
</head>
<frameset rows="80px,*,50px" frameborder="yes" border="1" framespacing="1">
    <frameset  frameborder="yes" border="1" framespacing="1">
        <frame src="jsp/main/top.jsp"/>
    </frameset>
    <frameset cols="220px,*" frameborder="yes" border="0"framespacing="1" style="padding-top: 0px">
        <frame src="<%=path%>/jsp/main/left.jsp" noresize scrolling="no" style="margin-top: 0px;padding-top: 0px"/>
        <frame src="jsp/main/right.jsp" name="rightframe"/>
    </frameset>
    <frameset  frameborder="yes" border="1" framespacing="1">
        <frame src="jsp/main/foot.jsp"/>
    </frameset>
</frameset>
</html>
