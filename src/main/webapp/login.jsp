<%@ page import="java.net.URLDecoder" %>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>考勤管理系统</title>
    <link rel="shortcut icon" href="img/logo.png" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="css/style1.css"/>
    <link rel="stylesheet" type="text/css" href="css/body.css"/>
</head>


<%
    String name = "";
    String password = "";
    Cookie[] cookies = request.getCookies();
    //判断是否存在Cookie
    if (cookies != null && cookies.length > 0) {
        for (Cookie cookie : cookies) {
            if ("name".equals(cookie.getName())) {
                name = cookie.getValue();
            }
            if ("password".equals(cookie.getName())) {
                password = cookie.getValue();
            }
        }
    }
%>
<body>
<div class="container">
    <section id="content">
        <form action="UserServlet?method=login" method="post">
            <h1>考勤管理系统</h1>
            <div>
                <input type="text" placeholder="用户名" required="" value="<%=URLDecoder.decode(name, "utf-8")%>"
                       id="username" name="name"/>
            </div>
            <div>
                <input type="password" placeholder="密码" required="" value="<%=password%>" id="password"
                       name="password"/>
            </div>
            <div class="">
                <span class="help-block u-errormessage" id="js-server-helpinfo">&nbsp;</span></div>
            <div>
                <!-- <input type="submit" value="Log in" /> -->
                <input type="submit" value="登录" class="btn btn-primary" id="js-btn-login"/>
                <label> <input name="rememberMe" value="rememberMe" type="checkbox" checked="checked"/>记住密码</label>
                <label> <input name="autoLogin" value="autoLogin" type="checkbox"/>自动登录</label>
            </div>
        </form><!-- form -->
        <c:if test="${message!=null}">
            <span style="color:#ff2f17;">${ message }</span>
        </c:if>
    </section><!-- content -->
</div>
<br><br><br><br>

</body>
</html>
