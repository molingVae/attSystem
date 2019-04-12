<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=emulateIE7"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="css/style.css"/>
    <link rel="stylesheet" href="css/zTreeStyle/zTreeStyle.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="css/skin_/nav.css"/>
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/global.js"></script>
    <title>底部内容页</title>
</head>

<body>
<div id="rounded-corner">
    <div id="bd">
        <div class="sidebar">
            <div class="sidebar-bg"></div>
            <i class="sidebar-hide"></i>
            <ul class="nav">

                <c:if test="${sessionScope.user.mylevel ==0 || sessionScope.user.mylevel ==1}">
                    <li class="nav-li current">
                        <a href="javascript:;" class="ue-clear"><i class="nav-ivon"></i><span
                                class="nav-text">用户管理</span></a>
                        <ul class="subnav">
                            <li class="subnav-li" href="index.jsp" data-id="1"><a href="javascript:;"
                                                                                  class="ue-clear"><i
                                    class="subnav-icon"></i><span class="subnav-text">首页</span></a></li>
                            <li class="subnav-li" href="UserServlet?method=userSearch" data-id="2"><a
                                    href="javascript:;"
                                    class="ue-clear"><i
                                    class="subnav-icon"></i><span class="subnav-text">用户管理</span></a></li>
                        </ul>
                    </li>
                </c:if>
                <c:if test="${sessionScope.user.mylevel ==0}">
                    <li class="nav-li last-nav-li">
                        <a href="javascript:;" class="ue-clear"><i class="nav-ivon"></i><span
                                class="nav-text">部门管理</span></a>
                        <ul class="subnav">
                            <li class="subnav-li" data-id="10" href="DeptServlet?method=deptSearch"><a
                                    href="javascript:;"
                                    class="ue-clear"><i
                                    class="subnav-icon"></i><span class="subnav-text">部门管理</span></a></li>
                        </ul>
                    </li>
                </c:if>
                <c:if test="${sessionScope.user.mylevel ==1 || sessionScope.user.mylevel ==2}">
                    <li class="nav-li last-nav-li">
                        <a href="javascript:;" class="ue-clear"><i class="nav-ivon"></i><span
                                class="nav-text">日报管理</span></a>
                        <ul class="subnav">
                            <li class="subnav-li" data-id="12" href="ReportServlet?method=reportSearch"><a href="javascript:;"
                                                                                                  class="ue-clear"><i
                                    class="subnav-icon"></i><span class="subnav-text">日报管理</span></a></li>
                        </ul>
                    </li>
                </c:if>
                <c:if test="${sessionScope.user.mylevel ==2}">
                    <li class="nav-li last-nav-li">
                        <a href="javascript:;" class="ue-clear"><i class="nav-ivon"></i><span
                                class="nav-text">加班管理</span></a>
                        <ul class="subnav">
                            <li class="subnav-li" data-id="13" href="workmanager/workSearch.html"><a href="javascript:;"
                                                                                                     class="ue-clear"><i
                                    class="subnav-icon"></i><span class="subnav-text">加班申请</span></a></li>
                        </ul>
                    </li>
                    <li class="nav-li last-nav-li">
                        <a href="javascript:;" class="ue-clear"><i class="nav-ivon"></i><span
                                class="nav-text">休假管理</span></a>
                        <ul class="subnav">
                            <li class="subnav-li" data-id="14" href="restmanager/restSearch.html"><a href="javascript:;"
                                                                                                     class="ue-clear"><i
                                    class="subnav-icon"></i><span class="subnav-text">休假申请</span></a></li>
                        </ul>
                    </li>
                </c:if>
                <c:if test="${sessionScope.user.mylevel ==2}">
                    <li class="nav-li last-nav-li">
                        <a href="javascript:;" class="ue-clear"><i class="nav-ivon"></i><span
                                class="nav-text">审批管理</span></a>
                        <ul class="subnav">
                            <li class="subnav-li" data-id="15" href="worksyouninn/worksyouninnSearch.html"><a
                                    href="javascript:;" class="ue-clear"><i class="subnav-icon"></i><span
                                    class="subnav-text">加班审批</span></a></li>

                            <li class="subnav-li" data-id="16" href="restsyouninn/restsyouninnSearch.html"><a
                                    href="javascript:;" class="ue-clear"><i class="subnav-icon"></i><span
                                    class="subnav-text">休假审批</span></a></li>
                        </ul>
                    </li>
                </c:if>
                <c:if test="${sessionScope.user.mylevel ==0 || sessionScope.user.mylevel ==1 || sessionScope.user.mylevel ==2}">
                    <li class="nav-li last-nav-li">
                        <a href="javascript:;" class="ue-clear"><i class="nav-ivon"></i><span
                                class="nav-text">个人信息修改</span></a>
                        <ul class="subnav">
                            <li class="subnav-li" data-id="17" href="user/myInfoUpdate.jsp"><a
                                    href="javascript:;"
                                    class="ue-clear"><i
                                    class="subnav-icon"></i><span class="subnav-text">个人信息修改</span></a></li>
                            <li class="subnav-li" data-id="18" href="user/myPasswordUpdate.jsp"><a
                                    href="javascript:;"
                                    class="ue-clear"><i
                                    class="subnav-icon"></i><span class="subnav-text">修改密码</span></a></li>
                        </ul>
                    </li>
                    <li class="nav-li last-nav-li">
                        <a href="javascript:;" class="ue-clear"><i class="nav-ivon"></i><span
                                class="nav-text">我的桌面</span></a>
                        <ul class="subnav">
                            <li class="subnav-li" data-id="19" href="mydesktop/mydesktop.html"><a href="javascript:;"
                                                                                                  class="ue-clear"><i
                                    class="subnav-icon"></i><span class="subnav-text">我的桌面</span></a></li>
                        </ul>
                    </li>
                </c:if>

            </ul>
            <div class="tree-list outwindow">
                <div class="tree ztree"></div>
            </div>
        </div>
        <div class="main">
            <div class="title">
                <i class="sidebar-show"></i>
                <ul class="tab ue-clear">

                </ul>
                <i class="tab-more"></i>
                <i class="tab-close"></i>
            </div>
            <div class="content">
            </div>
        </div>
    </div>
</div>

<div class="more-bab-list">
    <ul></ul>
    <div class="opt-panel-ml"></div>
    <div class="opt-panel-mr"></div>
    <div class="opt-panel-bc"></div>
    <div class="opt-panel-br"></div>
    <div class="opt-panel-bl"></div>
</div>
</body>
<script type="text/javascript" src="js/nav.js"></script>
<script type="text/javascript" src="js/Menu.js"></script>
<script type="text/javascript" src="js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript">
    var menu = new Menu({
        defaultSelect: $('.nav').find('li[data-id="1"]')
    });


    $.fn.zTree.init($(".tree"), setting, zNodes);


    $('.sidebar h2').click(function (e) {
        $('.tree-list').toggleClass('outwindow');
        $('.nav').toggleClass('outwindow');
    });

    $(document).click(function (e) {
        if (!$(e.target).is('.tab-more')) {
            $('.tab-more').removeClass('active');
            $('.more-bab-list').hide();
        }
    });
</script>
</html>
