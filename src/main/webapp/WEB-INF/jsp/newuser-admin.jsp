<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Create New User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .section-title {
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #6c757d;
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-9">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold text-dark">Add New User</h2>
                <a href="<c:url value='/admin/users' />" class="btn btn-outline-secondary btn-sm">
                    &larr; Back to User List
                </a>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger shadow-sm d-flex align-items-center" role="alert">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-exclamation-octagon-fill me-2" viewBox="0 0 16 16">
                        <path d="M11.46.146A.5.5 0 0 0 11.107 0H4.893a.5.5 0 0 0-.353.146L.146 4.54A.5.5 0 0 0 0 4.893v6.214a.5.5 0 0 0 .146.353l4.394 4.394a.5.5 0 0 0 .353.146h6.214a.5.5 0 0 0 .353-.146l4.394-4.394a.5.5 0 0 0 .146-.353V4.893a.5.5 0 0 0-.146-.353L11.46.146zM8 4c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                    </svg>
                    <div>${error}</div>
                </div>
            </c:if>

            <form:form method="post" modelAttribute="userForm" action="/admin/users/new" cssClass="card p-4 p-md-5 shadow-sm">

                <div class="section-title">Account Credentials</div>
                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <form:label path="username" cssClass="form-label">Username</form:label>
                        <form:input path="username" cssClass="form-control" required="true"/>
                    </div>
                    <div class="col-md-6">
                        <form:label path="password" cssClass="form-label">Initial Password</form:label>
                        <form:password path="password" cssClass="form-control" required="true"/>
                    </div>
                </div>

                <div class="section-title">Personal Information</div>
                <div class="row g-3 mb-4">
                    <div class="col-12">
                        <form:label path="fullName" cssClass="form-label">Full Name</form:label>
                        <form:input path="fullName" cssClass="form-control" required="true"/>
                    </div>
                    <div class="col-md-6">
                        <form:label path="email" cssClass="form-label">Email Address</form:label>
                        <form:input path="email" type="email" cssClass="form-control" required="true"/>
                    </div>
                    <div class="col-md-6">
                        <form:label path="phone" cssClass="form-label">Phone Number</form:label>
                        <form:input path="phone" cssClass="form-control" required="true"/>
                    </div>
                </div>

                <div class="section-title">Permissions</div>
                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <form:label path="role" cssClass="form-label">Assigned Role</form:label>
                        <form:select path="role" cssClass="form-select border-primary-subtle">
                            <form:option value="STUDENT">Student</form:option>
                            <form:option value="TEACHER">Teacher</form:option>
                        </form:select>
                    </div>
                </div>

                <hr class="my-4 text-muted">

                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                <div class="d-flex justify-content-end gap-2">
                    <a href="<c:url value='/admin/users' />" class="btn btn-light px-4">Cancel</a>
                    <button type="submit" class="btn btn-success px-5 fw-bold shadow-sm">Create User Account</button>
                </div>
            </form:form>

        </div>
    </div>
</div>

</body>
</html>