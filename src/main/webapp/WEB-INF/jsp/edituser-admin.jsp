<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
    <h2 class="mb-4">Edit User #${user.id}</h2>

    <form:form method="post" modelAttribute="userForm" action="/admin/users/${user.id}/edit" cssClass="card p-4 shadow">
        <div class="mb-3">
            <label class="form-label">Username (cannot be changed)</label>
            <input type="text" class="form-control" value="${user.username}" readonly>
        </div>
        <div class="mb-3">
            <form:label path="password" cssClass="form-label">New Password (leave blank to keep current)</form:label>
            <form:password path="password" cssClass="form-control"/>
        </div>
        <div class="mb-3">
            <form:label path="fullName" cssClass="form-label">Full Name</form:label>
            <form:input path="fullName" cssClass="form-control" required="true"/>
        </div>
        <div class="mb-3">
            <form:label path="email" cssClass="form-label">Email</form:label>
            <form:input path="email" type="email" cssClass="form-control" required="true"/>
        </div>
        <div class="mb-3">
            <form:label path="phone" cssClass="form-label">Phone</form:label>
            <form:input path="phone" cssClass="form-control" required="true"/>
        </div>
        <div class="mb-3">
            <form:label path="role" cssClass="form-label">Role</form:label>
            <form:select path="role" cssClass="form-select">
                <form:option value="STUDENT">Student</form:option>
                <form:option value="TEACHER">Teacher</form:option>
            </form:select>
        </div>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <button type="submit" class="btn btn-primary">Save Changes</button>
        <a href="<c:url value='/admin/users' />" class="btn btn-secondary">Cancel</a>
    </form:form>
</div>
</body>
</html>