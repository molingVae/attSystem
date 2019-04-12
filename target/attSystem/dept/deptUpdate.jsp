<%@ page import="com.lcp.dao.UserDao" %>
<%@ page import="com.lcp.pojo.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lcp.pojo.Dept" %>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>部门修改</title>
    <link href="../css/style2.css" rel="stylesheet" type="text/css"/>
    <link href="../css/select.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/jquery.idTabs.min.js"></script>
    <script type="text/javascript" src="../js/select-ui.min.js"></script>
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

<body>
<form action="../DeptServlet?method=updateDept" method="post">
    <div class="place">
        <span>位置：</span>
        <ul class="placeul">
            <li><a href="#">部门管理</a></li>
            <li><a href="#">修改部门</a></li>
        </ul>
    </div>

    <div class="formbody">

        <div class="formtitle"><span>基本信息</span></div>

        <ul class="forminfo">
            <li>
                <label>部门编号</label>
                </label><input name="department_id" type="text" class="dfinput" readonly="readonly"
                               value="${dept.department_id}"/></li>
            <li>
                <label>部门名称</label>
                <input name="department_name" type="text" class="dfinput" value="${dept.department_name}"/>
            </li>
            <li>
                <label>负责人 </label>
                <div class="vocation">
                    <select class="select3" name="managers">
                        <option value="">--请选择--</option>
                        <%
                            UserDao userDao = new UserDao();
                            List<User> userList = userDao.userAllSearch();
                            for (User user : userList) {
                        %>
                        <option value="<%=user.getName()%>"
                                <%
                                    if (user.getName().equals(((Dept) request.getAttribute("dept")).getManagers())) {
                                %>
                                selected
                                <%
                                    }
                                %>
                        >
                            <%=user.getName() %>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </div>
            </li>
            <li><label>&nbsp;</label><input type="submit" class="btn" value="确认保存"/></li>
        </ul>
    </div>
</form>
</body>
</html>
