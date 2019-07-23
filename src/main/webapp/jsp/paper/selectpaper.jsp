<%@ page language="java" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>用户登录</title>
</head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>确认信息</title>
<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script src="js/jquery-2.2.4.js"></script>
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript">
    var resultdate=new Array();
    var resultlength;
    $(function () {
        $.ajax({
            type: "post",
            data: {"status": "1"},
            url: "<%=path%>/paper/PaperAction.do",
            dataType: "json",
            success: function (res) {
                getpaper(res);
            },
            error: function () {

            }
        });
    })

    function toexam(myid) {
        location.href = "<%=path%>/jsp/paper/exampaper.jsp?id=${userinfo.uid}&uname=${userinfo.uname}&pid=" + myid;
    }

    function getpaper(res) {
        var result = $.parseJSON(res);
        var temp = "";
        resultlength=result.length;
        for (var i = 0; i < result.length; i++) {
            var be=result[i].endtime-result[i].ptimes;
            resultdate[i]=new Date(be);
            temp += "<div class=\"row\" style=\"margin:50px auto;width: 800px;\">" +
                "<div class=\"col-lg-12\">" +
                "<div class=\"input-group\">" +
                "<input type=\"text\" class=\"form-control\" value=\"" + result[i].pname + "\" style=\"width: 700px;height: 50px;text-align: center;\" readonly>" +
                "<span class=\"input-group-btn\">" +
                "<button class=\"btn btn-danger\" type=\"button\" id=\"btn"+i+"\" onclick=\"toexam('" + result[i].pid + "')\"" +
                " style=\"height: 50px;display: none\">开始答题</button>" +
                "</span></div></div></div>";
        }
        $("#divselect").html(temp);
    }

    setInterval(function () {
        for(var i=0;i<resultlength;i++){
            var t=new Date();
            if(resultdate[i]<t){
                $("#btn"+i).show();
            }
        }
    },1000)
</script>
<style type="text/css">
    label {
        margin-left: 30px;
    }

    form {
        text-align: center;
        margin-top: 20px;
        border-bottom: 2px black solid;
        padding-bottom: 20px;
    }
</style>
<body>
<div style="font-size: x-large;" class="container">
    <div>
        <form class="form-inline" role="form">
            <input type="hidden" name="id" value="${userinfo.uid}"/>
            <label>考生姓名：${userinfo.uname}</label>
            <label>考生性别：${userinfo.sex}</label>
            <label>考生电话：${userinfo.telphone}</label>
            <label>考生地址：${userinfo.address}</label>
            <input type="hidden" name="utype" value="${userinfo.utype}"/>
        </form>
    </div>
    <div id="divselect" class="col-lg-12">

    </div>
</div>
</body>
</html>