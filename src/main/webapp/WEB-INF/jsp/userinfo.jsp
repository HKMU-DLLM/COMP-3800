<!DOCTYPE html>
<html>
<head>
    <title>User Info</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">

    <c:if test="${param.success != null}">
        <div class="alert alert-success">Profile updated successfully.</div>
    </c:if>

    <h2 class="mb-4">Your Information</h2>

    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <table class="table table-borderless">
                <tr><th class="text-end" style="width: 140px;">ID</th><td><c:out value="${user.id}"/></td></tr>
                <tr><th class="text-end">Username</th><td><c:out value="${user.username}"/></td></tr>
                <tr><th class="text-end">Full Name</th><td><c:out value="${user.fullName}"/></td></tr>
                <tr><th class="text-end">Email</th><td><c:out value="${user.email}"/></td></tr>
                <tr><th class="text-end">Phone</th><td><c:out value="${user.phone}"/></td></tr>
                <tr><th class="text-end">Role</th><td><c:out value="${user.role}"/></td></tr>
            </table>
        </div>
    </div>

    <div class="d-flex gap-3">
        <!-- Edit Profile -->
        <a href="<c:url value='/userinfo/edituser' />" class="btn btn-warning">
            ✏️ Edit your information
        </a>

        <!-- Voting History -->
        <a href="<c:url value='/me/voting-history' />" class="btn btn-info">
            📊 My Voting History
        </a>

        <!-- Back to Home -->
        <a href="<c:url value='/indexpage' />" class="btn btn-secondary">
            ← Back to Course Home
        </a>
    </div>

</div>
</body>
</html>