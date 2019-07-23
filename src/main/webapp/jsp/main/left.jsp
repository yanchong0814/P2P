<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <TITLE>ZTREE DEMO</TITLE>
    <%
        String path=request.getContextPath();
    %>
    <link rel="stylesheet" href="<%=path%>/css/demo.css" type="text/css">
    <link rel="stylesheet" href="<%=path%>/css/zTreeStyle/zTreeStyle.css"
          type="text/css">
    <script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript">
        var zTreeObj;
        var setting = {
            data:{
                key:{
                    children:"child",
                    name:"name",
                    url:"url"
                },
                simpleData:{
                    enable:false,
                    idKey:"id",
                    pIdKey:"pid",
                    rootPid:"0"
                }
            }
        };
        $(document).ready(function(){
            $.ajax({
                type:"post",
                data:{},
                url:"<%=path%>/ztree/queryAction.do",
                dataType:"json",
                success:function(data){
                    var datas=$.parseJSON(data);
                    zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, datas);
                    $.fn.zTree.getZTreeObj("treeDemo").expandAll(true);
                }
            });
        });
    </script>
</head>
<body>
<div style="float: left">
    <div>
        <ul id="treeDemo" class="ztree"></ul>
    </div>
</div>
</body>
</html>