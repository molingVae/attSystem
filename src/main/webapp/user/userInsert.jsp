<%@ page import="com.lcp.dao.DeptDao" %>
<%@ page import="com.lcp.pojo.Dept" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

<body>
<form action="../UserServlet?method=addUser" method="post" onsubmit="return toVaild()">
    <div class="place">
        <span>位置：</span>
        <ul class="placeul">
            <li><a href="#">用户管理</a></li>
            <li><a href="#">添加用户</a></li>
        </ul>
    </div>

    <div class="formbody">

        <div class="formtitle"><span>基本信息</span></div>

        <ul class="forminfo">
            <li>
                <label>工号 <font color="red">*</font></label>
                </label><input name="account" type="text" class="dfinput" required/></li>
            <li><label>用户权限</label>
                <div class="vocation">
                    <select class="select3" name="mylevel" required>
                        <option selected>--请选择--</option>
                        <option value="0">超级管理员</option>
                        <option value="1">部门主管</option>
                        <option value="2">普通员工</option>
                    </select>
                </div>

            <li>
            <li><label>用户类型</label>
                <div class="vocation">
                    <select class="select3" name="user_type" required>
                        <option selected>--请选择--</option>
                        <option value="0">超级管理员</option>
                        <option value="1">部门主管</option>
                        <option value="2">普通员工</option>
                    </select>
                </div>

            <li>
            <li>
                <label>密码 <font color="red">*</font></label>
                <input name="password" type="password" class="dfinput" placeholder="密码长度要大于6位，由数字和字母组成"/>
            </li>
            <li>
                <label>确认密码 <font color="red">*</font></label><input name="q_password" type="password" class="dfinput"/>
            </li>
            <li>
                <label>姓名 <font color="red">*</font></label>
                </label><input name="name" type="text" class="dfinput" required/>
            </li>
            <li><label>部门</label>
                <div class="vocation">
                    <select class="select3" name="department_id" required>
                        <option value="">--请选择--</option>
                        <%
                            DeptDao deptDao = new DeptDao();
                            List<Dept> deptList = deptDao.deptAllSearch();
                            for (Dept dept : deptList) {
                        %>
                        <option value="<%= dept.getDepartment_id()%>">
                            <%= dept.getDepartment_name() %>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </div>

            <li>
                <label>性别</label>
                <cite><input name="sex" type="radio" value="0" checked="checked"/>
                    男&nbsp;&nbsp;&nbsp;&nbsp;
                    <input name="sex" type="radio" value="1"/>
                    女</cite></li>
            <li><label>手机号码 <font color="red">*</font></label><input name="mobile" type="text" class="dfinput"
                                                                     value=""/></li>
            <li><label>出生日期</label><input required name="birthday" type="text" class="dfinput" value=""
                                          onClick="WdatePicker({startDate:'',dateFmt:'yyyy-MM-dd'})"/></li>
            <li><label>邮箱 <font color="red">*</font></label><input name="email" type="text" class="dfinput" value=""/>
            </li>
            <li><label>&nbsp;</label><input type="submit" class="btn" value="确认保存"/>
                <input type="reset" class="btn" value="重置" style="width: 80px"/></li>
        </ul>
    </div>
</form>

<script language="javascript">
    //正则表达式进行前台校验
    function toVaild() {

        var phoneReg = /^1[3-578]\d{9}$/;
        var mailReg = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
        var passReg = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,}$/;


        var password = $("input[name='password']").val();
        var q_password = $("input[name='q_password']").val();

        if (!passReg.test(password) || !passReg.test(q_password)) {
            alert("密码长度要大于6位，由数字和字母组成!!");
            return false;
        }
        //alert(val);
        if (password != q_password) {
            alert("密码与确定密码不同！！");
            return false;
        }

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
