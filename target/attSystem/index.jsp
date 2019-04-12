<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>无标题文档</title>
    <link href="css/style2.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="js/jquery.js"></script>

</head>
<%
    int i = Integer.parseInt(new SimpleDateFormat("HH").format(new Date()));
    Boolean flag = i > 12;
%>

<body>

<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="#">首页</a></li>
    </ul>
    <a style="line-height:1.6em;margin-top:10px;margin-right:20px;float:right"
       href="javascript:location.replace(location.href);"
       title="刷新"><img src="../img/sx.png" style="width: 25px" alt=""/></a>
</div>

<div class="mainindex">


    <div class="welinfo">
        <span><img src="images/sun.png" alt="天气"/></span>
        <b>${sessionScope.user.name}&nbsp;
            <c:choose>
                <c:when test="<%=flag%>">
                    下午好
                </c:when>
                <c:otherwise>
                    上午好
                </c:otherwise>
            </c:choose>
            ，欢迎使用考勤管理系统</b>
    </div>

    <div class="welinfo">
        <span><img src="images/time.png" alt="时间"/></span>
        <i>
            您本次次登录的时间：<%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())%>
        </i>
    </div>

</body>
</html>
