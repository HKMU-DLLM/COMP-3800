<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Poll - ${pollDatabase.question}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .poll-card { border-left: 5px solid #0d6efd; transition: 0.3s; }
        .poll-card:hover { background-color: #f8f9fa; }
    </style>
</head>
<body class="bg-light">

<div class="container py-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<html value='/lecture/list/'>">All Lectures</a></li>
            <li class="breadcrumb-item active">${pollDatabase.question}</li>
        </ol>
    </nav>

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
                </div>

                <form action="<c:url value='/poll/vote' />" method="post">
                    <input type="hidden" name="pollId" value="${pollDatabase.id}" />

                    <div class="list-group list-group-flush">
                        <c:choose>
                            <c:when test="${not empty pollDatabase.options}">
                                <c:forEach items="${optsDatabase}" var="opt">
                                    <div class="form-check mb-2 poll-card">
                                        <input class="form-check-input" type="radio"
                                               name="selectedOptionId"
                                               id="opt-${opt.id}"
                                               value="${opt.id}" required>
                                        <label class="form-check-label ms-2 h6 mb-0" for="opt-${opt.id}">
                                                ${opt.optionText}
                                        </label>
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
                        <button type="submit" class="btn btn-primary px-5">Submit Vote</button>
                    </div>
                </form>
            </div>
        </div>

        <hr class="my-5">

        <div class="container mb-5">
            <h3>Comments</h3>

            <div class="card mb-4">
                <div class="card-body">
                    <form action="<c:url value='/poll/comment/add' />" method="post">
                        <div class="mb-3">
                            <textarea name="content" class="form-control" rows="3" placeholder="Write a comment..." required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary btn-sm">Post Comment</button>
                    </form>
                </div>
            </div>

            <div class="comment-list">
                <c:forEach items="${commentDatabase}" var="comment">
                    <c:if test="${comment.targetType == 'POLL'}">
                        <div class="d-flex mb-3">
                            <div class="flex-shrink-0">
                                <img src="https://ui-avatars.com/api/?name=${comment.author.username}&background=random"
                                     class="rounded-circle" width="40">
                            </div>
                            <div class="ms-3 card w-100">
                                <div class="card-body p-2">
                                    <div class="d-flex justify-content-between">
                                        <h6 class="mb-1 fw-bold text-primary">${comment.author.username}</h6>
                                        <small class="text-muted">${comment.getPrettyTime()}</small>
                                    </div>
                                    <p class="mb-0 text-secondary">${comment.content}</p>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>

                <c:if test="${empty commentDatabase}">
                    <p class="text-muted">No comments yet. Be the first to say something!</p>
                </c:if>
            </div>
        </div>
    </div>
</div>

</body>
</html>