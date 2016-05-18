<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="information.Information" %>
<%@ page import="entity.Administrator" %>
<%@ page import="entity.SelectCourse" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>
	
    管理员页面

</title>
    

    <link href="http://cj.shu.edu.cn/Content/default/jquery-treeview-css/jquery.treeview.css"
        rel="stylesheet" type="text/css" />
   
    <link href="http://cj.shu.edu.cn/Content/default/jquery-ui-1.9.1.custom-css/jquery-ui-1.9.1.custom.css"
        rel="stylesheet" type="text/css" />
    <link href="http://cj.shu.edu.cn/Content/default/StyleBase.css" rel="stylesheet"
        type="text/css" />
    
    
    <script src="http://cj.shu.edu.cn/Scripts/datePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="http://cj.shu.edu.cn/Scripts/jquery-1.8.2.js" type="text/javascript"></script>

    
    

    <script src="http://cj.shu.edu.cn/Scripts/jquery-ui-1.9.1.custom.js" type="text/javascript"></script>
    <script src="http://cj.shu.edu.cn/Scripts/jsCommon.js" type="text/javascript"></script>
    <script src="http://cj.shu.edu.cn/Scripts/leftmenu.js" type="text/javascript"></script>
    <script src="http://cj.shu.edu.cn/Scripts/jquery.form.js" type="text/javascript"></script>
    <script src="http://cj.shu.edu.cn/Scripts/jquery-treeview-js/jquery.treeview.js" type="text/javascript"></script>

    <style type="text/css">
    @media print
    {
        .noprint
        {
            display: none;
        }
        .PageNext
        {
            page-break-after: always;
        }
    }
    </style>
	
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

    
</head>



<body>
<%
	Administrator master = (Administrator)session.getAttribute("master");
	if(master == null){
		response.sendRedirect("/index.action");
		return;
	}
%>
    <div>
        <div class="master_banner noprint">
            
            <div class="master_banner_validspace">
                <a id="aindex" class="a_index">首 页</a> 
                <span class="span_currenttitle">
                    

                </span>
                <span class="span_currentUserInfo">
                    欢迎 <%=master.getA_name()%>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/login.action">安全退出</a>
                </span>
            </div>
        </div>
        <div class="master_bannerborder noprint">
        </div>
        <div class="master_maindiv">
            <table class="master_maintable">
                <tr>
                    <td class="maintable_leftmenu noprint" id="">
                        <div id="leftmenu_information" style="width:200px;">
                            
                        </div>
                        <!--  LEFT MENU  -->
                        <div id="leftMenu">
                            
                            

<div id="leftmenu_Accordion">



    <div class="ui-accordion-header ui-helper-reset ui-state-default ui-corner-all" id="0">
        <a href="#">管理员信息</a>
    </div>
    <div class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom ui-accordion-content-active" style="padding: 1px 0px 0px 2px;">
        <div style="line-height: 23px;">
            工号：<%=master.getA_id()%>
        </div>
        <div style="line-height: 23px;">
            姓名：<%=master.getA_name()%>
        </div>
        
    </div>

    <div class="ui-accordion-header ui-helper-reset ui-state-default ui-corner-all" id="98">
        <a href="#">常用功能</a>
    </div>
    <div class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom ui-accordion-content-active">
        <ul class="ul_left_menu_basicset">
            
            
                <li role="presentation" class="active"><a href="index.action">基本信息</a></li>
				
				<li role="presentation"><a href="term.action">学期管理</a></li>
				
				<li role="presentation"><a href="student.action">学生管理</a></li>
				
				<li role="presentation"><a href="teacher.action">教师管理</a></li>
				
				<li role="presentation"><a href="manager.action">管理员管理</a></li>
				
				<li role="presentation"><a href="course.action">课程管理</a></li>
				
				<li role="presentation"><a href="open-course.action">开课管理</a></li>
				
				<li role="presentation"><a href="select-course.action">选课管理</a></li>
            

        </ul>
    </div>

</div>
                        </div>
                    </td>
                    <td class="maintable_content">
                        <!--  MAIN  -->
                        
                        <div class="div_master_content">
                            

<%
	if(request.getAttribute("error") != null){
%>
<div class="alert alert-danger center-block" role="alert" style="width: 500px;" align="center">
	<strong>错误：</strong><%=request.getAttribute("error")%>
</div>
<%
	}
%>
<form action="update-select-course" method="get">
	<table id="dataTable" class="display" cellspacing="0" width="100%">
		<thead>
		<tr>
			<th>学号</th>
			<th>开课号</th>
			<th><input type="submit" name="delete_data" value="删除"/></th>
		</tr>
		</thead>

		<tbody>

		<%
			List<SelectCourse> selectCourseList = (List<SelectCourse>)request.getAttribute("selectCourseList");
			for(SelectCourse selectCourse : selectCourseList)
			{
		%>
		<tr>
			<td><%=selectCourse.getS_id()%></td>
			<td><%=selectCourse.getO_id()%></td>
			<td><input  type="checkbox" name="cb_delete" value="<%=selectCourse.getO_id()%>"/></td>
		</tr>
		<%
			}
		%>
		</tbody>
		<tr>
			<td><input type="text" name="s_id" class="form-control" placeholder="学号"></td>
			<td><input type="text" name="o_id" class="form-control" placeholder="开课号"></td>
			<td><input type="submit" name="new_data" value="新增"/></td>
		</tr>
	</table>
</form>


                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>