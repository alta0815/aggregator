<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript">
    $(document).ready(function () {
        $('.nav-tabs a:first').tab('show');
        $('.triggerDelete').click(function(e) {
            e.preventDefault();
            $('#modalDeleteBlog .deleteBtn').attr('href', $(this).attr('href'));
            $('#modalDeleteBlog').modal();
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
                    <th>Title</th>
                    <th>Link</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <c:forEach items="${blog.items}" var="item">
                <tr>
                    <td>${item.title}</td>
                    <td>${item.link}</td>
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