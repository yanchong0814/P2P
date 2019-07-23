<%@ page import="com.hxzy.telexam.beans.Userinfo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String pid = request.getParameter("pid");
    String user = request.getParameter("uname");
    pageContext.setAttribute("sname", user);
%>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="<%=path%>/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <script type="text/javascript" src="<%=path%>/js/jquery-2.2.4.js"></script>
    <script type="text/javascript" src="<%=path%>/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <title>考试试卷</title>
    <script type="text/javascript">
        var answer = new Array();
        var qanswer = new Array();
        var qscores = new Array();
        var letter=new Array("A","B","C","D","E","F","G","H","I","J","K","L","M","N")
        var scores = 0;
        var ps;
        var pbegintime;
        $(function () {
            $.ajax({
                type: "post",
                data: {"pid": "<%=pid%>"},
                url: "<%=path%>/paper/examAction.do",
                dataType: "json",
                success: function (res) {
                    var list = $.parseJSON(res);
                    var s=list.lists;
                    var paper=list.paper;
                    ps=paper;
                    var ptimes=paper.ptimes;
                    pbegintime=ptimes;
                    var pname=paper.pname;
                    var url=paper.url;
                    if(" "!=url&&""!=url){
                        $("#btndownload").show();
                        $("#btndownload").val(url);
                    }
                    $("#title").html(pname);
                    getpage(s);
                    setout(ptimes);
                },
                error: function () {
                }
            })
            $("#btnlast").click(function () {
                $("[name='formsub']").submit();
            })
            $("#temp").blur(function () {
                $("[name='ptimes']").val($("#temp").val() * 60 * 60 * 1000);
            })
        })
        function tosub(){
                scores=getscores();
                var tanswer=answer.toString();
                var pendtime=$("[name='times']").val();
                var time=parseInt(pbegintime)-parseInt(pendtime);
            $.ajax({
                type:"post",
                data:{"scscores":scores,"scbetweentime":time,"pid":"<%=pid%>","myanswer":tanswer},
                url:"<%=path%>/scores/saveAction.do",
                dataType:"json",
                success:function (result) {
                    if(result==1) {
                        location.href = "resultpaper.jsp?scscores=" + scores + "&scbetweentime=" + time+"&user=<%=user%>&pid=<%=pid%>";
                    }else{
                        alert("成绩提交失败！")
                    }
                 }
            });
        }
        function setout(ptime) {
            ptime=ptime-1000;
            tohour(ptime)
            if(ptime<=0){
                $("#btnsub1").click();
                return;
            }
            setTimeout("setout("+ptime+")",1000);
        }
        function tohour(ptimes) {
            var temp=ptimes/1000;
            var hour=parseInt(temp/3600);
            var minutes=parseInt(temp%3600/60);
            var second=temp%60
            var times=hour+"时"+minutes+"分"+second+"秒";
            $("#times").html(times)
            $("[name='times']").val(ptimes);
        }
        function toindex(index) {
            $('html,body').animate({scrollTop: $("#section-" + index).offset().top - 100}, 1000);
            if (top.location != self.location) {
                top.location = self.location;
            }
            return false;
        }
        function tomycheck(index) {
            var color=$("#head-" + index).css("background-color");
            if(color!="red"){
                $("#head-" + index).css("background-color","red");
            }
        }
        function check(index,obj) {
            var temp="";
            /*alert($("[name='question-"+ index+"']").val())*/
            $("[name='question-"+ index+"']:checked").each(function(){
                temp+=$(this).val();
            });
            if (temp!= ""){
                $("#head-" + index).css("background-color","green");
            }else{
                $("#head-" + index).css("background-color","");
            }
            answer[index-1] = temp;
        }
        function getscores() {
            for (var i = 0; i < qanswer.length; i++) {
                if (answer[i] == qanswer[i]) {
                    scores += qscores[i]
                }
            }
            return scores;
        }
        function todown() {
            location.href="<%=path%>/paper/fileDown.action?pid=<%=pid%>";
        }
        function getpage(list) {
            var head = "";
            var listfirst = "";
            for (var i = 0; i < list.length; i++) {
                qanswer[i] = list[i].qanswer;
                qscores[i] = list[i].qscore;
                head += "<li><a href=\"javascript:void(0)\" id=\"head-" + (i + 1) + "\" onclick=\"toindex(" + (i + 1) + ")\">" + (i + 1) + "</a></li>"
                if (list[i].qtype == 1) {
                    var myanswer="";
                    for(var j=0;j<list[i].list.length;j++){
                        myanswer+="<div><input type=\"radio\" name=\"question-" + (i + 1) + "\" value=\""+letter[j]+"\" onclick=\"check(" + (i + 1) + ",this)\"/><span style=\"margin-left: 10px\">" + list[i].list[j].qaname + "</span></div>";
                    }
                    listfirst += "<div class=\"row\" id=\"section-" + (i + 1) + "\">" +
                        "<div class=\"col-sm-12\">" +
                        "<div class=\"panel panel-default\">" +
                        "<div class=\"panel-heading\" onclick=\"tomycheck(" + (i + 1) + ")\">" +
                        "<h3 class=\"panel-title\">" + (i + 1) + "、(单选题) " + list[i].qname + "</h3></div>" +
                        " <div class=\"panel-body\" style=\"margin-left: 20px\">" +myanswer+
                        "</div></div></div></div>";
                }
                if (list[i].qtype == 2) {
                    var myanswer="";
                    for(var j=0;j<list[i].list.length;j++){
                        myanswer+="<div><input type=\"checkbox\" name=\"question-" + (i + 1) + "\" value=\""+letter[j]+"\" onclick=\"check(" + (i + 1) + ",this)\"/><span style=\"margin-left: 10px\">" + list[i].list[j].qaname + "</span></div>";
                    }
                    listfirst += "<div class=\"row\" id=\"section-" + (i + 1) + "\">" +
                        "<div class=\"col-sm-12\">" +
                        "<div class=\"panel panel-default\">" +
                        "<div class=\"panel-heading\">" +
                        "<h3 class=\"panel-title\">" + (i + 1) + "、(多选题) " + list[i].qname + "</h3></div>" +
                        " <div class=\"panel-body\" style=\"margin-left: 20px\">" +myanswer+
                        "</div></div></div></div>";
                }
                if (list[i].qtype == 3) {
                    listfirst += "<div class=\"row\" id=\"section-" + (i + 1) + "\">" +
                        "<div class=\"col-sm-12\">" +
                        "<div class=\"panel panel-default\">" +
                        "<div class=\"panel-heading\">" +
                        "<h3 class=\"panel-title\">" + (i + 1) + "、(判断题) " + list[i].qname + "</h3></div>" +
                        " <div class=\"panel-body\" style=\"margin-left: 20px\">" +
                        "<div><input type=\"radio\" name=\"question-" + (i + 1) + "\" value=\"1\" onclick=\"check(" + (i + 1) + ",this)\"/><span style=\"margin-left: 10px\"> 对</span></div>" +
                        "<div><input type=\"radio\" name=\"question-" + (i + 1) + "\" value=\"0\" onclick=\"check(" + (i + 1) + ",this)\"/><span style=\"margin-left: 10px\"> 错</span></div>" +
                        "</div></div></div></div>";
                }
            }
            $("#body").html(listfirst);
            $("#pagenum").html(head);
        }
    </script>
</head>
<body style="margin-top: 50px">
<div class="container">
    <div class="row" id="header">
        <div class="col-sm-12">
            <nav class="navbar navbar-default navbar-fixed-top" role="navigation"
                 style="margin-bottom: 0px;">
                <div class="container-fluid container" style="margin-top: 10px;margin-bottom: 0px;">
                    <form id="form2">
                        考生姓名：<%--<input name="names" type="hidden" value="${sname}"/>--%><span id="names">${sname}</span>
                        试卷标题：<%--<input name="title" type="hidden" value="${pname}"/>--%><span id="title">${pname}</span>
                        倒计时：<input name="times" type="hidden" value=""/><span id="times"></span>
                        <input id="btnsub1" type="button" value="提交试卷" onclick="tosub()"/>
                        <input id="btndownload" type="button" value="附件下载" onclick="todown()" style="display: none"/>
                    </form>
                </div>
                <div class="container-fluid container" style="margin-top: 0px;margin-bottom: 0px">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="#">答题卡:</a>
                    </div>
                    <div>
                        <ul id="pagenum" class="pagination nav navbar-nav" style="margin: 7px 0px;padding: 0px">
                            <%--<li><a href="javascript:void(0)" onclick="toindex(1)">1</a></li>--%>


                        </ul>
                    </div>
                </div>
            </nav>
        </div>
    </div>
    <div id="body" style="margin: 50px">
        <%--<div class="row" id="section-1">
            <div class="col-sm-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            1、关于sleep()和wait()，以下描述错误的一项是（ ）
                        </h3>
                    </div>
                    <div class="panel-body" style="margin-left: 20px">
                        <div><input type="radio" name="question-1" value="A"/><span style="margin-left: 10px">A. sleep是线程类（Thread）的方法，wait是Object类的方法；</span>
                        </div>
                        <div><input type="radio" name="question-1" value="B"/><span style="margin-left: 10px">B. sleep不释放对象锁，wait放弃对象锁；</span>
                        </div>
                        <div><input type="radio" name="question-1" value="C"/><span style="margin-left: 10px">C. sleep暂停线程、但监控状态仍然保持，结束后会自动恢复；</span>
                        </div>
                        <div><input type="radio" name="question-1" value="D"/><span style="margin-left: 10px">D. wait后进入等待锁定池，只有针对此对象发出notify方法后获得对象锁进入运行状态。</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>--%>


    </div>
</div>
</body>
</html>
