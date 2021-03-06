<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="information.Information" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.*" %>

<%--
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

	<title>管理员页面</title>
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
	Administrator master = (Administrator)session.getAttribute("master");
	if(master == null){
		response.sendRedirect("/index.action");
		return;
	}
%>
<div class="page-header" >
	<div>
		<h2>&nbsp;&nbsp;&nbsp;&nbsp;管理员:<%=master.getA_name()%>
			<small>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;工号:<%=master.getA_id()%></small>
			<small>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=Information.getCopyRight()%></small>
		</h2>
	</div>
</div>
<ul class="nav nav-tabs">
	<li role="presentation"><a href="index.action">基本信息</a></li>
	<li role="presentation"><a href="term.action">学期管理</a></li>
	<li role="presentation"><a href="student.action">学生管理</a></li>
	<li role="presentation"><a href="teacher.action">教师管理</a></li>
	<li role="presentation"><a href="manager.action">管理员管理</a></li>
	<li role="presentation"><a href="course.action">课程管理</a></li>
	<li role="presentation" class="active"><a href="open-course.action">开课管理</a></li>
	<li role="presentation"><a href="select-course.action">选课管理</a></li>
	<li role="presentation"><a href="${pageContext.request.contextPath}/login.action">退出登录</a></li>
</ul>
<%
	if(request.getAttribute("error") != null){
%>
<div class="alert alert-danger center-block" role="alert" style="width: 500px;" align="center">
	<strong>错误：</strong><%=request.getAttribute("error")%>
</div>
<%
	}
%>
<form action="update-open-course" method="get">
	<table id="dataTable" class="display" cellspacing="0" width="100%">
		<thead>
		<tr>
			<th>开课号</th>
			<th>课号</th>
			<th>教师号</th>
			<th>学期</th>
			<th>教室</th>
			<th>时间</th>
			<th>容量</th>
			<th><input type="submit" name="delete_data" value="删除"/></th>
		</tr>
		</thead>

		<tbody>

		<%
			List<OpenCourse> openCourseList = (List<OpenCourse>)request.getAttribute("openCourseList");
			for(OpenCourse openCourse : openCourseList)
			{
		%>
		<tr>
			<td><%=openCourse.getO_id()%></td>
			<td><%=openCourse.getC_id()%></td>
			<td><%=openCourse.getT_id()%></td>
			<td><%=openCourse.getD_term()%></td>
			<td><%=openCourse.getO_room()%></td>
			<td><%=openCourse.getO_time()%></td>
			<td><%=openCourse.getO_cap()%></td>
			<td><input  type="checkbox" name="cb_delete" value="<%=openCourse.getC_id()%>"/></td>
		</tr>
		<%
			}
		%>
		</tbody>
		<tr>
			<td><input type="text" name="o_id" class="form-control" placeholder="编号" readonly></td>
			<td><input type="text" name="c_id" class="form-control" placeholder="课号"></td>
			<td><input type="text" name="t_id" class="form-control" placeholder="教师号"></td>
			<td><input type="text" name="d_term" class="form-control" placeholder="学期"></td>
			<td><input type="text" name="o_room" class="form-control" placeholder="教室"></td>
			<td><input type="text" name="o_time" class="form-control" placeholder="时间"></td>
			<td><input type="text" name="o_cap" class="form-control" placeholder="容量"></td>
			<td><input type="submit" name="new_data" value="新增"/></td>
		</tr>
	</table>
</form>
</body>
</html>