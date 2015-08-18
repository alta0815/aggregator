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
        $('.triggerDelete').click(function(e) {
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
        <li role="presentation"><a href="#blog_${blog.id}" aria-controls="profile" role="tab"
                                   data-toggle="tab">${blog.name}</a></li>
    </c:forEach>
</ul>
<div class="tab-content">
    <c:forEach items="${user.blogs}" var="blog">
        <div role="tabpane" class="tab-pane" id="blog_${blog.id}">
            <h1>${blog.name}</h1>
            <a href="<spring:url value="/blog/delete/${blog.id}.html"/>" class="btn btn-danger triggerDelete">Delete blog</a>
            <p>${blog.url}</p>
            <table class="table table-bordered table-hover table-striped">
                <thead>
                <tr>
                    <th>date</th>
                    <th>item</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <c:forEach items="${blog.items}" var="item">
                <tr>
                    <td><c:out value="${item.publishedDate}"/></td>
                    <td><a href="${item.link}">${item.title}</a> <br> ${item.description}</td>
                </tr>
                </c:forEach>
                </tr>
                </tbody>
            </table>
        </div>
    </c:forEach>
</div>

<div class="modal fade" id="modalDeleteBlog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
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