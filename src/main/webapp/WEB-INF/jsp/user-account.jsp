<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
    New Blog
</button>

<form:form commandName="blog" cssClass="form-horizontal blogForm">
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Add blog</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">Name:</label>

                        <div class="col-sm-10">
                            <form:input path="name" cssClass="form-control"/>
                            <form:errors path="name"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">URL:</label>

                        <div class="col-sm-10">
                            <form:input path="url" cssClass="form-control"/>
                            <form:errors path="url"/>

                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <input type="submit" class="btn btn-primary" value="Save"/>
                </div>
            </div>
        </div>
    </div>
</form:form>

<script type="text/javascript">
    $(document).ready(function () {
        $('.nav-tabs a:first').tab('show');
        $('.triggerDelete').click(function (e) {
            e.preventDefault();
            $('#modalDeleteBlog .deleteBtn').attr('href', $(this).attr('href'));
            $('#modalDeleteBlog').modal();
        });
        $('.blogForm').validate({
            rules: {
                name: {
                    required: true,
                    minlength: 1
                }, url: {
                    required: true,
                    url: true
                }
            },
            highlight: function (element) {
                $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
            },
            unhighlight: function (element) {
                $(element).closest('.form-group').removeClass('has-error').addClass('has-success');
            }
        });
    });
</script>

<ul class="nav nav-tabs" role="tablist">
    <c:forEach items="${user.blogs}" var="blog">
        <li><a href="#blog_${blog.id}" data-toggle="tab"><c:out value="${blog.name}"/></a></li>
    </c:forEach>
</ul>
<div class="tab-content">
    <c:forEach items="${user.blogs}" var="blog">
        <div class="tab-pane" id="blog_${blog.id}">
            <h2><a href="${blog.url}"><c:out value="${blog.name}"/></a></h2>
            <a href="<spring:url value="/blog/delete/${blog.id}.html"/>" class="btn btn-danger triggerDelete">Delete
                blog</a>
            <c:set var="del" value="true"/>
            <c:forEach items="${blog.items}" var="item">
                <ul class="timeline">
                    <c:choose>
                        <c:when test="${del == true}">
                            <li>
                                <div class="timeline-badge info">
                                    <i class="fa fa-rss-square" style="padding-top: 14px"></i>
                                </div>
                                <div class="timeline-panel">
                                    <div class="timeline-heading">
                                        <h4 class="timeline-title"><a href="${item.link}"><c:out value="${item.title}"/></a></h4>
                                        <p><small class="text-muted"><i class="fa fa-clock-o"></i>${item.publishedDate}</small>
                                        </p>
                                    </div>
                                    <div class="timeline-body">
                                        <p>${item.description}</p>
                                    </div>
                                </div>
                            </li>
                            <c:set var="del" value="false"/>
                        </c:when>

                        <c:otherwise>
                            <li class="timeline-inverted">
                                <div class="timeline-badge danger">
                                    <i class="fa fa-rss-square" style="padding-top: 14px"></i>
                                </div>
                                <div class="timeline-panel">
                                    <div class="timeline-heading">
                                        <h4><a href="${item.link}"><c:out value="${item.title}"/></a></h4>
                                        <p><small class="text-muted"><i class="fa fa-clock-o"></i>${item.publishedDate}</small>
                                        </p>
                                    </div>
                                    <div class="timeline-body">
                                        <p>${item.description}</p>
                                    </div>
                                </div>
                            </li>
                            <c:set var="del" value="true"/>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </c:forEach>

        </div>
    </c:forEach>
</div>

<div class="modal fade" id="modalDeleteBlog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Delete blog</h4>
            </div>
            <div class="modal-body">
                Really delete blog?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <a href="" class="btn btn-danger deleteBtn">Delete</a>
            </div>
        </div>
    </div>
</div>


<style>
    .timeline {
        position: relative;
        padding: 20px 0 20px;
        list-style: none;
    }

    .timeline:before {
        content: " ";
        position: absolute;
        top: 0;
        bottom: 0;
        left: 50%;
        width: 3px;
        margin-left: -1.5px;
        background-color: #eeeeee;
    }

    .timeline > li {
        position: relative;
        margin-bottom: 20px;
    }

    .timeline > li:before,
    .timeline > li:after {
        content: " ";
        display: table;
    }

    .timeline > li:after {
        clear: both;
    }

    .timeline > li:before,
    .timeline > li:after {
        content: " ";
        display: table;
    }

    .timeline > li:after {
        clear: both;
    }

    .timeline > li > .timeline-panel {
        float: left;
        position: relative;
        width: 46%;
        padding: 20px;
        border: 1px solid #d4d4d4;
        border-radius: 2px;
        -webkit-box-shadow: 0 1px 6px rgba(0, 0, 0, 0.175);
        box-shadow: 0 1px 6px rgba(0, 0, 0, 0.175);
    }

    .timeline > li > .timeline-panel:before {
        content: " ";
        display: inline-block;
        position: absolute;
        top: 26px;
        right: -15px;
        border-top: 15px solid transparent;
        border-right: 0 solid #ccc;
        border-bottom: 15px solid transparent;
        border-left: 15px solid #ccc;
    }

    .timeline > li > .timeline-panel:after {
        content: " ";
        display: inline-block;
        position: absolute;
        top: 27px;
        right: -14px;
        border-top: 14px solid transparent;
        border-right: 0 solid #fff;
        border-bottom: 14px solid transparent;
        border-left: 14px solid #fff;
    }

    .timeline > li > .timeline-badge {
        z-index: 100;
        position: absolute;
        top: 16px;
        left: 50%;
        width: 50px;
        height: 50px;
        margin-left: -25px;
        border-radius: 50% 50% 50% 50%;
        text-align: center;
        font-size: 1.4em;
        line-height: 50px;
        color: #fff;
        background-color: #999999;
    }

    .timeline > li.timeline-inverted > .timeline-panel {
        float: right;
    }

    .timeline > li.timeline-inverted > .timeline-panel:before {
        right: auto;
        left: -15px;
        border-right-width: 15px;
        border-left-width: 0;
    }

    .timeline > li.timeline-inverted > .timeline-panel:after {
        right: auto;
        left: -14px;
        border-right-width: 14px;
        border-left-width: 0;
    }

    .timeline-badge.primary {
        background-color: #2e6da4 !important;
    }

    .timeline-badge.success {
        background-color: #3f903f !important;
    }

    .timeline-badge.warning {
        background-color: #f0ad4e !important;
    }

    .timeline-badge.danger {
        background-color: #d9534f !important;
    }

    .timeline-badge.info {
        background-color: #5bc0de !important;
    }

    .timeline-title {
        margin-top: 0;
        color: inherit;
    }

    .timeline-body > p,
    .timeline-body > ul {
        margin-bottom: 0;
    }

    .timeline-body > p + p {
        margin-top: 5px;
    }

    @media (max-width: 767px) {
        ul.timeline:before {
            left: 40px;
        }

        ul.timeline > li > .timeline-panel {
            width: calc(100% - 90px);
            width: -moz-calc(100% - 90px);
            width: -webkit-calc(100% - 90px);
        }

        ul.timeline > li > .timeline-badge {
            top: 16px;
            left: 15px;
            margin-left: 0;
        }

        ul.timeline > li > .timeline-panel {
            float: right;
        }

        ul.timeline > li > .timeline-panel:before {
            right: auto;
            left: -15px;
            border-right-width: 15px;
            border-left-width: 0;
        }

        ul.timeline > li > .timeline-panel:after {
            right: auto;
            left: -14px;
            border-right-width: 14px;
            border-left-width: 0;
        }
    }
</style>
