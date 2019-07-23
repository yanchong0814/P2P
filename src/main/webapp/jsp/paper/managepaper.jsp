<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="org.apache.struts2.json.annotations.JSON" %>
<%@page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String result = (String) request.getAttribute("result");
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
    <title>Insert title here</title>
    <script type="text/javascript">
        $(function () {
            gettable(<%=result%>);
            $("#btnsave").click(function () {
                $("#formsave").submit();
            })
            $("#btnselect").click(function () {
                $("#formselect").submit();
            })
            $("[name='ptimetemp']").change(function () {
                $("[name='ptimes']").val(parseFloat($("[name='ptimetemp']").val())*3600000);
            })
            $("#filebtn").click(function () {
                $("#filename").click();
            })
        })
        function changetime(times){
            var date=new Date(times);
            var y = date.getFullYear();     //获取年份
            var m = date.getMonth() + 1;   //获取月份  返回0-11
            var d = date.getDate(); // 获取日
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
            return y+"-"+m+"-"+d+" "+h+":"+minute+":"+s+"."+sss;
        }
        function gettable(list) {
            var html = " <thead><tr class=\"success\"> " +
                " <th>序号</th><th>试卷描述</th><th>答题时间/h</th><th>附件状态</th><th>试卷类别</th><th>试卷状态</th><th>过期时间</th><th>管理操作</th> " +
                " </tr></thead> ";
            var temp = "";
            //动态拼，循环
            for (var i in list) {
                var obj = list[i];
                var newtime=changetime(obj.endtime);
                temp += " <tr> " +
                    " <td>" + (parseInt(i) + 1) + "</td> " +
                    " <td>" + obj.pname + "</td> " +
                    " <td>" + obj.ptimes / 3600000 + "</td> " +
                    " <td>" + obj.url + "</td> " +
                    " <td>" + obj.pcourse + "</td> " +
                    " <td>" + (obj.status == 1 ? "可用" : "过期") + "</td> " +
                    " <td>" + newtime + "</td> " +
                    " <td><a href=\"javaScript:\" onclick=\"toDelete('" + obj.pid + "')\"> 删除 </a> <a href=\"javaScript:\" onclick=\"toUpdate('" + obj.pid + "','" + obj.qids + "','" + obj.pname + "'," + obj.ptimes + ",'" + obj.status + "','" + obj.pcourse + "','" + newtime + "')\" > 修改 </a></td> " +
                    " </tr> ";
            }
            $("table").html(html + temp);
        }

        function toDelete(pid) {
            location.href = "<%=path%>/paper/deleteAction.do?pid=" + pid;
        }

        function toUpdate(pid,qids,pname,ptime,status,pcourse,endtime) {
            $("[name='pid']").val(pid);
            $("[name='qids']").val(qids);
            $("[name='pname']").val(pname);
            $("[name='ptimetemp']").val(ptime / 3600000);
            $("[name='ptimes']").val(ptime);
            $("[name='status']").val(status);
            $("[name='pcourse']").val(pcourse);
            $("[name='endtime']").val(endtime);
            $("#myModal").modal("show");
        }
    </script>
</head>
<body>
<div style="margin-top: 16px;">
    <fieldset style="width: 80%; margin: 0px auto;">
        <legend>试题目录</legend>
        <div class="row" style="margin-left: 10px;margin-bottom: 10px">
            <form action="paper/queryPaperAction.do" method="post" id="formselect">
                <input type="text" id="txtName" name="pname" placeholder="请输入试卷描述(模糊搜索)" style="width: 20%;"/>
                <button type="button" id="btnselect">查询</button>
            </form>
        </div>
        <div style="width: 98%; margin: 0 auto;">
            <table class="table  table-bordered table-hover table-condensed">

            </table>
        </div>
    </fieldset>
</div>

<!-- 修改模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">修改试卷相关内容</h4>
            </div>
            <div class="modal-body">
                <form id="formsave" action="<%=path%>/paper/saveAction.do" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="pid"/>
                    <input type="hidden" name="qids"/>
                    <input type="hidden" name="ptimes"/>
                    <input type="hidden" name="pcourse"/>
                    <input type="hidden" name="endtime"/>
                    <input type="file" name="filepath" id="filename" style="display: none"/>
                    姓名：<input type="text" name="pname"/>
                    答题时间：<input type="text" name="ptimetemp"/>
                    试卷状态：<select name="status">
                    <option value="1">可用</option>
                    <option value="0">过时</option>
                    </select>
                </form>
                <button type="button" id="filebtn">插入技能题</button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" id="btnsave" class="btn btn-primary">保存修改</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
