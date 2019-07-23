<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
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
<title>题库查询修改</title>
<script type="text/javascript">
$(function(){
	$.ajax({
		type:"post",
		data:{"qtype":"1","qcourse":"1","qstage":"1"},
		//data:{},
		url:"<%=path%>/QuestionQueryAction.do",
		dataType:"json",
		success:function(result){
			var res=$.parseJSON(result);//将String 转为json格式
			gettable(res.list);			
			getPage(res.pageBean);
		}
	});
	
	$(":button:eq(0)").click(function(){
		reload();
	});
	
	$(":button:eq(3)").click(function(){
		var id=$("[name='ckid']").val();
		$("#close1").trigger("click");
		setTimeout("toUpdate("+id+")", 800 );
	});
	
	$(":button:eq(6)").click(function(){
		$.ajax({
			type:"post",
			data:$("#formupd").serialize(),
			url:"<%=path%>/QuestionActions.do",
			success:function(){
				$("#close").trigger("click");
				//$("[name='buttoncx']").trigger("click");
				reload();
			}
		});
	});
	
}) 

function reload(){
		$.ajax({
			type:"post",
			data:{"qname":$("#txtName").val(),"qtype":$("#txtType").val(),"qcourse":$("#txtCourse").val(),"qstage":$("#txtStage").val()},
			url:"<%=path%>/QuestionQueryAction.do",
			dataType:"json",
			success:function(result){
				var res=$.parseJSON(result);//将String 转为json格式
				gettable(res.list);
				getPage(res.pageBean);
			}
		});
}

function gettable(list){	
		//查询数据库，返回集合
		var html=" <thead><tr class=\"success\"> "+
			" <th>题目ID</th><th>学科专业</th><th>学业阶段</th><th>题类型</th><th>题目内容</th><th>题答案</th><th>题分值</th><th>查看选项</th><th>管理操作<a href=\"javaScript:\" onclick=\"toadd()\" style=\"background-color: #DFF0D8; margin-left: 8px;  border: 1px solid #dcdcdc ;\" >添 加</a></th> "+
			" </tr></thead> ";
	    var temp="";
		//动态拼，循环
		for(var i in list){
			var obj=list[i];
			var course = obj.qcourse==1?"Java":obj.qcourse==2?"大数据":obj.qcourse==3?"UI设计":obj.qcourse==4?"AI智能":obj.qcourse==5?"网络营销":"未定义";
			var stage = obj.qstage==1?"第一阶段":obj.qstage==2?"第二阶段":obj.qstage==3?"第三阶段":obj.qstage==4?"第四阶段":"未定义";
			var qtype=obj.qtype==1?"单选题":obj.qtype==2?"多选题":obj.qtype==3?"判断题":"未定义";
			var qanswers = obj.qanswer==1?"对":obj.qanswer==0?"错":obj.qanswer;
				temp+=" <tr> "+
				" <td>"+obj.qid+"</td> "+
				" <td>"+course+"</td> "+
				" <td>"+stage+"</td> "+
				" <td>"+qtype+"</td> "+
				" <td>"+obj.qname+"</td> "+
				" <td>"+qanswers+"</td> "+
				" <td>"+obj.qscore+"</td> "+
				" <td><a data-toggle=\"modal\" data-target=\"#myModalx\" href=\"javaScript:\" onclick=\"toShow('"+obj.qid+"')\"> 查看选项 </a> </td> "+
				" <td><a href=\"javaScript:\" onclick=\"toDelete('"+obj.qid+"')\"> 删除 </a> <a href=\"javaScript:\" onclick=\"toUpdate('"+obj.qid+"')\" > 修改 </a></td> "+
				" </tr> ";
		}
		$("table").html(html+temp);		
		
}

function getPage(pagebean){
	//拼分页
	var page=" 总计："+pagebean.count+" 条, &nbsp;总页数："+pagebean.pageCount+" 页, &nbsp;每页显示："+pagebean.pagesize+" 条, &nbsp;当前：第 -"+pagebean.pageNumber+"- 页"; 
    var sepage="<a href=\"javaScript:trunPage(1)\" >首页</a>&nbsp;&nbsp;"+
    	"<a href=\"javaScript:trunPage("+(pagebean.pageNumber-1)+")\">上一页</a>&nbsp;&nbsp;"+   
        "<a href=\"javaScript:trunPage("+(pagebean.pageNumber+1)+")\">下一页</a>&nbsp;&nbsp;"+ 
        "<a href=\"javaScript:trunPage("+pagebean.pageCount+")\">尾页</a>";
    $("#page").html(page);
	$("#sepage").html(sepage);
}
//分页方法
function trunPage(pageNum){
	/* alert($("#txtType").val());
	alert($("#txtName").val());
	alert($("#txtCourse").val());
	alert($("#txtStage").val()); */
	$.ajax({
		type:"post",		
		data:{"pageNumber":pageNum,"qtype":$("#txtType").val(),"qname":$("#txtName").val(),"qcourse":$("#txtCourse").val(),"qstage":$("#txtStage").val()},
		url:"<%=path%>/QuestionQueryAction.do",
		dataType:"json",
		success:function(result){
			var res=$.parseJSON(result);//将String 转为json格式
			gettable(res.list);
			getPage(res.pageBean);
		}
	});
} 

function toDelete(qid){
	$.ajax({
		type:"post",
		data:{"qid":qid},
		url:"<%=path%>/QusetionDeleteAction.do",
		success:function(){
			reload();
		} 
	});

}

function toShow(id){
	$.ajax({
		type:"post",
		data:{"qid":id},
		url:"<%=path%>/QuestionShowAction.do",
		dataType:"json",
		success:function(result){
			var res=$.parseJSON(result);			
			var list = res.list;
			var course = res.qcourse==1?"Java":res.qcourse==2?"大数据":res.qcourse==3?"UI设计":res.qcourse==4?"AI智能":res.qcourse==5?"网络营销":"未定义";
			var stage = res.qstage==1?"第一阶段":res.qstage==2?"第二阶段":res.qstage==3?"第三阶段":res.qstage==4?"第四阶段":"未定义";
			var qtypes = res.qtype==1?"单选题":res.qtype==2?"多选题":res.qtype==3?"判断题":"未定义";
			var qanswers = res.qanswer==1?"对":res.qanswer==0?"错":res.qanswer;
			var temphtml="";
			temphtml+="<div style=\"margin-top: 10px;\"> " +
				"<input type=\"hidden\" name=\"ckid\"  value=\""+res.qid+"\" /> " + 
				"<label>专业：</label><span id=\"qcourse\">"+course+"</span> " +
				"</div> " +
				"<div style=\"margin-top: 10px;\"> " +						
				"<label>阶段：</label><span id=\"qstage\">"+stage+"</span> " +
				"</div> " +
				" <div style=\"margin-top: 10px; display: inline-block;\"> " + 				
				"<label>类型：</label><span id=\"qtype\">"+qtypes+"</span> " + 
				"</div> " + 
				"<div style=\"margin-top: 10px; display: inline-block; margin-right:50px; float: right;\"> " + 
				"<label></label><span id=\"qscore\">"+res.qscore+"</span> 分" + 
				"</div> " + 
				"<div style=\"margin-top: 8px;\"> " +						
				"<label>题目：</label><span id=\"qname\" style=\"font-weight: bold;\">"+res.qname+"</span> " +
				"</div> " +
				"<div id=\"qanamelist\" style=\"margin-top: 10px; margin-left: 16px;\"> " +
				"</div> " +
				"<div style=\"margin-top: 8px; margin-bottom: 20px;\"></div> "+ 
				"<div style=\"margin-top: 8px; margin-bottom: 20px;\"> " +
				"<label>答案：</label><span id=\"qanswer\" style=\"color: red; font-weight: bold;\">"+qanswers+"</span> " +
				"</div> ";
			var templist="";
			for( var i in list){
				var obj=list[i];				
				templist+="<div style=\"margin-top: 5px; margin-left: 16px;\"> " +
					"<span class=\"qaname\"></span>"+obj.qaname+"</div> ";				
			}			
			$("#modalx").html(temphtml);
			$("#qanamelist").html(templist);
		}
	});
} 

function toUpdate(id){
	$.ajax({
		type:"post",
		data:{"qid":id},
		url:"<%=path%>/QuestionUpdateAction.do",
		dataType:"json",
		success:function(result){
			var res=$.parseJSON(result);
			var temp="";
			var typess="";
			var coursetemp="";
			var stagtemp="";
			
			if(res.qtype==1){
				typess+=" <label>题类型:</label><select name=\"qtype\" style=\"border: 0.5px solid #dcdcdc;\">" + 
					" <option value=\"1\" selected=\"selected\">-单选题-</option> " + 
					" <option value=\"2\" disabled=\"disabled\">-多选题-</option> " + 
					" <option value=\"3\" disabled=\"disabled\">-判断题-</option> " + 
					" </select> ";				
			}else if(res.qtype==2){
				typess+=" <label>题类型:</label><select name=\"qtype\" style=\"border: 0.5px solid #dcdcdc;\">" + 
					" <option value=\"1\" disabled=\"disabled\">-单选题-</option> " + 
					" <option value=\"2\" selected=\"selected\">-多选题-</option> " + 
					" <option value=\"3\" disabled=\"disabled\">-判断题-</option> " + 
					" </select> ";
			}else if(res.qtype==3){
				typess+=" <label>题类型:</label><select name=\"qtype\" style=\"border: 0.5px solid #dcdcdc;\">" + 
					" <option value=\"1\" disabled=\"disabled\">-单选题-</option> " + 
					" <option value=\"2\" disabled=\"disabled\">-多选题-</option> " + 
					" <option value=\"3\" selected=\"selected\">-判断题-</option> " + 
					" </select> ";
			}
			
			if(res.qtype==3){
				if(res.qanswer==1){
					temp+=" <label>答案:</label> " +
					" <input type=\"radio\" name=\"qanswer\" value=\"1\" checked=\"checked\" /> 对  " +
					" <input type=\"radio\" name=\"qanswer\" value=\"0\" style=\"margin-left: 16px\" /> 错 ";				
				}
				if(res.qanswer==0){
					temp+=" <label>答案:</label> " +
					" <input type=\"radio\" name=\"qanswer\" value=\"1\" /> 对  " +
					" <input type=\"radio\" name=\"qanswer\" value=\"0\" style=\"margin-left: 16px\" checked=\"checked\" /> 错 ";
				}
				
			}else{
				temp+=" <label>答案:</label><input type=\"text\" id=\"qanswerid\" name=\"qanswer\" style=\"border: 0.5px solid #dcdcdc; width: 60px;\" /> ";
				
			}	
			var list = res.list;
			var telist="";
 			for( var i in list){
				var obj=list[i];
				if(res.qtype==3){
					telist+=" <div style=\"margin-top: 5px; margin-left: 33px;\"> " + 
					" <input type=\"hidden\" name=\"qaname\" value=\"\" style=\"border: 0.5px solid #dcdcdc; width: 400px;\" /> "+
					" </div> ";
				}else{
					telist+=" <div style=\"margin-top: 5px; margin-left: 33px;\"> " + 
					" <input type=\"hidden\" name=\"qaid\"  value=\""+obj.qaid+"\" /> " + 
					" <input type=\"text\" name=\"qaname\" value=\""+obj.qaname+"\" style=\"border: 0.5px solid #dcdcdc; width: 400px;\" /> "+
					" </div> ";	
				}
			} 			
 			$("#typess").html(typess);
			$("#qanlist").html(telist);
			$("#anwsertype").html(temp);
			$("[name='qcourse']").val(res.qcourse);
			$("[name='qstage']").val(res.qstage);
			$("[name='qid']").val(res.qid);
			$("[name='qtype']").val(res.qtype);
			$("[name='qscore']").val(res.qscore);
			$("[name='qname']").val(res.qname);
			$("#qanswerid").val(res.qanswer);		
		}
	});
	$("#myModalu").modal("show");
}

function toadd(){
	
	location.href = "addOrUpdate.jsp";
}
 
</script>
</head>
<body>
	<div style="margin-top: 16px;">
		<fieldset style="width: 80%; margin: 0px auto;">
			<legend>题库目录</legend>
			<div class="row">
			<div style="width: 90%;margin-left: 2%;">
			<div style="display: inline-block;">
			<label>专业:</label> <select id="txtCourse">
					<!-- <option selected="selected">-请选专业-</option> -->
					<option value="1">Java</option>
					<option value="2">大数据</option>
					<option value="3">UI设计</option>
					<option value="4">AI智能</option>
					<option value="5">网络营销</option>
				</select></div>
				<div style="display: inline-block;">
			<label>阶段:</label> <select id="txtStage">
					<!-- <option selected="selected">-请选阶段-</option> -->
					<option value="1">第一阶段</option>
					<option value="2">第二阶段</option>
					<option value="3">第三阶段</option>
					<option value="4">第四阶段</option>
				</select></div>
				<div style="display: inline-block;">
			<label>题类型:</label> <select id="txtType">
					<!-- <option selected="selected" disabled="disabled">-请选题型-</option> --> 
					<option value="1">单选题</option>
					<option value="2">多选题</option>
					<option value="3">判断题</option>
				</select></div>
				<div style="display: inline-block;">
				<label>题目</label> <input type="text" id="txtName"
					placeholder="请输入题目(模糊搜索)"/>	
					<!-- <button type="button" style="background-color: #DFF0D8;margin-left: 16px; border: 0.5px solid #dcdcdc ; width: 20px;">添 加</button> -->
				<button name="buttoncx" type="button">查询</button></div></div>
				<div style="width: 98%; margin: 0 auto;">
					<table class="table  table-bordered table-hover table-condensed">
					</table>
					<div style="margin-top: 2px; display: inline-block; float: left;"
			id="page">
<!-- 			总记录数:2 ,每页10条,总页数:1, 当前第1页<a href="javaScript:trunPage(1)">-->
		</div>
		<div style="margin-top: 2px; display: inline-block; float: right;" id="sepage">
			<!-- 首页</a>&nbsp;&nbsp;<a href="javaScript:trunPage(0)">上一页</a>&nbsp;&nbsp;<a
				href="javaScript:trunPage(2)">下一页</a>&nbsp;&nbsp;<a
				href="javaScript:trunPage(1)">尾页</a> -->
		</div> 
				</div>
			</div>
		</fieldset>
	</div>
	<!-- 模态框（ModalX） -->
	<div class="modal fade" id="myModalx" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">详细展示</h4>
				</div>
					<div class="modal-body" id="modalx">
						
					</div>
					<div class="modal-footer">
						<button type="button" id="close1" class="btn btn-default"
							data-dismiss="modal">关闭</button>
						<button type="button" id="toupd" class="btn btn-primary">去修改</button>
					</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<!-- 模态框（Modalu） -->
	<div class="modal fade" id="myModalu" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">单题修改</h4>
				</div>
				<form id="formupd">
					<div class="modal-body" id="modalu">
						<div id="courstage">
							<div  style="margin-top: 5px; margin-left: 16px;">
							<label>专业:</label><select name="qcourse" style="border: 0.5px solid #dcdcdc;">
										<option disabled="disabled">-请选专业-</option>
										<option value="1">Java</option>
										<option value="2">大数据</option>
										<option value="3">UI设计</option>
										<option value="4">AI智能</option>
										<option value="5">网络营销</option>
									</select>  
							</div>
							<div  style="margin-top: 5px; margin-left: 16px;">
							<label>阶段:</label><select name="qstage" style="border: 0.5px solid #dcdcdc;">
										<option disabled="disabled">-请选阶段-</option>
										<option value="1">第一阶段</option>
										<option value="2">第二阶段</option>
										<option value="3">第三阶段</option>
										<option value="4">第四阶段</option>
									</select>  
							</div>
							</div>
						<div style="margin-top: 10px; display: inline-block;">
							<input type="hidden" name="qid" />							
							<div id="typess">
							<!-- <label>题类型:</label><select name="qtype" style="border: 0.5px solid #dcdcdc;">
										<option value="1" selected="selected">-单选题-</option>
										<option value="2" disabled="disabled">-多选题-</option>
										<option value="3">-判断题-</option>
									</select>  -->
							</div>
						</div>
						<div style="margin-top: 10px; display: inline-block; margin-right:50px; float: right;">
							<label>分值:</label><input type="text" name="qscore" style="border: 0.5px solid #dcdcdc; width: 20px;" /><span>分</span>
						</div>
						
						<div  style="margin-top: 5px; margin-left: 16px;">
							<label>题目:</label><input type="text" name="qname" style="border: 0.5px solid #dcdcdc; width: 480px;" />
						</div>						
						<div id="qanlist" style="margin-top: 10px; margin-left: 16px;">
						<!-- <label>答案选项:</label> -->						
						</div>
						<div style="margin-top: 5px; margin-left: 16px;"></div>
						<div id="anwsertype" style="margin-top: 5px; margin-left: 16px;">
							 <label>答案:</label><input type="hidden" name="qanswer" style="border: 0.5px solid #dcdcdc; width: 60px;" />
							<input type="radio" name="qanswer" value="1" checked="checked" /> 对 
							<input type="radio" name="qanswer" value="0" style="margin-left: 16px" /> 错 
						</div>  
					</div>
					<div class="modal-footer">
						<button type="button" id="close" class="btn btn-default"
							data-dismiss="modal">关闭</button>
						<button type="button" id="upd" class="btn btn-primary">修改提交</button>
					</div>
				</form>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
</body>
</html>