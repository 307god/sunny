<%@ page import="entity.Teacher" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="information.Information" %>
<%@ page import="entity.Student" %>
<%@ page import="entity.Course" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: Jason Song(wolfogre.com)
  Date: 2016/4/13
  Time: 22:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<!-- BootStrap CSS -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/BootStrap/css/bootstrap.min.css"/>
	<!--DataTables CSS -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/DataTables/css/jquery.dataTables.css"/>
	<!-- jQuery -->
	<script type="text/javascript" charset="utf8" src="${pageContext.request.contextPath}/DataTables/js/jquery.js"></script>
	<!-- DataTables -->
	<script type="text/javascript" charset="utf8" src="${pageContext.request.contextPath}/DataTables/js/jquery.dataTables.js"></script>

	<title>教师页面</title>
</head>
<script type="text/javascript" class="init">
	$(document).ready(function() {
		$('#dataTable').DataTable({
			language: {
				"sProcessing": "处理中...",
				"sLengthMenu": "显示 _MENU_ 项结果",
				"sZeroRecords": "没有匹配结果",
				"sInfo": "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
				"sInfoEmpty": "显示第 0 至 0 项结果，共 0 项",
				"sInfoFiltered": "(由 _MAX_ 项结果过滤)",
				"sInfoPostFix": "",
				"sSearch": "搜索:",
				"sUrl": "",
				"sEmptyTable": "表中数据为空",
				"sLoadingRecords": "载入中...",
				"sInfoThousands": ",",
				"oPaginate": {
					"sFirst": "首页",
					"sPrevious": "上页",
					"sNext": "下页",
					"sLast": "末页"
				},
				"oAria": {
					"sSortAscending": ": 以升序排列此列",
					"sSortDescending": ": 以降序排列此列"
				}
			}
		});
	});
</script>
<body>
<%
	Teacher master = (Teacher)session.getAttribute("master");
	if(master == null){
		response.sendRedirect("/index.action");
		return;
	}
%>
<div class="page-header" >
	<div>
		<h2>&nbsp;&nbsp;&nbsp;&nbsp;教师:<%=master.getT_name()%>
			<small>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;工号:<%=master.getT_id()%></small>
			<small>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=Information.getCopyRight()%></small>
		</h2>
	</div>
</div>
<ul class="nav nav-tabs">
	<li role="presentation"><a href="index.action">基本信息</a></li>
	<li role="presentation"><a href="timetable.action">课表查询</a></li>
	<li role="presentation"><a href="list.action">学生名单查询</a></li>
	<li role="presentation" class="active"><a href="score.action">成绩登记</a></li>
	<li role="presentation"><a href="${pageContext.request.contextPath}/login.action">退出登录</a></li>
</ul>
<%
	if(!Information.isInInquireTime()){
%>
<div class="jumbotron" style="height: 100%">
	<div class="panel panel-info center-block" style="width: 50%">
		<div class="panel-body">
			<h1>登分时间未到</h1>
			<h2>当前学期：<%=Information.getTermName()%></h2>
			<h2>当前时间：<%=new SimpleDateFormat("yyyy年M月dd日 HH时mm分").format(new java.util.Date())%></h2>
			<h2>登分开始时间：<%=new SimpleDateFormat("yyyy年M月dd日 HH时mm分").format(Information.getRegisterBeginTime())%></h2>
			<h2>登分结束时间：<%=new SimpleDateFormat("yyyy年M月dd日 HH时mm分").format(Information.getRegisterEndTime())%></h2>
		</div>
	</div>
</div>
<%
		return;
	}
%>
<%
	HashMap<Integer, HashMap<String, Object>> scoreData = (HashMap<Integer, HashMap<String, Object>>)request.getAttribute("scoreData");
	Course course = (Course)request.getAttribute("course");
	if(scoreData == null){
%>
<div class="jumbotron" style="height: 100%">
	<div class="panel panel-info center-block" style="width: 50%">
		<div class="panel-body text-center">
			<h2>请在<a href="timetable.action">课表查询</a>中选择您要登记的课程</h2>
		</div>
	</div>
</div>
<%
		return;
	}
%>
<div class="text-center">
	<h2>课程号：<%=course.getC_id()%>&nbsp;&nbsp;&nbsp;&nbsp;课程名：<%=course.getC_name()%></h2>
</div>
<form action="update-score" method="post">
	<input type="text" name="o_id" class="hidden" value="<%=(Integer)request.getAttribute("o_id")%>"/>
	<table id="dataTable" class="display" cellspacing="0" width="100%">
		<thead>
		<tr>
			<th>学号</th>
			<th>姓名</th>
			<th>平时成绩</th>
			<th>考试成绩</th>
		</tr>
		</thead>
		<tbody>
		<%
			for(int index = 0; scoreData.get(index) != null; ++index )
			{
		%>
		<tr>
			<td><%=scoreData.get(index).get("学号")%></td>
			<td><%=scoreData.get(index).get("姓名")%></td>
			<td><input type="text" name="pscj_<%=scoreData.get(index).get("学号")%>" class="form-control" placeholder="未登记" value="<%=(scoreData.get(index).get("平时成绩") == null)?"":scoreData.get(index).get("平时成绩")%>"></td>
			<td><input type="text" name="kscj_<%=scoreData.get(index).get("学号")%>" class="form-control" placeholder="未登记" value="<%=(scoreData.get(index).get("考试成绩") == null)?"":scoreData.get(index).get("考试成绩")%>"></td>
		</tr>
		<%
			}
		%>
		</tbody>
	</table>
	<div class="text-center">
		<button type="submit" class="btn btn-success">&nbsp;&nbsp;&nbsp;&nbsp;提&nbsp;&nbsp;&nbsp;&nbsp;交&nbsp;&nbsp;&nbsp;&nbsp;</button>
	</div>
</form>

</body>
</html>