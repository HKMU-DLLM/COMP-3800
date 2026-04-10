<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Course Materials - ${lecture.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .material-card { border-left: 5px solid #0d6efd; transition: 0.3s; }
        .material-card:hover { background-color: #f8f9fa; }
        .file-icon { font-size: 1.5rem; margin-right: 10px; }
        .comment-card { border-left: 4px solid #28a745; }
    </style>
</head>
<body class="bg-light">

<div class="container py-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/lecture/list">All Lectures</a></li>
            <li class="breadcrumb-item active">${lecture.title}</li>
        </ol>
    </nav>

    <div class="row">
        <div class="col-md-4">
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <h5 class="text-muted text-uppercase small fw-bold">Lecture</h5>
                    <h2 class="card-title h4">${lecture.title}</h2>
                    <hr>
                    <p class="card-text text-secondary">${lecture.summary}</p>
                </div>
            </div>
        </div>

        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Downloadable Materials</h5>
                </div>
                <div class="card-body p-0">
                    <div class="list-group list-group-flush">
                        <c:choose>
                            <c:when test="${not empty lecture.materials}">
                                <c:forEach items="${lecture.materials}" var="material">
                                    <div class="list-group-item material-card d-flex justify-content-between align-items-center py-3">
                                        <div class="d-flex align-items-center">
                                            <span class="file-icon">📄</span>
                                            <div>
                                                <h6 class="mb-0">${material.originalFileName}</h6>
                                                <small class="text-muted">Available for download</small>
                                            </div>
                                        </div>
                                        <a href="<c:url value='/lecture/${lecture.id}/attachment/${material.id}' />"
                                           class="btn btn-outline-primary btn-sm px-4">
                                            Download
                                        </a>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="p-4 text-center text-muted">
                                    No materials uploaded for this lecture yet.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <hr class="my-5">

    <div class="container mb-5">
        <h3>Comments</h3>

        <security:authorize access="isAuthenticated()">
            <div class="card mb-4">
                <div class="card-body">
                    <form action="<c:url value='/lecture/coursematerial/comment' />" method="post">
                        <input type="hidden" name="lectureId" value="${lecture.id}" />
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