<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
${user.id}

<c:forEach items="${user.blogs}" var="blog">
    <p>${blog.name}</p>
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
</c:forEach>