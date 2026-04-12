<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>User Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .admin-sidebar-header { border-left: 4px solid #0d6efd; padding-left: 15px; }
        .table-container { background: white; border-radius: 12px; box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075); }
        .role-badge { width: 85px; text-align: center; }
        .action-group .btn { margin-bottom: 2px; }
        .stats-card { border: none; border-radius: 10px; transition: transform 0.2s; }
        .stats-card:hover { transform: translateY(-5px); }
    </style>
</head>
<body>

<div class="container-fluid px-4 py-5">

    <div class="row mb-4 align-items-end">
        <div class="col-md-6">
            <div class="admin-sidebar-header">
                <h1 class="h2 fw-bold mb-1">User Directory</h1>
                <p class="text-muted">Manage user data and view user activity logs.</p>
            </div>
        </div>
        <div class="col-md-6 text-md-end">
            <a href="<c:url value='/indexpage' />" class="btn btn-outline-secondary me-2">
                ← Dashboard
            </a>
            <a href="<c:url value='/admin/users/new' />" class="btn btn-primary fw-bold">
                + Create New Account
            </a>
        </div>
    </div>

    <div class="table-container p-0 overflow-hidden">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="bg-light text-muted small text-uppercase">
                <tr>
                    <th class="ps-4">User Details</th>
                    <th>Contact</th>
                    <th>Role</th>
                    <th>Activity Logs</th>
                    <th class="text-end pe-4">Account Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${userList}" var="u">
                    <tr>
                        <td class="ps-4">
                            <div class="d-flex align-items-center">
                                <div class="rounded-circle bg-secondary text-white d-flex align-items-center justify-content-center me-3" style="width: 40px; height: 40px; font-weight: bold;">
                                        ${u.username.substring(0,1).toUpperCase()}
                                </div>
                                <div>
                                    <div class="fw-bold text-dark">${u.fullName}</div>
                                    <div class="small text-muted">@${u.username}</div>
                                </div>
                            </div>
                        </td>

                        <td>
                            <div class="small"><span class="text-muted">Email:</span> ${u.email}</div>
                            <div class="small"><span class="text-muted">Contact Number:</span> ${u.phone}</div>
                        </td>

                        <td>
                            <span class="badge ${u.role == 'TEACHER' ? 'bg-warning' : 'bg-info'}">${u.role}</span>

                        </td>

                        <td>
                            <div class="action-group">
                                <a href="<c:url value='/admin/users/${u.id}/voting-history' />"
                                   class="btn btn-outline-info btn-sm">
                                    Votes
                                </a>
                                <a href="<c:url value='/admin/users/${u.id}/comment-history' />"
                                   class="btn btn-outline-primary btn-sm">
                                    Comments
                                </a>
                            </div>
                        </td>

                        <td class="text-end pe-4">
                            <div class="d-flex justify-content-end gap-2">
                                <a href="<c:url value='/admin/users/${u.id}/edit' />"
                                   class="btn btn-warning btn-sm fw-bold">Edit</a>

                                <form action="<c:url value='/admin/users/${u.id}/delete' />" method="post" class="m-0">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button type="submit" class="btn btn-outline-danger btn-sm"
                                            onclick="return confirm('CRITICAL: Delete user ${u.username}? This cannot be undone.')">
                                        Delete
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="mt-3 text-muted small">
        Showing <strong>${userList.size()}</strong> registered accounts.
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>