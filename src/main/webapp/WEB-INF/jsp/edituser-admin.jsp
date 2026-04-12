<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .admin-header { background-color: #212529; color: white; padding: 2rem 0; margin-bottom: 2rem; border-bottom: 4px solid #0d6efd; }
        .form-label { font-weight: 600; color: #495057; font-size: 0.9rem; }
        .readonly-field { background-color: #f8f9fa; border-style: dashed; }
        .role-badge-selector { background-color: #fff3cd; border: 1px solid #ffe69c; border-radius: 8px; padding: 15px; }
    </style>
</head>
<body>

<div class="admin-header">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h1 class="h3 mb-0">User Management</h1>
                <p class="mb-0 opacity-75">Modifying User Account: <strong>${user.username}</strong></p>
            </div>
        </div>
    </div>
</div>

<div class="container pb-5">
    <div class="row justify-content-center">
        <div class="col-lg-7">

            <form:form method="post" modelAttribute="userForm" action="/admin/users/${user.id}/edit" cssClass="card shadow-sm overflow-hidden">
                <div class="card-body p-4 p-md-5">

                    <div class="row g-3">
                        <div class="col-md-8">
                            <label class="form-label text-uppercase">Username  (Permanent)</label>
                            <input type="text" class="form-control readonly-field" value="${user.username}" readonly>
                        </div>

                        <hr class="my-4 opacity-10">

                        <div class="col-12">
                            <form:label path="fullName" cssClass="form-label">Full Name</form:label>
                            <form:input path="fullName" cssClass="form-control form-control-lg" required="true"/>
                        </div>

                        <div class="col-md-6">
                            <form:label path="email" cssClass="form-label">Email Address</form:label>
                            <form:input path="email" type="email" cssClass="form-control" required="true"/>
                        </div>
                        <div class="col-md-6">
                            <form:label path="phone" cssClass="form-label">Phone Number</form:label>
                            <form:input path="phone" cssClass="form-control" required="true"/>
                        </div>

                        <div class="col-12 mt-4">
                            <div class="role-badge-selector">
                                <form:label path="role" cssClass="form-label text-warning-emphasis">Assign System Role</form:label>
                                <form:select path="role" cssClass="form-select border-warning">
                                    <form:option value="STUDENT">Student (Standard Access)</form:option>
                                    <form:option value="TEACHER">Teacher (Course Management)</form:option>
                                </form:select>
                            </div>
                        </div>

                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                    <div class="d-flex gap-3 mt-5">
                        <button type="submit" class="btn btn-primary btn-lg px-5 shadow-sm fw-bold">Update Account</button>
                        <a href="<c:url value='/admin/users' />" class="btn btn-outline-secondary btn-lg">Discard Changes</a>
                    </div>
                </div>
            </form:form>

            <div class="mt-4 text-center">
                <small class="text-muted">Last modified records will be logged for security audits.</small>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>