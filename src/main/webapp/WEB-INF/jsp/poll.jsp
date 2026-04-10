<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Poll - ${pollDatabase.question}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .poll-card { border-left: 5px solid #0d6efd; transition: 0.3s; }
        .poll-card:hover { background-color: #f8f9fa; }
        .comment-card { border-left: 4px solid #28a745; }
    </style>
</head>
<body class="bg-light">

<div class="container py-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/lecture/list">All Lectures</a></li>
            <li class="breadcrumb-item active">${pollDatabase.question}</li>
        </ol>
    </nav>
<security:authorize access="hasRole('TEACHER')">
    <div class="mb-4">
        <a href="<c:url value='/poll/admin/polls/${pollDatabase.id}/edit' />"
           class="btn btn-warning btn-sm me-2">
            ✏️ Edit Poll
        </a>

        <form action="<c:url value='/poll/admin/polls/${pollDatabase.id}/delete' />" 
              method="post" style="display:inline;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <button type="submit" class="btn btn-danger btn-sm"
                    onclick="return confirm('Delete this poll and all its votes/comments/options?')">
                🗑️ Delete Poll
            </button>
        </form>
    </div>
</security:authorize>

    <div class="row">
        <div class="col-md-4">
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <h5 class="text-muted text-uppercase small fw-bold">Poll #${pollDatabase.id}</h5>
                    <h2 class="card-title h4">${pollDatabase.question}</h2>
                    <hr>
                    <p class="card-text text-secondary">Posted: ${pollDatabase.createdAt}</p>
                </div>
            </div>
        </div>

        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Select an Option</h5>
                    <c:if test="${not empty selectedOptionId}">
                        <small class="text-success fw-bold">You have already voted. You can change your vote below.</small>
                    </c:if>
                </div>

                <form action="<c:url value='/poll/vote' />" method="post">
                    <input type="hidden" name="pollId" value="${pollDatabase.id}" />
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                    <div class="list-group list-group-flush">
                        <c:choose>
                            <c:when test="${not empty pollDatabase.options}">
                                <c:forEach items="${optsDatabase}" var="opt">
                                    <div class="list-group-item d-flex justify-content-between align-items-center poll-card">
                                        <div class="form-check flex-grow-1">
                                            <input class="form-check-input" type="radio"
                                                   name="optionId"
                                                   id="opt-${opt.id}"
                                                   value="${opt.id}"
                                                   ${selectedOptionId == opt.id.toString() ? 'checked' : ''}
                                                   required>
                                            <label class="form-check-label ms-2 h6 mb-0" for="opt-${opt.id}">
                                                ${opt.optionText}
                                            </label>
                                        </div>
                                        <span class="badge bg-primary fs-6">
                                            ${voteCounts[opt.id] != null ? voteCounts[opt.id] : 0} votes
                                        </span>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="p-4 text-center text-muted">
                                    No options for this poll yet.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="card-footer bg-white py-3 text-end">
                        <a href='<c:url value="/lecture/list" />' class="btn btn-link text-secondary">Cancel</a>
                        <button type="submit" class="btn btn-primary px-5">
                            <c:choose>
                                <c:when test="${not empty selectedOptionId}">Update My Vote</c:when>
                                <c:otherwise>Submit Vote</c:otherwise>
                            </c:choose>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <hr class="my-5">

    <div class="container mb-5">
        <h3>Comments</h3>

        <security:authorize access="isAuthenticated()">
            <div class="card mb-4">
                <div class="card-body">
                    <form action="<c:url value='/poll/comment' />" method="post">
                        <input type="hidden" name="pollId" value="${pollDatabase.id}" />
                        <div class="mb-3">
                            <textarea name="content" class="form-control" rows="3" 
                                      placeholder="Write a comment..." required></textarea>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <button type="submit" class="btn btn-primary">Post Comment</button>
                    </form>
                </div>
            </div>
        </security:authorize>

        <div class="comment-list">
            <c:forEach items="${commentDatabase}" var="comment">
                <div class="d-flex mb-3">
                    <div class="flex-shrink-0">
                        <img src="https://ui-avatars.com/api/?name=${comment.author.username}&background=random"
                             class="rounded-circle" width="40">
                    </div>
                    <div class="ms-3 card w-100 comment-card">
                        <div class="card-body p-3">
                            <div class="d-flex justify-content-between">
                                <h6 class="mb-1 fw-bold text-primary">${comment.author.fullName}</h6>
                                <small class="text-muted">${comment.getPrettyTime()}</small>
                            </div>
                            <p class="mb-0 text-secondary">${comment.content}</p>

                            <security:authorize access="hasRole('TEACHER')">
                                <form action="<c:url value='/lecture/admin/comments/delete/${comment.id}' />" 
                                      method="post" style="display:inline;" class="mt-2">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button type="submit" class="btn btn-danger btn-sm"
                                            onclick="return confirm('Are you sure you want to delete this comment?')">Delete</button>
                                </form>
                            </security:authorize>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty commentDatabase}">
                <p class="text-muted">No comments yet. Be the first to say something!</p>
            </c:if>
        </div>
    </div>
</div>

</body>
</html>