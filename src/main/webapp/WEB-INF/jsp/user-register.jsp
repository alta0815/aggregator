<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<form:form commandName="user" cssClass="form-horizontal">
    <c:if test="${param.success eq true}">
        <div class="alert alert-success">Registration successfull!</div>
    </c:if>
    <div class="form-group">
        <label for="name" class="col-sm-2 control-label">Name</label>

        <div class="col-sm-10">
            <form:input path="name" cssclass="form-control"/>
        </div>
    </div>
    <div class="form-group">
        <label for="email" class="col-sm-2 control-label">Email</label>

        <div class="col-sm-10">
            <form:input path="email" cssclass="form-control"/>
        </div>
    </div>
    <div class="form-group">
        <label for="password" class="col-sm-2 control-label">Password</label>

        <div class="col-sm-10">
            <form:password path="password" cssclass="form-control"/>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
            <button type="submit" class="btn btn-default">Sign in</button>
        </div>
    </div>
</form:form>