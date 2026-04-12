<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Comment History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .history-card { border: none; border-radius: 12px; box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075); }
        .comment-text {
            max-width: 400px;
            white-space: pre-wrap;
            font-size: 0.95rem;
            color: #333;
            background: #fff;
            padding: 8px;
            border-radius: 6px;
            border: 1px solid #eee;
        }
        .target-link { font-weight: 600; text-decoration: none; color: #0d6efd; }
        .target-link:hover { text-decoration: underline; }
        .timestamp { font-family: monospace; font-size: 0.85rem; color: #6c757d; }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="d-flex justify-content-between align-items-end mb-4">
        <div>
            <h2 class="fw-bold mb-1">
                <c:choose>
                    <c:when test="${isAdminView}">
                        <span class="text-primary">${user.fullName}'s Comments
                    </c:when>
                    <c:otherwise>Your Comment History</c:otherwise>
                </c:choose>
            </h2>
            <p class="text-muted mb-0">
                User: <strong>${user.username}</strong> | Total Comments: <strong>${commentHistory.size()}</strong>
            </p>
        </div>

        <c:choose>
            <c:when test="${isAdminView}">
                <a href="<c:url value='/admin/users' />" class="btn btn-outline-dark">← Back to User List</a>
            </c:when>
            <c:otherwise>
                <a href="<c:url value='/userinfo' />" class="btn btn-outline-secondary">← Back to Profile</a>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="card history-card overflow-hidden">
        <c:choose>
            <c:when test="${empty commentHistory}">
                <div class="card-body text-center py-5">
                    <div class="mb-3">
                        <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="#dee2e6" class="bi bi-chat-left-dots" viewBox="0 0 16 16">
                            <path d="M14 1a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H4.414A2 2 0 0 0 3 11.586l-2 2V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
                        </svg>
                    </div>
                    <h5 class="text-muted">No activity found.</h5>
                    <p class="text-muted small">This user hasn't posted any comments yet.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="bg-light border-bottom">
                        <tr>
                            <th class="ps-4">Resource Type</th>
                            <th>Target Title</th>
                            <th>Comment Content</th>
                            <th class="pe-4">Date Posted</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${commentHistory}" var="c">
                            <tr>
                                <td class="ps-4">
                                        <span class="badge ${c.targetType() == 'Lecture' ? 'bg-primary' : 'bg-success'} rounded-pill px-3">
                                                ${c.targetType()}
                                        </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty c.targetTitle()}">
                                                <span class="text-danger small fw-bold">
                                                    <i class="bi bi-exclamation-triangle"></i> Deleted ${c.targetType()}
                                                </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="target-link">${c.targetTitle()}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="comment-text">${c.content()}</div>
                                </td>
                                <td class="pe-4">
                                        <span class="timestamp">
                                                ${c.createdAt().toString().replace('T', ' ').substring(0,16)}
                                        </span>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="mt-4 text-center">
        <small class="text-muted italic">All timestamps are shown in system local time.</small>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>