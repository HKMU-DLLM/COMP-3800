<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Voting History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
    <h2 class="mb-4">
        <c:choose>
            <c:when test="${isAdminView}"> ${user.fullName}'s Voting History</c:when>
            <c:otherwise>Your Voting History</c:otherwise>
        </c:choose>
    </h2>
    <p class="text-muted">Logged in as: <strong>${user.fullName}</strong> (${user.username})</p>

    <a href="<c:url value='/lecture/list' />" class="btn btn-secondary mb-3">← Back to Course Home</a>

    <c:choose>
        <c:when test="${empty votingHistory}">
            <div class="alert alert-info">
                You haven't voted in any polls yet.
            </div>
        </c:when>
        <c:otherwise>
            <table class="table table-striped table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>Poll Question</th>
                        <th>Your Selected Option</th>
                        <th>Voted At</th>
                        <th>Last Updated</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${votingHistory}" var="vote">
                        <tr>
                            <td>${vote.pollQuestion()}</td>
                            <td>
                                <strong>Option ${vote.optionIndex()}:</strong> 
                                ${vote.selectedOptionText()}
                            </td>
                            <td>${vote.createdAt().toString().replace('T', ' ').substring(0,16)}</td>
                            <td>${vote.updatedAt().toString().replace('T', ' ').substring(0,16)}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>