<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script>
    $().ready(function () {
        $('.registrationForm').validate({
            rules: {
                name: {
                    required: true,
                    minlength: 3
                }, email: {
                    required: true,
                    email: true
                }, password: {
                    required: true,
                    minlength: 5
                }, password_again: {
                    required: true,
                    minlength: 5,
                    equalTo: '#password'
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

<form:form commandName="user" cssClass="form-horizontal registrationForm">
    <c:if test="${success eq true}">
        <div class="alert alert-success">Registration successfull!</div>
    </c:if>
    <div class="form-group">
        <label for="name" class="col-sm-2 control-label">Name</label>

        <div class="col-sm-10">
            <form:input path="name" cssclass="form-control"/>
            <form:errors path="name"/>
        </div>
    </div>
    <div class="form-group">
        <label for="email" class="col-sm-2 control-label">Email</label>

        <div class="col-sm-10">
            <form:input path="email" cssclass="form-control"/>
            <form:errors path="email"/>
        </div>
    </div>
    <div class="form-group">
        <label for="password" class="col-sm-2 control-label">Password</label>

        <div class="col-sm-10">
            <form:password path="password" cssclass="form-control"/>
            <form:errors path="password"/>

        </div>
    </div>
    <div class="form-group">
        <label for="password_again" class="col-sm-2 control-label">Password again</label>

        <div class="col-sm-10">
            <input type="password" name="password_again" id="password_again">
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
            <button type="submit" class="btn btn-primary">Save</button>
        </div>
    </div>
</form:form>