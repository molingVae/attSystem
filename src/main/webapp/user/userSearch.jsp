<%@ page import="com.lcp.dao.DeptDao" %>
<%@ page import="com.lcp.pojo.Dept" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>用户管理</title>
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
    <script type="text/javascript">
        $(function () {
            //全选全不选
            $('#allSelect').click(function () {
                if ($(this).is(':checked')) {
                    $('.userSelect').attr("checked", "checked");
                } else {
                    $('.userSelect').removeAttr("checked");
                }
            });
            //若是userSelect被选中，则...
            $('.userSelect').click(function () {
                var flag = false;
                $('.userSelect').each(function () {
                    if (!$(this).is(':checked')) {
                        flag = true;
                    }
                });
                if (flag) {
                    $('#allSelect').removeAttr("checked");
                } else {
                    $('#allSelect').attr("checked", "checked");

                }
            });


        });

        //批量删除
        function userCheckDelete() {
            if (confirm('确定要删除所选用户吗？')) {
                var id = '';
                $('.userSelect').each(function () {
                    if ($(this).is(':checked')) {
                        id += $(this).val() + ',';
                    }
                });

                window.location.href = "UserServlet?method=userCheckDelete&ids=" + id;
            }
        }


    </script>
</head>

<body>

<div class="place">
    <span>位置：</span>
    <ul class=" placeul">
        <li><a href="#">用户管理</a></li>
    </ul>
    <a style="line-height:1.6em;margin-top:10px;margin-right:20px;float:right"
       href="javascript:location.replace(location.href);"
       title="刷新"><img src="../img/sx.png" style="width: 25px" alt=""/></a>
</div>

<!--查询条件-->
<br/>
<br/>
<ul class="seachform">
    <form action="../UserServlet?method=userSearch" method="post">
        <li><label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;姓名</label><input name="name" type="text" class="scinput"/>
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
                    <option value="<%= dept.getDepartment_id()%>">
                        <%= dept.getDepartment_name() %>
                    </option>
                    <%
                        }
                    %>
                </select>
            </div>
        </li>

        <li><label>&nbsp;</label><input type="submit" class="scbtn" value="查询"/></li>
    </form>
</ul>
</div>

<div class="tools">
    <ul class="toolbar">
        <li class="click"><span><img src="../images/t01.png"/></span><a href="user/userInsert.jsp">添加</a></li>
        <li class="click"><img src="../images/trash.png"/></span><a onclick="userCheckDelete()"
                                                                    target="rightFrame">删除</a></li>
    </ul>
</div>


<table class="tablelist">
    <tbody>
    <tr>
        <td>
            <table class="tablelist">
                <tbody>
                <tr>
                    <td>
                        <table class="tablelist">
                            <tbody>
                            <tr>
                                <td>
                                    <table class="tablelist" id="t_user">
                                        <thead>
                                        <tr>
                                            <th><input id="allSelect" type="checkbox"/></th>
                                            <th width="7%">工号<i class="sort"><img src="../images/px.gif"/></i></th>
                                            <th width="11%">姓名</th>
                                            <th width="10%">部门</th>
                                            <th width="9%">职务</th>
                                            <th width="11%">注册时间</th>
                                            <th width="5%">性别</th>
                                            <th width="10%">手机</th>
                                            <th width="9%">出生日期</th>
                                            <th width="12%">邮箱</th>
                                            <th width="13%">操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${requestScope.userList}" var="user">
                                            <tr>
                                                <td><input class="userSelect" type="checkbox" value="${user.id}"/></td>
                                                <td>${user.account}</td>
                                                <td>${user.name}</td>
                                                <td>
                                                        ${user.department_name}
                                                <td>
                                                    <c:if test="${user.user_type==0}">超级管理员</c:if>
                                                    <c:if test="${user.user_type==1}">部门主管 </c:if>
                                                    <c:if test="${user.user_type==2}">普通员工</c:if>
                                                </td>
                                                <td>${user.create_time}</td>
                                                <td><c:if test="${user.sex==0}">男</c:if>
                                                    <c:if test="${user.sex==1}">女</c:if></td>
                                                <td>${user.mobile}</td>
                                                <td>${user.birthday}</td>
                                                <td>${user.email}</td>
                                                <td><span><a href="../UserServlet?method=getUserById&id=${user.id}"
                                                             class="tablelink"><img
                                                        src="../images/user_edit.png"/>修改</a>
                                                    <a href="../UserServlet?method=deleteUser&id=${user.id}"
                                                       class="tablelink"
                                                       onclick="Javascript:return confirm('确定要删除吗？');">
                                                        <img src="../images/trash.png"/>删除</a></span></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                </tbody>
            </table>
        </td>
    </tr>
    </tbody>
</table>
<div class="pagin">
    <div class="message">
        共<i id="spanTotalInfor" class="blue"></i>条记录,
        当前显示第&nbsp;<i id="spanPageNum" class="blue">&nbsp;</i>页
       ,共<i id="spanTotalPage" class="blue"></i>页</div>
    <ul class="paginList" style="font-family: '微软雅黑', '宋体'">
        <i id="spanFirst">首页</i>
        <i id="spanPre">上一页</i>
        <i id="spanInput" style="margin: 0px; padding: 0px 0px 4px 0px; height:100%; ">
                第&nbsp;<input id="Text1" type="text" class="TextBox" onkeyup="changepage()"
                        style="height:20px; text-align: center;width:50px"/>页
            </i>
        <i id="spanNext">下一页</i>
        <i id="spanLast">尾页</i>
    </ul>
</div>


<div class="tip">
    <div class="tiptop"><span>提示信息</span><a></a></div>

    <div class="tipinfo">
        <span><img src="images/ticon.png"/></span>
        <div class="tipright">
            <p>是否确认对信息的修改 ？</p>
            <cite>如果是请点击确定按钮 ，否则请点取消。</cite>
        </div>
    </div>

    <div class="tipbtn">
        <input name="" type="button" class="sure" value="确定"/>&nbsp;
        <input name="" type="button" class="cancel" value="取消"/>
    </div>

</div>


</div>

<script type="text/javascript">
    var theTable = document.getElementById("t_user");
    var txtValue = document.getElementById("Text1").value;

    function changepage() {
        var txtValue2 = document.getElementById("Text1").value;
        if (txtValue != txtValue2) {
            if (txtValue2 > pageCount()) {

            }
            else if (txtValue2 <= 0) {

            }
            else if (txtValue2 == 1) {
                first();
            }
            else if (txtValue2 == pageCount()) {
                last();
            }
            else {
                hideTable();
                page = txtValue2;
                pageNum2.value = page;

                currentRow = pageSize * page;
                maxRow = currentRow - pageSize;
                if (currentRow > numberRowsInTable) currentRow = numberRowsInTable;
                for (var i = maxRow; i < currentRow; i++) {
                    theTable.rows[i].style.display = '';
                }
                if (maxRow == 0) {
                    preText();
                    firstText();
                }
                showPage();
                nextLink();
                lastLink();
                preLink();
                firstLink();
            }

            txtValue = txtValue2;
        }
    }

</script>
<script type="text/javascript" src="../js/Pageging.js"></script>
<script type="text/javascript">
    $('.tablelist tbody tr:odd').addClass('odd');

    //初始化页面提交表单
    function submitForm() {
        $('form').submit();
    }

    function userDelete() {
        confirm("确定删除该权限?")

        if (confirm("确定删除该权限?")) {
            //点击确定后操作

        }
    }
</script>
</body>
</html>
