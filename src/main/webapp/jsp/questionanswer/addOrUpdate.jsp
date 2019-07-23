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
<title>题库添加录入</title>
<script type="text/javascript">
$(function() {
	$("#tijiao").click(function(){
		$.ajax({
			type:"post",
			data:$("[name='tiform']").serialize(),
			url:"<%=path%>/QuestionActions.do",
			dataType:"text",
			success:function(res){				
				resright();
				respan();
				//$("#wqtype").val("");
				//$("#wqtype").removeAttr("selected");//类型清空
				}
			})
	});
	/* 学科专业 */
	$("#wqcourse").change(function() {
		var obj=$("#wqcourse").val();
		var course = obj==1?"Java":obj==2?"大数据":obj==3?"UI设计":obj==4?"AI智能":obj==5?"网络营销":"未定义";
		$("[name='qcourse']").val(obj);
		$("[name='qcourse']").next().html(course);
	});
	/* 学习阶段 */
	$("#wqstage").change(function() {
		var obj=$("#wqstage").val();
		var stage = obj==1?"第一阶段":obj==2?"第二阶段":obj==3?"第三阶段":obj==4?"第四阶段":"未定义";
		$("[name='qstage']").val(obj);
		$("[name='qstage']").next().html(stage);		
	});	
	
	/* 试题类型 */
	$("#wqtype").change(function() {
		resright();
		respan();
		$("[name='qtype']").val("");
		var obj=$("#wqtype").val();
		var typ = obj==1?"单选题":obj==2?"多选题":obj==3?"判断题":"未定义";
		$("[name='qtype']").val(obj);
		$("[name='qtype']").next().html(typ); 
		if(obj==1){
			$(".answerlist")[0].style.cssText="display: inline;";
			$(".answerlist")[1].style.cssText="display: none;";
			$(".answerlist")[2].style.cssText="display: none;";			
		}else if(obj==2){
			$(".answerlist")[2].style.cssText="display: none;";
			$(".answerlist")[0].style.cssText="display: none;";
			$(".answerlist")[1].style.cssText="display: inline;";
		}else if(obj==3){			
			$(".answerlist")[0].style.cssText="display: none;";
			$(".answerlist")[1].style.cssText="display: none;";
			$(".answerlist")[2].style.cssText="display: inline;";
		}
	});
	/* 分数取值 */
	$("[name='wqscore']").click(function(){		
		$("[name='qscore']").val($(this).val());
		$("[name='qscore']").next().html($(this).val());
	});
	/* 题目取值 */
 	$("#wqname").on("keyup change",function() {
		var obj=$("#wqname").val();
		$("[name='qname']").val(obj);
		$("[name='qname']").next().html(obj);
	});
	
	/* 单选取值 */
	$("#singlename1").on("keyup change",function() {
		var obj=$("#singlename1").val();
		var objw=$("#singleindex1").html();
		$("[name='qaname']").eq(0).val(objw+obj);
		$("[name='qaname']").eq(0).next().html(objw+obj);
	});
	$("#singlename2").on("keyup change",function() {
		var obj=$("#singlename2").val();
		var objw=$("#singleindex2").html();
		$("[name='qaname']").eq(1).val(objw+obj);
		$("[name='qaname']").eq(1).next().html(objw+obj);
	});
	$("#singlename3").on("keyup change",function() {
		var obj=$("#singlename3").val();
		var objw=$("#singleindex3").html();
		$("[name='qaname']").eq(2).val(objw+obj);
		$("[name='qaname']").eq(2).next().html(objw+obj);
	});
	$("#singlename4").on("keyup change",function() {
		var obj=$("#singlename4").val();
		var objw=$("#singleindex4").html();
		$("[name='qaname']").eq(3).val(objw+obj);
		$("[name='qaname']").eq(3).next().html(objw+obj);
	});
	/* 单选答案取值 */
	$("[name='singleanswer']").click(function(){		
		$("[name='qanswer']").val($(this).val());
		$("[name='qanswer']").next().html($(this).val());
	});
	
	/* 多选取值 */
	$("#mulname1").on("keyup change",function() {
		var obj=$("#mulname1").val();
		var objw=$("#mulindex1").html();
		$("[name='qaname']").eq(0).val(objw+obj);
		$("[name='qaname']").eq(0).next().html(objw+obj);
	});
	$("#mulname2").on("keyup change",function() {
		var obj=$("#mulname2").val();
		var objw=$("#mulindex2").html();
		$("[name='qaname']").eq(1).val(objw+obj);
		$("[name='qaname']").eq(1).next().html(objw+obj);
	});
	$("#mulname3").on("keyup change",function() {
		var obj=$("#mulname3").val();
		var objw=$("#mulindex3").html();
		$("[name='qaname']").eq(2).val(objw+obj);
		$("[name='qaname']").eq(2).next().html(objw+obj);
	});
	$("#mulname4").on("keyup change",function() {
		var obj=$("#mulname4").val();
		var objw=$("#mulindex4").html();
		$("[name='qaname']").eq(3).val(objw+obj);
		$("[name='qaname']").eq(3).next().html(objw+obj);
	});	
	/* 多选题答案取值 */
	$("[name='mulanswer']").click(function(){
 		var mul_chk="";
		$("input[name='mulanswer']:checked").each(function(){
			mul_chk+=$(this).val();	
		});
		$("[name='qanswer']").val(mul_chk);
		$("[name='qanswer']").next().html(mul_chk);
	});
	
	/* 判断题答案取值 */
	$("[name='judgeanswer']").click(function(){
		$("[name='qanswer']").val($(this).val());
		var judge = $(this).val()==1?"对":"错";
		$("[name='qanswer']").next().html(judge);
	});
		
	/* 重置按钮的提示 */
	$("#resetbutton").click(function(){
		if(confirm("确定清空重新录入吗？")){
			luform.reset();	
			respan();
			//$("[name='qtype']").val("");
			$("[name='qcourse']").val("");
			$("[name='qstage']").val(""); 
			$("[name='tiform'] span").html("");
		}
	});

})

/* 右边表单及显示清空 */
function resright(){
	
	$("#wqname").val("");//题目
	$("[name='wqscore']").removeAttr("checked");//分值按钮
	$("[name='singleanswer']").removeAttr("checked");//单选按钮
	$("[name='mulanswer']").removeAttr("checked");//多选按钮
	$("[name='judgeanswer']").removeAttr("checked");//判单按钮
 	$("#singlename1").val("");//单选项
 	$("#singlename2").val("");//单选项
 	$("#singlename3").val("");//单选项
 	$("#singlename4").val("");//单选项
	$("#mulname1").val("");//多选项
	$("#mulname2").val("");//多选项
	$("#mulname3").val("");//多选项
	$("#mulname4").val("");//多选项
}
/* 右边表单及显示清空 */
function respan(){
	/* $("[name='qcourse']").val("");
	$("[name='qstage']").val(""); 	
	$("[name='qtype']").val(""); */
	$("[name='qscore']").val("");
	$("[name='qname']").val("");
	$("[name='qaname']").val("");
	$("[name='qanswer']").val("");
	$("#spans span").html("");
}

</script>
</head>
<body>
	<div style="margin-top: 16px;">
		<fieldset style="width: 85%; margin: 0px auto;">
			<legend>题目添加与修改</legend>
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<div style="width: 98%;">
							<form name="luform" action=""
								method="post">	
								<div>												
								<div style="margin-top: 10px; ">
									<label>学科专业:</label> <select id="wqcourse" style="width: 85px;">
										<option selected="selected" disabled="disabled">-请选择-</option>
										<option value="1">Java</option>
										<option value="2">大数据</option>
										<option value="3">UI设计</option>
										<option value="4">AI智能</option>
										<option value="5">网络营销</option>
									</select>
								</div>
								<div style="margin-top: 10px; ">
									<label>学业阶段:</label> <select id="wqstage" style="width: 85px;">
										<option selected="selected" disabled="disabled">-请选择-</option>
										<option value="1">第一阶段</option>
										<option value="2">第二阶段</option>
										<option value="3">第三阶段</option>
										<option value="4">第四阶段</option>
									</select>
								</div>
								</div>
								<div>
								<div style="margin-top: 10px; display: inline-block;">
									<label>题目类型:</label> <select id="wqtype" style="width: 85px;">
										<option selected="selected" disabled="disabled">-请选择-</option>
										<option value="1">-单选题-</option>
										<option value="2">-多选题-</option>
										<option value="3">-判断题-</option>
									</select>
								</div>
								<div style="margin-top: 10px; display: inline-block; float: right;">
								<label>题目分值:</label>
								<input type="radio" name="wqscore" value="1" />
								<span style="font-weight: bold;">1 分</span> 
								<input type="radio" name="wqscore" value="2" />
								<span style="font-weight: bold;">2 分</span>
								<input type="radio" name="wqscore" value="3" />
								<span style="font-weight: bold;">3 分</span>
								<input type="radio" name="wqscore" value="4" />
								<span style="font-weight: bold;">4 分</span>
								<input type="radio" name="wqscore" value="5" />
								<span style="font-weight: bold;">5 分</span>
								</div>
								</div>
								
								<div style="margin-top: 10px;">
									<label>题目名称:</label><br>
									<textarea id="wqname" rows="1" cols="50" style="resize: none;"
										class="form-control"></textarea>
								</div>

								<div style="margin-top: 10px; display: inherit;">
								<!--单选-->
									<div class="answerlist" style="display: none;">
										<label>单选答案选项:</label><br><input type="radio"
											name="singleanswer" value="A" style="margin-top: 4px;" /> <label
											style="margin-top: 3px;" id="singleindex1">A、</label> <input type="text"
											id="singlename1" style="width: 80%; margin-top: 6px;" /><br>
										<input type="radio" value="B" name="singleanswer" style="margin-top: 4px;" />
										<label style="margin-top: 3px;" id="singleindex2">B、</label> <input type="text"
											id="singlename2" style="width: 80%; margin-top: 6px;" /><br>
										<input type="radio" value="C" name="singleanswer" style="margin-top: 4px;" />
										<label style="margin-top: 3px;" id="singleindex3">C、</label> <input type="text"
											id="singlename3" style="width: 80%; margin-top: 6px;" /><br>
										<input type="radio" value="D" name="singleanswer" style="margin-top: 4px;" />
										<label style="margin-top: 3px;" id="singleindex4">D、</label> <input type="text"
											id="singlename4" style="width: 80%; margin-top: 6px;" /><br>
									</div>
									<!--多选-->
									<div class="answerlist" style="display: none;">
										<label>多选答案选项:</label><br><input type="checkbox"
											name="mulanswer" value="A" style="margin-top: 4px;" /> <label
											style="margin-top: 3px;" id="mulindex1">A、</label> <input type="text"
											id="mulname1" style="width: 80%; margin-top: 6px;" /><br>
										<input type="checkbox" value="B" name="mulanswer" style="margin-top: 4px;" />
										<label style="margin-top: 3px;" id="mulindex2">B、</label> <input type="text"
											id="mulname2" style="width: 80%; margin-top: 6px;" /><br>
										<input type="checkbox" value="C" name="mulanswer" style="margin-top: 4px;" />
										<label style="margin-top: 3px;" id="mulindex3">C、</label> <input type="text"
											id="mulname3" style="width: 80%; margin-top: 6px;" /><br>
										<input type="checkbox" value="D" name="mulanswer" style="margin-top: 4px;" />
										<label style="margin-top: 3px;" id="mulindex4">D、</label> <input type="text"
											id="mulname4" style="width: 80%; margin-top: 6px;" /><br>
									</div>
									<!--判断-->
									<div class="answerlist" style="display: none;">
										<label>判断答案选项:</label><br><input type="radio"
											name="judgeanswer" value="1" style="margin-top: 4px;" /> <label
											style="margin-top: 3px;" id="judgeindex1">对</label> <br>
										<input type="radio" value="0" name="judgeanswer" style="margin-top: 4px;" />
										<label style="margin-top: 3px;" id="judgeindex2">错</label> <br>										
									</div>
									<!--  -->
								</div>
								<div style="margin-top: 10px;">
									<div>
										<input id="resetbutton" type="button" value="清空重录" class="btn btn-default"	
											style="margin-left: 36%;" /> 
									</div>
								</div>
							</form>
						</div>
					</div>

					<div class="col-md-6">
						<div
							style="border: 1px dashed black; margin-top: 30px; background-color: #f6f6f6;">
							<div style="width: 80%; margin: 0px auto;">
							<form name="tiform">
								<div style="margin-top: 20px;">
									<label>专业：</label><input type="hidden" name="qcourse" /><span id="qcourse"></span>
								</div>
								<div style="margin-top: 10px;">								
									<label>阶段：</label><input type="hidden" name="qstage" /><span id="qstage"></span>
								</div>
								
								<div style="margin-top: 12px; display: inline-block;">
									<label>类型：</label><input type="hidden" name="qtype" /><span id="qtype"></span>
								</div>
								<div id="spans">
								<div style="margin-top: 12px; display: inline-block; float: right;">
									<label></label><input type="hidden" name="qscore" /><span id="qscore"></span> 分
								</div>
								<div style="margin-top: 8px;">								
									<label>题目：</label><input type="hidden" name="qname" /><span style="font-weight: bold;"></span>
								</div>
								<div style="margin-top: 10px; margin-left: 16px;">
									<input type="hidden" name="qaname" /> <span></span>
								</div>
								<div style="margin-top: 5px; margin-left: 16px;">
									<input type="hidden" name="qaname" /> <span></span>
								</div>
								<div style="margin-top: 5px; margin-left: 16px;">
									<input type="hidden" name="qaname" /> <span></span>
								</div>
								<div style="margin-top: 5px; margin-left: 16px;">
									<input type="hidden" name="qaname" /> <span></span>
								</div>
								<div style="margin-top: 8px; margin-bottom: 20px;">
									<label>答案：</label><input type="hidden" name="qanswer" /><span style="color: red; font-weight: bold;"></span>
								</div>
								</div>
								<div style="margin-top: 10px; margin-bottom: 2px;">										
										<input id="tijiao" type="button" value="提交" class="btn btn-default"
											style="margin-left: 40%;" />
								</div> 
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</fieldset>
	</div>
</body>
</html>