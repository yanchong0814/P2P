<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    java.sql.Date date=new java.sql.Date(new Date().getTime());
%>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="<%=path%>/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <script type="text/javascript" src="<%=path%>/js/jquery-2.2.4.js"></script>
    <script type="text/javascript" src="<%=path%>/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <title>考试试卷</title>
    <script type="text/javascript">
        var qids="-1";
        var qscores=0;
        $(function () {
            gettimes();
            $("#btnsub").click(function () {
                qids="-1";
                qscores=0;
                $.ajax({
                    type: "post",
                    data: $("#form1").serialize(),
                    url: "<%=path%>/paper/queryAction.do",
                    dataType: "json",
                    success: function (res) {
                        getpage(res);
                    },
                    error: function () {

                    }
                });
            })
            $("#btnlast").click(function () {
                $("[name='formsub']").submit();
            })
            $("#temp").blur(function () {
                $("[name='ptimes']").val($("#temp").val()*60*60*1000);
            })
            $("#filebtn").click(function () {
                $("#filename").click();
            })
            $("#tempdate,#temptime").change(function () {
                var temp=$("#tempdate").val()+" "+$("#temptime").val();
                $("[name='endtime']").val(temp);
            })
        })
        function gettimes() {
            var temp=$("#tempdate").val()+" "+$("#temptime").val();
            $("[name='endtime']").val(temp);
        }
        function getpage(res) {
            var listfirst = "";
            var map = $.parseJSON(res);
            var qcourse=map.qcourse;
            for (var i = 0; i < map.list1.length; i++) {
                var answer="";
                for(var j=0;j<map.list1[i].list.length;j++){
                    answer+= "<div><input type=\"radio\" name=\"question-" + (i + 1) + "\"/><span style=\"margin-left: 10px\">" + map.list1[i].list[j].qaname + "</span></div>"
                }
                qscores+=map.list1[i].qscore;
                qids+=","+map.list1[i].qid;
                listfirst += "<div class=\"row\" id=\"section-" + (i + 1) + "\">" +
                    "<div class=\"col-sm-12\">" +
                    "<div class=\"panel panel-default\">" +
                    "<div class=\"panel-heading\">" +
                    "<h3 class=\"panel-title\">" + (i + 1) + "、(单选题) " + map.list1[i].qname + "</h3></div>" +
                    " <div class=\"panel-body\" style=\"margin-left: 20px\">" +answer+
                    "</div></div></div></div>";
            }
            for (var i = 0; i < map.list2.length; i++) {
                var answer="";
                for(var j=0;j<map.list2[i].list.length;j++){
                    answer+= "<div><input type=\"checkbox\" name=\"question-" + (i + 1) + "\"/><span style=\"margin-left: 10px\">" + map.list2[i].list[j].qaname + "</span></div>"
                }
                qids+=","+map.list2[i].qid;
                qscores+=map.list2[i].qscore;
                listfirst += "<div class=\"row\" id=\"section-" + (map.number1 + i + 1) + "\">" +
                    "<div class=\"col-sm-12\">" +
                    "<div class=\"panel panel-default\">" +
                    "<div class=\"panel-heading\">" +
                    "<h3 class=\"panel-title\">" + (map.number1 +i + 1) + "、(多选题) " + map.list2[i].qname + "</h3></div>" +
                    " <div class=\"panel-body\" style=\"margin-left: 20px\">" +answer+
                    "</div></div></div></div>";
            }
            for (var i = 0; i < map.list3.length; i++) {
                qids+=","+map.list3[i].qid;
                qscores+=map.list3[i].qscore;
                listfirst += "<div class=\"row\" id=\"section-" + (map.number2 + map.number1 + i + 1) + "\">" +
                    "<div class=\"col-sm-12\">" +
                    "<div class=\"panel panel-default\">" +
                    "<div class=\"panel-heading\">" +
                    "<h3 class=\"panel-title\">" + (map.number2 + map.number1 + i + 1) + "、(判断题) " + map.list3[i].qname + "</h3></div>" +
                    " <div class=\"panel-body\" style=\"margin-left: 20px\">" +
                    "<div><input type=\"radio\" name=\"question-" + (map.number2 + map.number1 + i + 1) + "\" value=\"A\"/><span style=\"margin-left: 10px\"> 对</span></div>" +
                    "<div><input type=\"radio\" name=\"question-" + (map.number2 + map.number1 + i + 1) + "\" value=\"B\"/><span style=\"margin-left: 10px\"> 错</span></div>" +
                    "</div></div></div></div>";
            }
            $("#body").html(listfirst);
            $("#qids").val(qids);
            $("#scores").html(qscores);
            $("#qcourse").val(qcourse);
        }
    </script>
</head>
<body style="margin-top: 25px">
<div class="container">
    <div class="row" id="header">
        <div class="col-sm-12 text-center">
            <nav class="navbar navbar-default navbar-fixed-top" role="navigation"
                 style="margin-bottom: 0px;">
                <div style="margin-top: 10px;margin-bottom: 0px;">
                    <form id="form1" action="<%=path%>/paper/queryAction.do" method="post">
                        单选题：<input name="number01" type="text" style="width: 50px;text-align: center;margin-right: 10px" value="0"/>
                        多选题：<input name="number02" type="text" style="width: 50px;text-align: center;margin-right: 10px" value="0"/>
                        判断题：<input name="number03" type="text" style="width: 50px;text-align: center;margin-right: 10px" value="0"/>
                        课程：<select id="wqcourse" name="qcourse" style="width: 85px;margin-right: 10px">
                        <option value="1">Java</option>
                        <option value="2">大数据</option>
                        <option value="3">UI设计</option>
                        <option value="4">AI智能</option>
                        <option value="5">网络营销</option>
                        </select>
                        阶段：<select id="wqstage" name="qstage" style="width: 85px;margin-right: 10px">
                            <option value="1">第一阶段</option>
                            <option value="2">第二阶段</option>
                            <option value="3">第三阶段</option>
                            <option value="4">第四阶段</option>
                        </select>
                        总分值：<span id="scores"></span><label  style="margin-right: 10px">&nbsp;&nbsp;分</label>
                        <button type="button" id="filebtn" style="margin-right: 10px">插入技能题</button>
                        <input id="btnsub" type="button" value="生成试卷"  style="margin-right: 10px"/>
                        <input id="btnsave" type="button" data-toggle="modal" data-target="#myModal" value="保存试卷"/>
                    </form>
                </div>
            </nav>
        </div>
    </div>
    <div id="body" style="margin: 50px">

    </div>
</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">添加试卷相关内容</h4>
            </div>
            <div class="modal-body">
                <form action="<%=path%>/paper/saveAction.do" method="post" name="formsub" enctype="multipart/form-data">
                    <input type="hidden" name="qids" id="qids"/>
                    <input type="hidden" name="status" value="1"/>
                    <div  style="padding-bottom: 20px">试卷描述：<input type="hidden" name="qcourse" id="qcourse"/><input type="text" name="pname"/></div>
                    <div  style="padding-bottom: 20px">过期时间：<input type="hidden" name="endtime"/><input type="date" id="tempdate" value="<%=date.toString()%>"/><input type="time" id="temptime" value="00:00:00"/></div>
                    <div  style="padding-bottom: 20px">考试时长：<input type="text" id="temp"/>小时<input type="hidden" name="ptimes"/></div>
                    <div class="form-group form-inline">
                        <input type="file" name="filepath" id="filename" style="display: none"/>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" style="width: 80px">关闭</button>
                <button type="button" id="btnlast" class="btn btn-primary" style="width: 80px">提交试卷</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
