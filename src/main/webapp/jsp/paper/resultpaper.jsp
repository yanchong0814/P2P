<%--
  Created by IntelliJ IDEA.
  User: 家和万事兴
  Date: 2018/8/14
  Time: 22:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
    String scscores=request.getParameter("scscores");
    Long time=(long)(Long.parseLong(request.getParameter("scbetweentime"))/60000);
    String user=request.getParameter("user");
    String pid=request.getParameter("pid");
    pageContext.setAttribute("scscores", scscores);
    pageContext.setAttribute("scbetweentime",time);
    pageContext.setAttribute("user",user);
%>

<html>
<head>
    <link type="text/css" rel="stylesheet" href="<%=path%>/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <script type="text/javascript" src="<%=path%>/js/jquery-2.2.4.js"></script>
    <script type="text/javascript" src="<%=path%>/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <title>123</title>
</head>
<body>
<div class="container">
    <div class="jumbotron" style="text-align: center;margin-top: 50px">
        <h3>恭喜${user}答题完毕！总计用时${scbetweentime}分钟</h3>
        <h1><label style="font-size: large">您的成绩是</label><label style="color: red;margin-left: 20px;margin-right: 20px">${scscores}</label><label style="font-size: large">分</label></h1>

        <div style="border-top:1px black solid;margin-top:60px;padding-top:10px;font-size: large"><span id="time">5</span>&nbsp;秒后您将跳转到您的答题情况</div>
    </div>
    <script type="text/javascript">
       setTimeout("tochange(4000)",1000) ;
       function tochange(time) {
           $("#time").html(time/1000);
           time=time-1000;
           if(time<=0){
               location.href="<%=path%>/jsp/paper/examresultpaper.jsp?pid=<%=pid%>"
               clearTimeout(timeout);
               return false;
           }
           var timeout=setTimeout("tochange("+time+")",1000);
       }
    </script>
</div>
</body>
</html>
