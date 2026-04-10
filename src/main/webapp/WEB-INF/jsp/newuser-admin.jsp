<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add New User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
    <h2 class="mb-4">Add New User</h2>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form:form method="post" modelAttribute="userForm" action="/admin/users/new" cssClass="card p-4 shadow">
        <div class="row g-3">
            <div class="col-md-6"><form:label path="username" cssClass="form-label">Username</form:label>
                <form:input path="username" cssClass="form-control" required="true"/></div>
            <div class="col-md-6"><form:label path="password" cssClass="form-label">Password</form:label>
                <form:password path="password" cssClass="form-control" required="true"/></div>
            <div class="col-12"><form:label path="fullName" cssClass="form-label">Full Name</form:label>
                <form:input path="fullName" cssClass="form-control" required="true"/></div>
            <div class="col-md-6"><form:label path="email" cssClass="form-label">Email</form:label>
                <form:input path="email" type="email" cssClass="form-control" required="true"/></div>
            <div class="col-md-6"><form:label path="phone" cssClass="form-label">Phone</form:label>
                <form:input path="phone" cssClass="form-control" required="true"/></div>
            <div class="col-md-6"><form:label path="role" cssClass="form-label">Role</form:label>
                <form:select path="role" cssClass="form-select">
                    <form:option value="STUDENT">Student</form:option>
                    <form:option value="TEACHER">Teacher</form:option>
                </form:select></div>
        </div>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <div class="mt-4">
            <button type="submit" class="btn btn-success">Create User</button>
            <a href="<c:url value='/admin/users' />" class="btn btn-secondary">Cancel</a>
        </div>
    </form:form>
</div>
</body>
</html>