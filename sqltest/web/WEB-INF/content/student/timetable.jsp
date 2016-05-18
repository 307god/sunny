<!DOCTYPE html>
<%@ page import="entity.Student" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="information.Information" %>
<%@ page import="entity.SelectCourse" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.OpenCourse" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>
	
    学生页面

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
	Student master = (Student)session.getAttribute("master");
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
                    欢迎 <%=master.getS_name()%>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/login.action">安全退出</a>
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
        <a href="#">学生信息</a>
    </div>
    <div class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom ui-accordion-content-active" style="padding: 1px 0px 0px 2px;">
        <div style="line-height: 23px;">
            学号：<%=master.getS_id()%>
        </div>
        <div style="line-height: 23px;">
            姓名：<%=master.getS_name()%>
        </div>
        
    </div>

    <div class="ui-accordion-header ui-helper-reset ui-state-default ui-corner-all" id="98">
        <a href="#">常用功能</a>
    </div>
    <div class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom ui-accordion-content-active">
        <ul class="ul_left_menu_basicset">
            
            
                <li role="presentation"><a href="index.action">基本信息</a></li>
            
                <li role="presentation"><a href="timetable.action">课表查询</a></li>
				
				<li role="presentation"><a href="score.action">成绩查询</a></li>
				
				<li role="presentation"><a href="course.action">选课退课</a></li>
            

        </ul>
    </div>

</div>
                        </div>
                    </td>
                    <td class="maintable_content">
                        <!--  MAIN  -->
                        
                        <div class="div_master_content">
                            

<table id="dataTable1" class="display" cellspacing="0" width="100%">
	<thead>
	<tr>
		<th>序号</th>
		<th>课程号</th>
		<th>课程名</th>
		<th>教师号</th>
		<th>教师名</th>
		<th>学分</th>
		<th>上课时间</th>
		<th>上课地点</th>
	</tr>
	</thead>

	<tbody>

	<%
		HashMap<Character, HashMap<String, Object>> selectData = (HashMap<Character, HashMap<String, Object>>)request.getAttribute("selectData");
		Information.initTimeTable();
		for(char index = 'A'; selectData.get(index) != null; ++index )
		{
	%>
	<tr>
		<td><%=index%></td>
		<td><%=selectData.get(index).get("课程号")%></td>
		<td><%=selectData.get(index).get("课程名")%></td>
		<td><%=selectData.get(index).get("教师号")%></td>
		<td><%=selectData.get(index).get("教师名")%></td>
		<td><%=selectData.get(index).get("学分")%></td>
		<td><%=Information.getCourseTimeString(index, selectData.get(index).get("上课时间").toString())%></td>
		<td><%=selectData.get(index).get("上课地点")%></td>
	</tr>
	<%
		}
	%>
	</tbody>
</table>
<table id="dataTable2" class="cell-border" style="text-align:center" cellspacing="0" width="100%">
	<thead>
	<tr>
		<th  style="text-align:center">时间</th>
		<th  style="text-align:center">星期一</th>
		<th  style="text-align:center">星期二</th>
		<th  style="text-align:center">星期三</th>
		<th  style="text-align:center">星期四</th>
		<th  style="text-align:center">星期五</th>
		<th  style="text-align:center">星期六</th>
		<th  style="text-align:center">星期日</th>
	</tr>
	</thead>

	<tbody>

	<%
		char[][] timeTable = Information.getTimeTable();
		for(int raw = 0; raw < 13; ++raw)
		{
	%>
	<tr>
		<td><%=raw + 1%></td>
		<%
			for(int col = 0; col < 7; ++col) {
				if(timeTable[raw][col] != Character.MIN_VALUE){
					%><td><%=timeTable[raw][col]%></td><%
				} else {
					%><td></td><%
				}
			}
		%>
	</tr>
	<%
		}
	%>
	</tbody>
</table>


                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>