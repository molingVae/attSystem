<%@ page import="com.lcp.dao.DeptDao" %>
<%@ page import="com.lcp.pojo.Dept" %>
<%@ page import="com.lcp.pojo.User" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>用户添加</title>
    <link href="../css/style2.css" rel="stylesheet" type="text/css"/>
    <link href="../css/select.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/jquery.idTabs.min.js"></script>
    <script type="text/javascript" src="../js/select-ui.min.js"></script>
    <script type="text/javascript" src="../js/WdatePicker.js"></script>
    <script type="text/javascript">
        KE.show({
            id: 'content7',
            cssPath: './index.css'
        });
    </script>

    <script type="text/javascript">
        $(document).ready(function (e) {
            $(".select1").uedSelect({
                width: 345
            });
            $(".select2").uedSelect({
                width: 167
            });
            $(".select3").uedSelect({
                width: 100
            });
        });
    </script>


</head>


<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="#">用户管理</a></li>
        <li><a href="#">修改用户</a></li>
    </ul>
    <a style="line-height:1.6em;margin-top:10px;margin-right:20px;float:right"
       href="javascript:location.replace(location.href);"
       title="刷新"><img src="../img/sx.png" style="width: 25px" alt=""/></a>
</div>

<div class="formbody">
    <form action="../UserServlet?method=updateUser&info=my" method="post" onsubmit="return toVaild()">
        <div class="formtitle"><span>基本信息</span></div>
        <input name="id" value="${sessionScope.user.id}" type="hidden"/>
        <input name="password" value="${sessionScope.user.password}" type="hidden"/>
        <input name="user_type" value="${sessionScope.user.user_type}" type="hidden"/>
        <input name="mylevel" value="${sessionScope.user.mylevel}" type="hidden"/>
        <ul class="forminfo">
            <li>
                <label>工号 <font color="red">*</font></label>
                <input name="account" type="text" class="scinput" value="${sessionScope.user.account}"
                       readonly="readonly"/>
            </li>
            <li>
                <label>姓名 <font color="red">*</font></label>
                <input name="name" type="text" class="dfinput" value="${sessionScope.user.name}"/>
            </li>

            <li><label>部门</label>
                <div class="vocation">
                    <select class="select3" name="department_id">
                        <option value="">--请选择--</option>
                        <%
                            DeptDao deptDao = new DeptDao();
                            List<Dept> deptList = deptDao.deptAllSearch();
                            for (Dept dept : deptList) {
                        %>
                        <option value="<%= dept.getDepartment_id()%>"
                                <%
                                    if (dept.getDepartment_id() == ((User) session.getAttribute("user")).getDepartment_id()) {
                                %>
                                selected
                                <%
                                    }
                                %>
                        >
                            <%= dept.getDepartment_name() %>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </div>
            </li>
            <li>
                <label>性别</label>
                <cite>
                    <c:if test="${sessionScope.user.sex==0}">
                        <input name="sex" type="radio" value="0" checked="checked"/>
                        男&nbsp;&nbsp;&nbsp;&nbsp;
                        <input name="sex" type="radio" value="1"/>
                        女
                    </c:if>
                    <c:if test="${sessionScope.user.sex==1}">
                        <input name="sex" type="radio" value="0"/>
                        男&nbsp;&nbsp;&nbsp;&nbsp;
                        <input name="sex" type="radio" value="1" checked="checked"/>
                        女
                    </c:if>

                </cite>
            </li>
            <li><label>手机号码 <font color="red">*</font></label><input name="mobile" type="text" class="dfinput"
                                                                     value="${sessionScope.user.mobile}"/></li>
            <li><label>出生日期</label>
                <input name="birthday" type="text" class="dfinput" value="${sessionScope.user.birthday}"
                       onClick="WdatePicker({work_date:'',dateFmt:'yyyy-MM-dd'})"/></li>
            <li><label>邮箱 <font color="red">*</font></label><input name="email" type="text" class="dfinput"
                                                                   value="${sessionScope.user.email}"/></li>
            <li><label>&nbsp;</label><input type="submit" class="btn" value="确认保存"/></li>
        </ul>
    </form>
</div>

<script language="javascript">
    function toVaild() {

        var phoneReg = /^1[3-578]\d{9}$/;
        var mailReg = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;


        if (!phoneReg.test($("input[name='mobile']").val())) {
            alert("手机号不符号要求！！");
            return false;
        }

        if (!mailReg.test($("input[name='email']").val())) {
            alert("邮箱不符合要求！！");
            return false;
        }
        return true;
    }
</script>
</body>
</html>
