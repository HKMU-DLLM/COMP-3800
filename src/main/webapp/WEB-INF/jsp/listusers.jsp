<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
    <h2 class="mb-4">User Management</h2>
    
    <a href="<c:url value='/admin/users/new' />" class="btn btn-success mb-3">+ Add New User</a>
    <a href="<c:url value='/indexpage' />" class="btn btn-secondary mb-3">← Back to Course Home</a>

    <table class="table table-striped table-hover align-middle">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Role</th>
                <th>Enabled</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${userList}" var="u">
                <tr>
                    <td>${u.id}</td>
                    <td>${u.username}</td>
                    <td>${u.fullName}</td>
                    <td>${u.email}</td>
                    <td>${u.phone}</td>
                    <td><span class="badge ${u.role == 'TEACHER' ? 'bg-warning' : 'bg-info'}">${u.role}</span></td>
                    <td>${u.enabled ? 'Yes' : 'No'}</td>
                    <td>
                        <a href="<c:url value='/admin/users/${u.id}/edit' />" 
                           class="btn btn-warning btn-sm">Edit</a>
                        
                        <a href="<c:url value='/admin/users/${u.id}/voting-history' />" 
                           class="btn btn-info btn-sm">📊 Vote History</a>

                        <a href="<c:url value='/admin/users/${u.id}/comment-history' />" 
                           class="btn btn-primary btn-sm">💬 Comment History</a>
                        
                        <form action="<c:url value='/admin/users/${u.id}/delete' />" method="post" style="display:inline;">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <button type="submit" class="btn btn-danger btn-sm"
                                    onclick="return confirm('Delete user ${u.username}? This action cannot be undone.')">
                                Delete
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>