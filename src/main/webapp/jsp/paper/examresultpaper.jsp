<%--
  Created by IntelliJ IDEA.
  User: xiewc
  Date: 2018/8/18
  Time: 23:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
    String pid=request.getParameter("pid");
%>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="<%=path%>/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <script type="text/javascript" src="<%=path%>/js/jquery-2.2.4.js"></script>
    <script type="text/javascript" src="<%=path%>/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <title>试卷结果</title>
    <script type="text/javascript">
        $.ajax({
            type: "post",
            data: {"pid":"<%=pid%>"},
            url: "<%=path%>/scores/paperAction.do",
            dataType: "json",
            success: function (result) {
                var res=$.parseJSON(result);
                getpage(res);
            },
            error: function (result) {

            }
        });
        function getpage(res) {
            var resultanswer=res.myanswer;
            var list=res.lists;
            var arrays=resultanswer.split(",");
            var listfirst = "";
            for (var i = 0; i < list.length; i++) {
                if (list[i].qtype == 1) {
                    var myanswer="";
                    for(var j=0;j<list[i].list.length;j++){
                        myanswer+="<div><span style=\"margin-left: 10px\">" + list[i].list[j].qaname + "</span></div>";
                    }
                    listfirst += "<div class=\"row\" id=\"section-" + (i + 1) + "\">" +
                        "<div class=\"col-sm-12\">" +
                        "<div class=\"panel panel-default\">" +
                        "<div class=\"panel-heading\">" +
                        "<h3 class=\"panel-title\">" + (i + 1) + "、(单选题) " + list[i].qname + "（正确答案："+list[i].qanswer+",您的答案："+arrays[i]+"）</h3></div>" +
                        " <div class=\"panel-body\" style=\"margin-left: 20px\">" +myanswer+
                        "</div></div></div></div>";
                }
                if (list[i].qtype == 2) {
                    var myanswer="";
                    for(var j=0;j<list[i].list.length;j++){
                        myanswer+="<div><span style=\"margin-left: 10px\">" + list[i].list[j].qaname + "</span></div>";
                    }
                    listfirst += "<div class=\"row\" id=\"section-" + (i + 1) + "\">" +
                        "<div class=\"col-sm-12\">" +
                        "<div class=\"panel panel-default\">" +
                        "<div class=\"panel-heading\">" +
                        "<h3 class=\"panel-title\">" + (i + 1) + "、(多选题) " + list[i].qname + "（正确答案："+list[i].qanswer+",您的答案："+arrays[i]+"）</h3></div>" +
                        " <div class=\"panel-body\" style=\"margin-left: 20px\">" +myanswer+
                        "</div></div></div></div>";
                }
                if (list[i].qtype == 3) {
                    listfirst += "<div class=\"row\" id=\"section-" + (i + 1) + "\">" +
                        "<div class=\"col-sm-12\">" +
                        "<div class=\"panel panel-default\">" +
                        "<div class=\"panel-heading\">" +
                        "<h3 class=\"panel-title\">" + (i + 1) + "、(判断题) " + list[i].qname + "（正确答案："+list[i].qanswer+",您的答案："+arrays[i]+"）</h3></div>" +
                        " <div class=\"panel-body\" style=\"margin-left: 20px\">" +
                        "<div><span style=\"margin-left: 10px\"> 对</span></div>" +
                        "<div><span style=\"margin-left: 10px\"> 错</span></div>" +
                        "</div></div></div></div>";
                }
            }
            $("#body").html(listfirst);
        }
    </script>
</head>
<body>
<div class="container">
    <div id="body">

    </div>
</div>
</body>
</html>
