<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>用户登录</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script src="js/jquery-2.2.4.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <style type="text/css">
        h3 {
            padding: 5px;
            border-bottom: 1px solid #ddd;
            /*h3字体下边框*/
        }
        em {
            /*强调的样式 */
            color: #c7254e;
            font-style: inherit;
            background-color: #f9f2f4;
        }
        .center {
            margin-left: auto;
            margin-right: auto;
            vertical-align: middle;
            text-align: center;
        }
    </style>
    <script type="text/javascript">
        $.ajax({
            type: "post",
            data: {},
            url: "<%=path%>/addDefaultUserAction.do",
            dataType: "json",
            success: function (res) {
                $("#welcome").html(res);
            }
        });
    </script>
</head>


<body style="background-image:url('<%=path%>/sourse/3.jpg');">
<center style="height: 504px; ">
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="javascript:void(0);"><span
                        class="glyphicon glyphicon-flag">学生考试系统</span></a>
            </div>
        </div>
    </nav>
    <div class="row center" style="margin-top: 100px; width: 1150px">
        <div class="col-md-5 col-sm-offset-4">
            <div class="well col-md-10" style="width: 390px; height: 280px">
                <h3 class=""> 用户登录</h3>
                <form action="<%=path%>/toLoginAction.do" method="post" style="width: 350px">
                    <div class="input-group input-group-md">
                        <span class="input-group-addon">
                            <i class="glyphicon glyphicon-user"></i>
                        </span>
                        <input type="text" class="form-control" name="userinfo.uname" placeholder="用户名"/>
                    </div>
                    <div class="input-group input-group-md">
                        <span class="input-group-addon">
                            <i class="glyphicon glyphicon-lock"></i>
                        </span>
                        <input type="password" class="form-control" name="userinfo.password" placeholder="密码"/>
                    </div>
                    <div style="float: left;margin-left: 10px">
                        <label>
                            <input type="checkbox" name="check">
                            <font size="1" color="adadad">&nbsp;记住密码</font>
                        </label>
                    </div>
                    <div style="float: right;margin-right: 2px">
                        <label><font size="1" color="adadad">用户类型：</font>
                            <select name="userinfo.utype" style="font-size: 10px">
                                <option value="1">考生</option>
                                <option value="0">管理员</option>
                            </select>
                        </label>
                    </div>
                    <div>
                        <label>
                            <input type="checkbox" name="check"/>
                            <font size="1" color="adadad">&nbsp;自动登录</font>
                        </label>
                    </div>
                    <input type="submit" class="btn btn-success btn-block" value="登录"/>
                    <br>
                    <div style="text-align: center;color: inherit" id="welcome"></div>
                </form>
            </div>
        </div>
    </div>
</center>
</body>
</html>
