<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>用户列表</title>
    <meta name="description" content="用户列表"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <!-- basic styles -->
    <link rel="stylesheet" href="${request.contextPath}/static/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/bootstrap-responsive.min.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/font-awesome.min.css"/>
    <!--[if IE 7]>
    <link rel="stylesheet" href="${request.contextPath}/static/css/font-awesome-ie7.min.css"/>
    <![endif]-->
    <!-- page specific plugin styles -->

    <!-- ace styles -->
    <link rel="stylesheet" href="${request.contextPath}/static/css/ace.min.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/ace-responsive.min.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/ace-skins.min.css"/>
    <!--[if lt IE 9]>
    <link rel="stylesheet" href="${request.contextPath}/static/css/ace-ie.min.css"/>
    <![endif]-->
    <style type="text/css">
        .search-table tr td{position:relative;line-height:5;padding:10px 0.4cm 0px 0px;}
        .error-msg{color:red;}
    </style>
</head>
<body>
<div class="navbar navbar-inverse">
    <c:catch var="exception">
        <c:import url="${request.contextPath}/top_nav.action"/>
    </c:catch>
    <c:if test="${not empty exception}">
        Sorry, the remote content is not currently available.
    </c:if>
</div>
<div class="container-fluid" id="main-container">
    <a href="#" id="menu-toggler"><span></span></a><!-- menu toggler -->
    <div id="sidebar">
        <c:catch var="exception">
            <c:import url="${request.contextPath}/left_menu.action"/>
        </c:catch>
        <c:if test="${not empty exception}">
            Sorry, the remote content is not currently available.
        </c:if>
    </div>

    <!--/#sidebar-->

    <div id="main-content" class="clearfix">

        <div id="breadcrumbs">
            <ul class="breadcrumb">
                <li><i class="icon-home"></i> <a href="${request.contextPath}/index.action">首页</a><span class="divider"><i
                        class="icon-angle-right"></i></span></li>
                <li class="active">用户管理</li>
            </ul>
            <div id="nav-search">
                <%@include file="../search_bar.jsp" %>
            </div>
        </div>

        <div id="page-content" class="clearfix">
            <div class="page-header position-relative">
                <h1>用户管理 <small><i class="icon-double-angle-right"></i> 用户列表</small></h1>
            </div>

            <div class="row-fluid">
                <div class="row-fluid">
                    <form id="search-form" class="form-search" action="${request.contextPath}/user/list.action" method="post">
                        <input id="pageno" type="hidden" name="pageno" value="${page.number}"/>
                        <input id="size" type="hidden" name="size" value="${page.size}"/>
                        <input type="hidden" name="direction" value="${page.sortOrder == null ? "":page.sortOrder.direction}"/>
                        <input type="hidden" name="sortProperty" value="${page.sortOrder == null ? "":page.sortOrder.property}"/>
                        <div>
                            <table class="search-table">
                                <tr>
                                    <td>
                                        <label for="user_id">用户编号</label>
                                    </td>
                                    <td>
                                        <input type="text" id="user_id" name="id" class="input-medium search-query" value="${user.id == 0 ? null:user.id}"/>
                                    </td>
                                    <td>
                                        <label for="login_name">登录名</label>
                                    </td>
                                    <td>
                                        <input type="text" id="login_name" name="loginName" class="input-medium search-query" value="${user.loginName}"/>
                                    </td>
                                    <td>
                                        <label for="begin_time">创建开始时间</label>
                                    </td>
                                    <td>
                                        <input type="text" id="begin_time" name="beginTime" class="input-medium search-query" value="<fmt:formatDate value="${beginTime}" pattern="yyyy-MM-dd"/>"/>
                                    </td>
                                    <td><label for="end_time">创建结束时间</label></td>
                                    <td>
                                        <input type="text" id="end_time" name="endTime" class="input-medium search-query" value="<fmt:formatDate value="${endTime}" pattern="yyyy-MM-dd"/>"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label for="email">Email</label>
                                    </td>
                                    <td>
                                        <input type="text" id="email" name="email" class="input-medium search-query" value="${user.email}"/>
                                    </td>
                                    <td>
                                        <label for="mobile">手机号</label>
                                    </td>
                                    <td>
                                        <input type="text" id="mobile" name="mobile" class="input-medium search-query" value="${user.mobile}"/>
                                    </td>
                                    <td>
                                        <label for="status">状态</label>
                                    </td>
                                    <td>
                                        <input type="text" id="status" name="status" class="input-medium search-query" value="${user.status == 0 ? null:user.status}"/>
                                    </td>
                                    <td colspan="2">
                                        <button id="search-form-submit" type="submit" class="btn btn-purple btn-small"><i class="icon-search icon-on-right"></i>查询</button>
                                        &nbsp; &nbsp; &nbsp;
                                        <button type="reset" class="btn btn-info btn-small"><i class="icon-undo"></i>重置</button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </form>
                    <hr/>
                </div>
                <div class="row-fluid">
                    <div id="table_report_wrapper" class="dataTables_wrapper" role="grid">
                        <table class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th class="center">
                                    <label><input type="checkbox"/><span class="lbl"></span></label>
                                </th>
                                <th>登录名</th>
                                <th>Email</th>
                                <th class="hidden-480">手机号</th>
                                <th class="hidden-phone"><i class="icon-time hidden-phone"></i> 创建时间</th>
                                <th class="hidden-480">状态</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${page != null && page.content != null}">
                                <c:forEach var="user" items="${page.content}">
                             <tr>
                                <td class='center'>
                                    <label><input type='checkbox'/><span class="lbl"></span></label>
                                </td>
                                <td><a href='#'>${user.loginName}</a></td>
                                <td>${user.email}</td>
                                <td class='hidden-480'>${user.mobile}</td>
                                <td class='hidden-phone'><fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd"/></td>
                                <td class='hidden-480'>
                                    <c:choose>
                                        <c:when test="${user.status==1}">
                                            <span class='label label-warning'>未初始化</span>
                                        </c:when>
                                        <c:when test="${user.status==2}">
                                            <span class='label label-success'>正常</span>
                                        </c:when>
                                        <c:when test="${user.status==20}">
                                            <span class='label label-inverse arrowed-in'>已锁定</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class='label label-info arrowed arrowed-right'>其他</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class='hidden-phone visible-desktop btn-group'>
                                        <button class='btn btn-mini btn-success'><i class='icon-ok'></i></button>
                                        <button class='btn btn-mini btn-info' data-toggle="modal" data-target="#update-user-modal-box" href="${request.contextPath}/user/update.action?id=${user.id}"><i class='icon-edit'></i></button>
                                        <button class='btn btn-mini btn-danger' id="bootbox-confirm" onclick="doDelete(this,${user.id})"><i class='icon-trash'></i></button>
                                        <button class='btn btn-mini btn-warning'><i class='icon-flag'></i></button>
                                    </div>
                                </td>
                             </tr>
                                </c:forEach>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row-fluid">
                    <%@include file="../pager.jsp"%>
                </div>
                <div class="row-fluid">
                    <div class="login-container">
                        <div class="position-relative">
                            <div id="update-user-box" class="invisible widget-box no-border">

                            </div>

                            <div id="update-user-modal-box" class="modal fade"  tabindex="-1" role="dialog"
                                 aria-labelledby="modal_title_text" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close"
                                                    data-dismiss="modal" aria-hidden="true">
                                                &times;
                                            </button>
                                            <h4 class="modal-title" id="modal_title_text">
                                                更新用户
                                            </h4>
                                        </div>
                                        <div class="modal-body">

                                        </div>
                                        <div class="modal-footer"></div>
                                    </div>
                                </div>
                            </div>

                        </div>
                     </div>
                </div>
            </div>
        </div>

        <div id="ace-settings-container">
            <%@include file="../page_setting_box.jsp" %>
        </div>
    </div>
</div>

<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
    <i class="icon-double-angle-up icon-only"></i>
</a>
<!-- basic scripts -->
<script src="${request.contextPath}/static/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
    window.jQuery || document.write("<script src='${request.contextPath}/static/js/jquery-1.9.1.min.js'>\x3C/script>");
</script>
<script src="${request.contextPath}/static/js/bootstrap.min.js"></script>
<!-- page specific plugin scripts -->
<script type="text/javascript" src="${request.contextPath}/static/js/jquery.validate.min.js"></script>

<script type="text/javascript" src="${request.contextPath}/static/js/bootbox.min.js"></script>

<script type="text/javascript" src="${request.contextPath}/static/js/layer/layer.js"></script>

<!-- ace scripts -->
<script src="${request.contextPath}/static/js/ace-elements.min.js"></script>
<script src="${request.contextPath}/static/js/ace.min.js"></script>
<!-- inline scripts related to this page -->

<script type="text/javascript">
    $(function(){
        var validator = $('#search-form').validate({
            rules: {
                id: {
                    digits:true,
                    min: 1
                }
            },
            messages: {
                id: {
                    digits: "(必须是正整数)",
                    min: "(必须大于1)"
                }
            },
            invalidHandler: function (event, validator) { //display error alert on form submit
                $('.alert-error', $('.search-form')).show();
            },
            highlight: function (e) {
                $(e).closest('.control-group').removeClass('info').addClass('error');
            },
            success: function (e) {
                $(e).closest('.control-group').removeClass('error').addClass('info');
                $(e).remove();
            },
            errorPlacement: function (error, element) {
                // Append error within linked label
                $( element )
                        .closest( "form" )
                        .find( "label[for='" + element.attr( "id" ) + "']" )
                        .append( error );
                //以下是将错误信息插入验证元素后面
               // error.insertAfter(element);
            },
            errorElement: "span",
            errorClass:"error-msg",
            submitHandler: function (form) {
                form.submit();
            },
            invalidHandler: function (form) {
            }
        });

        //reset
        $('#reset').click(function (){
            validator.resetForm();
        });

        $("#page_size").val($("#size").val());
    });

    function goto(pageno){
        $("#pageno").val(pageno);
        $("#search-form-submit").trigger("click");
    }

    function changePagesize(pageSize){
        $("#pageno").val(0);
        $("#size").val(pageSize);
        $("#search-form-submit").trigger("click");
    }

    function doDelete(button,userId){
        bootbox.confirm("确定删除?", function(result) {
            if(result) {
                $.ajax({
                    url: "${request.contextPath}/user/delete.action",
                    timeout:10000,
                    type: "GET",
                    async: true,
                    data: {userId: userId},
                    success: function(data){
                        if (data.status != 200) {
                            bootbox.dialog("删除用户失败!" + data.errors[0].message,
                                    [
                                        {
                                            "label" : "确定!",
                                            "class" : "btn-small btn-success",
                                            "callback": function() {}
                                        }]
                            );
                        } else {
                            layer.msg('删除成功',{time: 1000});
                            $(button).parent().parent().parent().remove();
                        }
                    },
                    error: function (data) {
                        alert('系统内部错误，请稍后再试！');
                        if(typeof(console)!='undefined'){
                            console.log(data);
                            console.log(data.responseText);
                        }
                    }
                });
            }
        });
    }

</script>
</body>
</html>
