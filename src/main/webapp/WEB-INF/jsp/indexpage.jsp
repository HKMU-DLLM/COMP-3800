<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Online Course</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; }
        .navbar { min-height: 70px; }
        .navbar-brand { font-weight: 800; letter-spacing: -0.5px; }

        @media (min-width: 992px) {
            .dropdown:hover .dropdown-menu {
                display: block;
                margin-top: 0;
            }
        }

        .card { border: none; border-radius: 10px; transition: transform 0.2s; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .card:hover { transform: translateY(-2px); box-shadow: 0 6px 12px rgba(0,0,0,0.08); }
        .btn-large-action { padding: 0.75rem 1.5rem; font-weight: 600; text-transform: uppercase; font-size: 0.9rem; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-5 shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="/indexpage">Online Course</a>

        <div class="me-auto border-start ps-3 ms-2 border-secondary" style="min-width: 150px;">
            <security:authorize access="isAuthenticated()">
                <small class="text-uppercase text-white opacity-50 d-block" style="font-size: 0.65rem;">Logged in as</small>
                <span class="text-white fw-bold"><security:authentication property="name" /></span>
            </security:authorize>
            <security:authorize access="isAnonymous()">
                <span class="text-secondary small italic">Guest Access</span>
            </security:authorize>
        </div>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav align-items-center">

                <security:authorize access="isAuthenticated()">
                    <security:authorize access="hasRole('TEACHER')">
                        <li class="nav-item">
                            <a class="nav-link me-3 text-light" href="<c:url value='/admin/users' />">Manage Users</a>
                        </li>
                    </security:authorize>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle btn btn-outline-info text-info px-4" href="#" id="userDropdown" role="button">
                            Account
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                            <li><a class="dropdown-item py-2" href="<c:url value='/userinfo' />">My Profile</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <c:url var="logoutUrl" value="/logout"/>
                                <form action="${logoutUrl}" method="post" class="m-0 px-3 py-1">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button type="submit" class="btn btn-danger btn-sm w-100">Logout</button>
                                </form>
                            </li>
                        </ul>
                    </li>
                </security:authorize>

                <security:authorize access="isAnonymous()">
                    <li class="nav-item">
                        <a href="<c:url value='/login' />" class="btn btn-primary px-4">Login to System</a>
                    </li>
                </security:authorize>

            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row g-4">
        <div class="col-lg-7">
            <div class="mb-4">
                <h2 class="fw-bold text-secondary">Lectures</h2>
                <security:authorize access="hasRole('TEACHER')">
                    <a href="<c:url value='/lecture/create' />" class="btn btn-success btn-lg btn-large-action w-100 mt-2 shadow-sm">
                        + Create New Lecture
                    </a>
                </security:authorize>
            </div>
            <c:choose>
                <c:when test="${fn:length(lectureDatabase) == 0}">
                    <div class="card card-body text-center py-5 text-muted">No lectures available.</div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${lectureDatabase}" var="lecture">
                        <div class="card mb-3">
                            <div class="card-body d-flex align-items-center">
                                <div class="bg-light rounded p-3 me-3 text-center" style="min-width: 60px;">
                                    <span class="fw-bold text-dark">${lecture.id}</span>
                                </div>
                                <div>
                                    <h5 class="mb-1">
                                        <a href="<c:url value='/lecture/coursematerial/${lecture.id}' />" class="text-decoration-none text-dark fw-bold">
                                            <c:out value="${lecture.title}"/>
                                        </a>
                                    </h5>
                                    <p class="text-muted mb-0 small"><c:out value="${lecture.summary}"/></p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="col-lg-5">
            <div class="mb-4">
                <h2 class="fw-bold text-secondary">Active Polls</h2>
                <security:authorize access="hasRole('TEACHER')">
                    <a href="<c:url value='/poll/admin/polls/new' />" class="btn btn-primary btn-lg btn-large-action w-100 mt-2 shadow-sm">
                       + Launch New Poll
                    </a>
                </security:authorize>
            </div>
            <c:choose>
                <c:when test="${fn:length(pollDatabase) == 0}">
                    <div class="card card-body text-center py-5 text-muted">No polls active.</div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${pollDatabase}" var="poll">
                        <div class="card mb-3 border-start border-primary border-4">
                            <div class="card-body">
                                <small class="text-primary fw-bold text-uppercase" style="font-size: 0.7rem;">Poll #${poll.id}</small>
                                <h6 class="mt-1 mb-0">
                                    <a href="<c:url value='/poll/${poll.id}' />" class="text-decoration-none text-dark">
                                        <c:out value="${poll.question}"/>
                                    </a>
                                </h6>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>