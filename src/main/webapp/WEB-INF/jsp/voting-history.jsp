<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Voting History - Admin Console</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .history-card { border: none; border-radius: 12px; box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075); }
        .poll-question { font-weight: 600; color: #212529; }
        .option-text { color: #0d6efd; font-weight: 500; }
        .timestamp { font-family: 'Courier New', Courier, monospace; font-size: 0.85rem; color: #6c757d; }
        .vote-badge { background-color: #e7f1ff; color: #0056b3; border: 1px solid #cfe2ff; }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row mb-4 align-items-center">
        <div class="col-md-7">
            <h2 class="fw-bold mb-1">
                <c:choose>
                    <c:when test="${isAdminView}">
                        <span class="text-info">${user.fullName}'s Votes
                    </c:when>
                    <c:otherwise>Your Voting History</c:otherwise>
                </c:choose>
            </h2>
            <p class="text-muted mb-0">
                Displaying activity for <strong>${user.username}</strong>
            </p>
        </div>
        <div class="col-md-5 text-md-end">
            <c:choose>
                <c:when test="${isAdminView}">
                    <a href="<c:url value='/admin/users' />" class="btn btn-outline-dark">← Back to User Directory</a>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value='/userinfo' />" class="btn btn-outline-secondary">← Back to My Profile</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card p-3 border-0 shadow-sm bg-white">
                <small class="text-uppercase text-muted fw-bold" style="font-size: 0.7rem;">Votes</small>
                <div class="h4 mb-0">${votingHistory.size()}</div>
            </div>
        </div>
    </div>

    <div class="card history-card overflow-hidden">
        <c:choose>
            <c:when test="${empty votingHistory}">
                <div class="card-body text-center py-5">
                    <p class="text-muted h5">No voting records found for this account.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="bg-light border-bottom">
                        <tr>
                            <th class="ps-4">Poll Question</th>
                            <th>Selection</th>
                            <th>Voted At</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${votingHistory}" var="vote">
                            <tr>
                                <td class="ps-4">
                                    <div class="poll-question">${vote.pollQuestion()}</div>
                                </td>
                                <td>
                                        <span class="badge vote-badge px-2 py-2">
                                            Option ${vote.optionIndex()}
                                        </span>
                                    <span class="ms-2 option-text">${vote.selectedOptionText()}</span>
                                </td>
                                <td>
                                    <div class="timestamp">${vote.createdAt().toString().replace('T', ' ').substring(0,16)}</div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>