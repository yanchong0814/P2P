<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>


<!-- String name=((User)session.getAttribute("user")).getUname();
String utid=((UserType)session.getAttribute("user")).getUtid(); -->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
    String path=request.getContextPath();
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>头部页面</title>
    <link type="text/css" rel="stylesheet" href="<%=path%>/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <script type="text/javascript" src="<%=path%>/js/jquery-2.2.4.js"></script>
    <script type="text/javascript" src="<%=path%>/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <style type="text/css">
        /*div {
            background-image: url("");
            width: 100%;
            height: 100%;
        }*/
    </style>
</head>
<body>
<div class="container" style="width: 100%;height: 100%">
    <div style="margin-left: 50px;margin-top:5px;text-align: center">
        <h2>欢迎登陆考试后台管理程序</h2>
    </div>
    <div id="show_time"
         style="width:250px;height:2em;border:0px black solid;position:absolute;right: 20px;bottom: 5px;">
    </div>
</div>
</body>
<script type="text/javascript">
    //这里代码多了几行，但是不会延迟显示，速度比较好，格式可以自定义，是理想的时间显示
    setInterval("fun(show_time)", 1);
    function fun(timeID) {
        var date = new Date();  //创建对象
        var y = date.getFullYear();     //获取年份
        var m = date.getMonth() + 1;   //获取月份  返回0-11
        var d = date.getDate(); // 获取日
        var w = date.getDay();   //获取星期几  返回0-6   (0=星期天)
        var ww = ' 星期' + '日一二三四五六'.charAt(new Date().getDay());//星期几
        var h = date.getHours();  //时
        var minute = date.getMinutes()  //分
        var s = date.getSeconds(); //秒
        var sss = date.getMilliseconds(); //毫秒
        if (m < 10) {
            m = "0" + m;
        }
        if (d < 10) {
            d = "0" + d;
        }
        if (h < 10) {
            h = "0" + h;
        }
        if (minute < 10) {
            minute = "0" + minute;
        }
        if (s < 10) {
            s = "0" + s;
        }
        if (sss < 10) {
            sss = "00" + sss;
        } else if (sss < 100) {
            sss = "0" + sss;
        }
        document.getElementById(timeID.id).innerHTML = y + "-" + m + "-" + d + "   " + h + ":" + minute + ":" + s + "  " + ww;
//document.write(y+"-"+m+"-"+d+"   "+h+":"+minute+":"+s);
    }
</script>
</html>
