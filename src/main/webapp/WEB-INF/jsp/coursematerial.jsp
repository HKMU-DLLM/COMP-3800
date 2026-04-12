<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${lecture.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; }
        .navbar-brand { font-weight: 800; letter-spacing: -0.5px; }
        .material-card { border-left: 5px solid #0d6efd; transition: 0.2s; }
        .material-card:hover { background-color: #f8f9fa; transform: translateX(5px); }
        .comment-card { border: none; border-radius: 12px; border-left: 4px solid #198754; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .sticky-sidebar { position: sticky; top: 20px; }
        .breadcrumb-item a { text-decoration: none; color: #6c757d; font-weight: 600; }
    </style>
</head>
<body>

<nav class="navbar navbar-dark bg-dark mb-4 shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="/indexpage">Online Course</a>
        <div class="d-flex align-items-center">
            <security:authorize access="hasRole('TEACHER')">
                <a href="<c:url value='/lecture/coursematerial/${lecture.id}/delete' />"
                   class="btn btn-outline-danger btn-sm"
                   onclick="return confirm('Delete this entire lecture and all files?')">
                    Delete Lecture
                </a>
            </security:authorize>
        </div>
    </div>
</nav>

<div class="container py-2">
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/indexpage">Dashboard</a></li>
            <li class="breadcrumb-item active" aria-current="page">${lecture.title}</li>
        </ol>
    </nav>

    <div class="row g-4">
        <div class="col-lg-4">
            <div class="card border-0 shadow-sm sticky-sidebar">
                <div class="card-body p-4">
                    <span class="badge bg-primary mb-2">Lecture Details</span>
                    <h2 class="h4 fw-bold">${lecture.title}</h2>
                    <hr class="opacity-10">
                    <p class="text-secondary lh-lg">${lecture.summary}</p>
                </div>
            </div>
        </div>

        <div class="col-lg-8">
            <div class="card border-0 shadow-sm mb-5">
                <div class="card-header bg-white border-0 pt-4 px-4 d-flex justify-content-between align-items-center">
                    <h5 class="fw-bold mb-0">Study Materials</h5>
                </div>

                <div class="card-body p-4">
                    <security:authorize access="hasRole('TEACHER')">
                        <div class="bg-light p-3 rounded mb-4 border">
                            <h6 class="fw-bold small text-uppercase text-muted mb-3">Add New Material</h6>
                            <form action="${pageContext.request.contextPath}/lecture/${lecture.id}/upload"
                                  method="post" enctype="multipart/form-data" class="row g-2">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <input type="hidden" name="lectureId" value="${lecture.id}" />
                                <div class="col-sm-9">
                                    <input type="file" name="attachments" class="form-control form-control-sm" multiple required />
                                </div>
                                <div class="col-sm-3 d-grid">
                                    <button type="submit" class="btn btn-success btn-sm">Upload</button>
                                </div>
                            </form>
                        </div>
                    </security:authorize>

                    <div class="list-group list-group-flush border rounded overflow-hidden">
                        <c:choose>
                            <c:when test="${not empty lecture.materials}">
                                <c:forEach items="${lecture.materials}" var="material">
                                    <div class="list-group-item material-card d-flex justify-content-between align-items-center p-3">
                                        <div class="d-flex align-items-center">
                                            <div class="me-3 fs-3 text-primary">📄</div>
                                            <div>
                                                <div class="fw-bold text-dark">${material.originalFileName}</div>
                                                <small class="text-muted text-uppercase" style="font-size: 0.65rem;">Resource File</small>
                                            </div>
                                        </div>
                                        <div class="btn-group">
                                            <a href="<c:url value='/lecture/${lecture.id}/attachment/${material.id}' />"
                                               class="btn btn-primary btn-sm px-3">Download</a>

                                            <security:authorize access="hasRole('TEACHER')">
                                                <a href="<c:url value='/lecture/coursematerial/${lecture.id}/attachment/${material.id}/delete' />"
                                                   class="btn btn-outline-danger btn-sm"
                                                   onclick="return confirm('Remove this file?')">Delete</a>
                                            </security:authorize>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="p-5 text-center text-muted italic">
                                    No downloadable materials have been added yet.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="mb-5">
                <h3 class="h5 fw-bold mb-4">Class Discussion</h3>

                <security:authorize access="isAuthenticated()">
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <form action="<c:url value='/lecture/coursematerial/comment/add' />" method="post">
                                <input type="hidden" name="lectureId" value="${lecture.id}" />
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <div class="mb-3">
                                    <textarea name="content" class="form-control border-0 bg-light" rows="3"
                                              placeholder="Join the conversation..." required></textarea>
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
                                                <form action="<c:url value='/lecture/admin/comments/delete/${comment.id}' />"
                                                      method="post" class="d-inline">
                                                    <input type="hidden" name="lectureId" value="${lecture.id}" />
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
                            <p class="text-muted mb-0">No questions or comments yet. Start the discussion!</p>
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