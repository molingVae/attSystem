<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
<form action="../ReportServlet?method=updateReport" method="post">
    <div class="place">
        <span>位置：</span>
        <ul class="placeul">
            <li><a href="#">日报管理</a></li>
            <li><a href="#">修改日报</a></li>
        </ul>
    </div>

    <div class="formbody">

        <div class="formtitle"><span>基本信息</span></div>
        <input value="${report.report_id}" name="report_id" type="hidden"/>
        <input value="${report.account}" name="account" type="hidden"/>
        <ul class="forminfo">
            <li>
                <label>姓名</label>
                </label><input type="text" class="dfinput" value="${report.name}" readonly="readonly"/>
            </li>
            <li>
                <label>日期 <font color="red">*</font></label>
                <input name="report_date" type="text" class="dfinput" value="${report.report_date}"
                       onClick="WdatePicker({work_date:'',dateFmt:'yyyy-MM-dd'})"/>
            </li>
            <li>
                <label>作业进度 <font color="red">*</font></label>
                <input name="work_process" type="text" class="dfinput"
                                                                     value="${report.work_process}"/>
            </li>
            <li>
                <label>作业内容<font color="red">*</font></label>
                </label>
                <textarea rows="5" cols="10" id="tomorrow_plan2" required="required"
                          name="work_content"
                          style="width: 500px; height: 30px; padding-left:5px; border: 1px solid #eaeff2; margin-top: 20px;ime-mode:disabled;"
                          maxlength="255">${report.work_content}</textarea>
            </li>

            <li>
                <label>明日计划 <font color="red">*</font></label>
                <textarea rows="5" cols="10" id="tomorrow_plan" required="required"
                          name="tomorrow_plan"
                          style="width: 500px; height: 30px; padding-left:5px; border: 1px solid #eaeff2; margin-top: 20px;ime-mode:disabled;"
                          maxlength="255">${report.tomorrow_plan}</textarea></li>
            <li>
                <label>问题点</label>
                <textarea rows="5" cols="10" id="tomorrow_plan4" required="required"
                          name="problem"
                          style="width: 500px; height: 30px; padding-left:5px; border: 1px solid #eaeff2; margin-top: 20px;ime-mode:disabled;"
                          maxlength="255">${report.problem}</textarea>
            </li>
            <li>
                <label>需联络事项</label>
                <textarea rows="5" cols="10" id="tomorrow_plan3" required="required"
                          name="other"
                          style="width: 500px; height: 30px; padding-left:5px; border: 1px solid #eaeff2; margin-top: 20px;ime-mode:disabled;"
                          maxlength="255">${report.other}</textarea>
            </li>
            <li><label>&nbsp;</label><input name="" type="submit" class="btn" value="确认保存"/></li>
        </ul>
    </div>
</form>
</body>
</html>
