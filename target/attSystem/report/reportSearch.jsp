<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>用户管理</title>
    <link href="../css/style2.css" rel="stylesheet" type="text/css"/>
    <link href="../css/select.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="../css/style.css"/>
    <link rel="stylesheet" type="text/css" href="../css/WdatePicker.css"/>
    <link rel="stylesheet" type="text/css" href="../css/skin_/form.css"/>
    <link href="../umeditor/themes/default/_css/umeditor.css" type="text/css" rel="stylesheet">
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/jquery.idTabs.min.js"></script>
    <script type="text/javascript" src="../js/select-ui.min.js"></script>

    <script type="text/javascript" src="../js/global.js"></script>
    <script type="text/javascript" src="../js/jquery.select.js"></script>
    <script type="text/javascript" src="../js/WdatePicker.js"></script>
    <script type="text/javascript" src="../js/umeditor.config.js"></script>
    <script type="text/javascript" src="../js/editor_api.js"></script>
    <script type="text/javascript" src="../umeditor/lang/zh-cn/zh-cn.js"></script>
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
                    $('.reportSelect').attr("checked", "checked");
                } else {
                    $('.reportSelect').removeAttr("checked");
                }
            });
            //若是userSelect被选中，则...
            $('.reportSelect').click(function () {
                var flag = false;
                $('.reportSelect').each(function () {
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
        function reportCheckDelete() {
            if (confirm('确定要删除所选日报吗？')) {
                var id = '';
                $('.reportSelect').each(function () {
                    if ($(this).is(':checked')) {
                        id += $(this).val() + ',';
                    }
                });

                window.location.href = "ReportServlet?method=reportCheckDelete&ids=" + id;
            }
        }


    </script>
</head>

<body>

<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="#">日报管理</a></li>
    </ul>
    <a style="line-height:1.6em;margin-top:10px;margin-right:20px;float:right"
       href="javascript:location.replace(location.href);"
       title="刷新"><img src="../img/sx.png" style="width: 25px" alt=""/></a>
</div>

<!--查询条件-->
<br/>
<br/>
<form action="../ReportServlet?method=reportSearch" method="post">
    <ul class="seachform">
        <li>
            <label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;姓名</label><input name="name" type="text" class="scinput"/>
        </li>
        <li>
            <label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;开始日期</label><input name="startTime" type="text"
                                                                                 class="scinput"
                                                                                 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
        </li>
        <li>
            <label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;结束日期</label><input name="endTime" type="text"
                                                                                 class="scinput"
                                                                                 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
        </li>

        <li><label>&nbsp;</label><input name="" type="submit" class="scbtn" value="查询"/></li>

    </ul>
</form>
</div>

<div class="tools">

    <ul class="toolbar">
        <li class="click"><span><img src="../images/t01.png"/></span><a href="report/reportInsert.jsp"
                                                                        target="_self">添加</a>
        </li>
        <li class="click"><img src="../images/trash.png"/></span><a onclick="reportCheckDelete()"
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
                                    <table class="tablelist" id="t_report">
                                        <thead>
                                        <tr>
                                            <th width="3%"><input id="allSelect" type="checkbox"/>
                                            </th>
                                            <th width="7%">工号<i class="sort"><img src="../images/px.gif"/></i></th>
                                            <th width="11%">姓名</th>
                                            <th width="10%">日期</th>
                                            <th width="9%">作业进度</th>
                                            <th width="11%">作业内容</th>
                                            <th width="7%">问题点</th>
                                            <th width="8%">联络事项</th>
                                            <th width="13%">操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${requestScope.reportList}" var="report">
                                            <tr>
                                                <td><input class="reportSelect" type="checkbox"
                                                           value="${report.report_id}"/></td>
                                                <td>${report.report_id}</td>
                                                <td>${report.name}</td>
                                                <td>${report.report_date}</td>
                                                <td>${report.work_process}</td>
                                                <td>${report.work_content}</td>
                                                    <%--  <td>${report.tomorrow_plan}</td>--%>
                                                <td>${report.problem}</td>
                                                <td>${report.other}</td>
                                                <td><span><a
                                                        href="../ReportServlet?method=getReportById&id=${report.report_id}"
                                                        class="tablelink"><img
                                                        src="../images/user_edit.png"/>修改</a>
                                                      <a href="../ReportServlet?method=deleteReport&id=${report.report_id}"
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
        ,共<i id="spanTotalPage" class="blue"></i>页
    </div>
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
    var theTable = document.getElementById("t_report");
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
</script>
</body>
</html>
