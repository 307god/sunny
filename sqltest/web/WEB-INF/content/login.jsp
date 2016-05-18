<%--
  Created by IntelliJ IDEA.
  User: 孙霖
  Date: 2016/5/18
  Time: 8:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>选课系统</title>
    <link href="http://cj.shu.edu.cn/Content/default/StyleLogin.css" rel="stylesheet" type="text/css" />
</head>
<body style="text-align: center; vertical-align: middle; height: 700px; background-image:  url(http://cj.shu.edu.cn/Content/default/images/back.jpg) ;">

<div class="log_maindiv" style="text-align: center; vertical-align: middle;">
    <div class="log_submitdiv" style="width: 450px;">
        <form action="check-login.action" method="post"><input id="url" name="url" type="hidden" value="" />
            <div style="clear: left; width: 100%; height: 180px; margin-top: 100px;">
                <table style="width: 100%; height: 100px;">
                    <tr style="line-height: 30px;">
                        <td rowspan="4" style="width: 100px;">
                        </td>
                        <td align="left" style="width: 100px;">
                            <span style="font-weight: bold;">学(工)号</span>
                        </td>
                        <td style="width: 120px;">
                            <input id="id" name="id" style="float:left;width:120px;" type="text" value="" />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr style="line-height: 30px;">
                        <td align="left">
                            <span style="font-weight: bold;">密码</span><br />
                        </td>
                        <td>
                            <input id="password" name="password" style="float:left;width:120px;" type="password" value="" />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <div class="checkbox text-center">
                        <label>
                            <input type="radio" id="login-type1" name="loginType" value="student" checked>学生
                        </label>
                        <label>
                            <input type="radio" id="login-type2" name="loginType" value="teacher">教师
                        </label>
                        <label>
                            <input type="radio" id="login-type3" name="loginType" value="manager">管理员
                        </label>
                    </div>
                    <tr style="line-height: 30px;">
                        <td colspan="2">
                            <button type="submit">登录</button>
                            <button type="reset">重置</button>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="20">
                            <div id="divLoginAlert">

                            </div>
                        </td>
                    </tr>
                </table>

            </div>
        </form>
    </div>
    <span style="color:White">6</span>
    <%
        if(request.getAttribute("error") != null){
    %>
    <div class="alert alert-danger center-block" role="alert" style="width: 500px;" align="center">
        <strong>登录失败！</strong><%=request.getAttribute("error")%>
    </div>
    <%
        }
    %>
</div>
</body>
</html>
