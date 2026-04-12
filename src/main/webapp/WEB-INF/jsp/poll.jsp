<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Poll - ${pollDatabase.question}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; }
        .navbar-brand { font-weight: 800; letter-spacing: -0.5px; }
        .poll-card { border-left: 5px solid #0d6efd; transition: 0.2s; cursor: pointer; }
        .poll-card:hover { background-color: #f0f7ff; transform: translateX(5px); }
        .comment-card { border: none; border-radius: 12px; border-left: 4px solid #0d6efd; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .sticky-sidebar { position: sticky; top: 20px; }
        .breadcrumb-item a { text-decoration: none; color: #6c757d; font-weight: 600; }
        .vote-count-badge { min-width: 80px; text-align: center; }
    </style>
</head>
<body>

<nav class="navbar navbar-dark bg-dark mb-4 shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="/indexpage">Online Course</a>
        <div class="d-flex align-items-center">
            <security:authorize access="hasRole('TEACHER')">
                <div class="btn-group">
                    <a href="<c:url value='/poll/admin/polls/${pollDatabase.id}/edit' />" class="btn btn-outline-warning btn-sm">Edit Poll</a>
                    <form action="<c:url value='/poll/admin/polls/${pollDatabase.id}/delete' />" method="post" class="d-inline">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <button type="submit" class="btn btn-outline-danger btn-sm rounded-start-0" onclick="return confirm('Delete this poll?')">Delete</button>
                    </form>
                </div>
            </security:authorize>
        </div>
    </div>
</nav>

<div class="container py-2">
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/indexpage">Dashboard</a></li>
            <li class="breadcrumb-item active" aria-current="page text-truncate" style="max-width: 250px;">Poll Details</li>
        </ol>
    </nav>

    <div class="row g-4">
        <div class="col-lg-4">
            <div class="card border-0 shadow-sm sticky-sidebar">
                <div class="card-body p-4">
                    <span class="badge bg-secondary mb-2 text-uppercase" style="font-size: 0.7rem;">Active Poll</span>
                    <h2 class="h4 fw-bold mb-3">${pollDatabase.question}</h2>
                    <hr class="opacity-10">
                    <div class="d-flex align-items-center text-muted small mb-2">
                        <span class="me-2">📅</span> Created: ${pollDatabase.getPrettyTime()}
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-8">
            <div class="card border-0 shadow-sm mb-5">
                <div class="card-header bg-white border-0 pt-4 px-4">
                    <h5 class="fw-bold mb-0">Cast Your Vote</h5>
                    <c:if test="${not empty selectedOptionId}">
                        <div class="alert alert-success border-0 py-2 px-3 mt-3 small d-flex align-items-center">
                            <span class="me-2">✅</span> You've voted. You can change your selection below.
                        </div>
                    </c:if>
                </div>

                <div class="card-body p-4">
                    <form action="<c:url value='/poll/vote' />" method="post">
                        <input type="hidden" name="pollId" value="${pollDatabase.id}" />
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                        <div class="list-group list-group-flush border rounded overflow-hidden mb-4">
                            <c:choose>
                                <c:when test="${not empty pollDatabase.options}">
                                    <c:forEach items="${optsDatabase}" var="opt">
                                        <label class="list-group-item poll-card d-flex justify-content-between align-items-center p-3" for="opt-${opt.id}">
                                            <div class="form-check m-0">
                                                <input class="form-check-input" type="radio"
                                                       name="optionId" id="opt-${opt.id}"
                                                       value="${opt.id}"
                                                    ${selectedOptionId == opt.id.toString() ? 'checked' : ''}
                                                       required>
                                                <span class="ms-2 fw-semibold text-dark">${opt.optionText}</span>
                                            </div>
                                            <span class="badge bg-light text-primary border fw-bold vote-count-badge">
                                                ${voteCounts[opt.id] != null ? voteCounts[opt.id] : 0} votes
                                            </span>
                                        </label>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="p-5 text-center text-muted">No options defined for this poll.</div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="d-flex justify-content-between align-items-center">
                            <a href='<c:url value="/indexpage" />' class="btn btn-link text-secondary text-decoration-none small">Cancel</a>
                            <button type="submit" class="btn btn-primary btn-lg px-5 shadow-sm">
                                <c:out value="${not empty selectedOptionId ? 'Update Vote' : 'Submit Vote'}" />
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="mb-5">
                <h3 class="h5 fw-bold mb-4">Discussion</h3>

                <security:authorize access="isAuthenticated()">
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <form action="<c:url value='/poll/comment' />" method="post">
                                <input type="hidden" name="pollId" value="${pollDatabase.id}" />
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <div class="mb-3">
                                    <textarea name="content" class="form-control border-0 bg-light" rows="3"
                                              placeholder="What do you think about this poll?" required></textarea>
                                </div>
                                <div class="text-end">
                                    <button type="submit" class="btn btn-primary px-4 shadow-sm">Post Comment</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </security:authorize>

                <div class="comment-list">
                    <c:forEach items="${commentDatabase}" var="comment">
                        <div class="d-flex mb-4">
                            <img src="https://ui-avatars.com/api/?name=${comment.author.username}&background=random&color=fff"
                                 class="rounded-circle shadow-sm" width="45" height="45">
                            <div class="ms-3 flex-grow-1">
                                <div class="card comment-card">
                                    <div class="card-body p-3">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <h6 class="mb-0 fw-bold">${comment.author.fullName}</h6>
                                            <small class="text-muted" style="font-size: 0.75rem;">${comment.getPrettyTime()}</small>
                                        </div>
                                        <p class="mb-0 text-secondary">${comment.content}</p>

                                        <security:authorize access="hasRole('TEACHER')">
                                            <div class="text-end mt-2">
                                                <form action="<c:url value='/poll/admin/comments/delete/${comment.id}' />"
                                                      method="post" class="d-inline">
                                                    <input type="hidden" name="pollId" value="${pollDatabase.id}" />
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                    <button type="submit" class="btn btn-link text-danger p-0 small text-decoration-none"
                                                            onclick="return confirm('Delete this comment?')">Delete</button>
                                                </form>
                                            </div>
                                        </security:authorize>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty commentDatabase}">
                        <div class="text-center py-4 bg-white rounded shadow-sm">
                            <p class="text-muted mb-0">No comments yet.</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>