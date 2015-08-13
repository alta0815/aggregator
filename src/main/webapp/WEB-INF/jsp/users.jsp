<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript">
    $(document).ready(function () {
        $('.triggerDelete').click(function(e) {
            e.preventDefault();
            $('#modalDeleteUser .deleteBtn').attr('href', $(this).attr('href'));
            $('#modalDeleteUser').modal();
        });
    });
</script>

<table class="table table-bordered table-hover table-striped">
    <thead>
        <tr>
            <th>User name</th>
            <th>Operations</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${users}" var="user">
            <tr>
                <td><a href="<spring:url value="/users/${user.id}.html"/>">${user.name}</a></td>
                <td><a href="<spring:url value="/users/delete/${user.id}.html"/>" class="btn btn-danger triggerDelete">Delete </a></td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<div class="modal fade" id="modalDeleteUser" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Delete user</h4>
            </div>
            <div class="modal-body">
                Really delete user?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <a href="" class="btn btn-danger deleteBtn">Delete</a>
            </div>
        </div>
    </div>
</div>