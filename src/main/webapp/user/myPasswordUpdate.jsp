<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
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
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js"></script>
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
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="#">密码修改</a></li>
    </ul>
    <a style="line-height:1.6em;margin-top:10px;margin-right:20px;float:right"
       href="javascript:location.replace(location.href);"
       title="刷新"><img src="../img/sx.png" style="width: 25px" alt=""/></a>
</div>

<div class="formbody">
    <form action="../UserServlet?method=updatePass" method="post" onsubmit="return toVaild()">
        <ul class="forminfo">
            <li>
                <label>密码 <font color="red">*</font></label>
                <input name="password" type="password" class="dfinput" placeholder="密码长度要大于6位，由数字和字母组成"/>
            </li>
            <li>
                <label>确认密码 <font color="red">*</font></label><input name="q_password" type="password"
                                                                     class="dfinput"/>
            </li>
            <li><label>&nbsp;</label><input type="submit" class="btn" value="确认保存"/></li>

        </ul>
    </form>
</div>
</form>
<script language="javascript">
    function toVaild() {

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
    }
</script>
</body>
</html>
