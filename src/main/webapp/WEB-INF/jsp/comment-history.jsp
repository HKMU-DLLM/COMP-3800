<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Comment History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
    <h2 class="mb-4">
        <c:choose>
            <c:when test="${isAdminView}">${user.fullName}'s Comment History</c:when>
            <c:otherwise>Your Comment History</c:otherwise>
        </c:choose>
    </h2>
    <p class="text-muted">Logged in as: <strong>${user.fullName}</strong> (${user.username})</p>

    <a href="<c:url value='/lecture/list' />" class="btn btn-secondary mb-3">← Back to Course Home</a>

    <c:choose>
        <c:when test="${empty commentHistory}">
            <div class="alert alert-info">
                You haven't posted any comments yet.
            </div>
        </c:when>
        <c:otherwise>
            <table class="table table-striped table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>Type</th>
                        <th>Target</th>
                        <th>Your Comment</th>
                        <th>Posted At</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${commentHistory}" var="c">
                        <tr>
                            <td><span class="badge ${c.targetType() == 'Lecture' ? 'bg-primary' : 'bg-success'}">${c.targetType()}</span></td>
                            <td>${c.targetTitle()}</td>
                            <td>${c.content()}</td>
                            <td>${c.createdAt().toString().replace('T', ' ').substring(0,16)}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>