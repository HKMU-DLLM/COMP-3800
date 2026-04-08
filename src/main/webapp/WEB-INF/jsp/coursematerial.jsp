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
                    <h5 class="text-muted text-uppercase small fw-bold">Lecture ${lecture.courseOrder}</h5>
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
                                        <a href="/download/${file.id}" class="btn btn-outline-primary btn-sm px-4">
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
</div>

</body>
</html>