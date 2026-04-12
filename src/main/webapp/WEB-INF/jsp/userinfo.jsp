<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>My Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; }
        .navbar-brand { font-weight: 800; letter-spacing: -0.5px; }
        .profile-card { border: none; border-radius: 15px; overflow: hidden; }
        .profile-header {
            background: linear-gradient(135deg, #212529 0%, #343a40 100%);
            color: white;
            padding: 3rem 2rem;
        }
        .avatar-circle {
            width: 100px;
            height: 100px;
            background-color: #fff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            font-weight: bold;
            color: #212529;
            margin-bottom: 1rem;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
        .info-label { font-size: 0.75rem; text-transform: uppercase; font-weight: 700; color: #6c757d; }
        .info-value { font-size: 1.1rem; color: #212529; margin-bottom: 1.5rem; }
        .history-btn { background-color: #e9ecef; color: #495057; border: none; transition: 0.2s; }
        .history-btn:hover { background-color: #dee2e6; color: #212529; }
    </style>
</head>
<body>

<nav class="navbar navbar-dark bg-dark mb-4 shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="/indexpage">Online Course</a>
        <a href="<c:url value='/indexpage' />" class="btn btn-outline-light btn-sm">Dashboard</a>
    </div>
</nav>

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-8">

            <div class="card profile-card shadow-sm">
                <div class="profile-header text-center d-flex flex-column align-items-center">
                    <div class="avatar-circle">
                        <c:out value="${user.username.substring(0,1).toUpperCase()}"/>
                    </div>
                    <h2 class="fw-bold mb-0"><c:out value="${user.fullName}"/></h2>
                    <span class="badge bg-primary mt-2 px-3 py-2 text-uppercase"><c:out value="${user.role}"/></span>
                </div>

                <div class="card-body p-5">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="info-label">Username</div>
                            <div class="info-value"><c:out value="${user.username}"/></div>

                            <div class="info-label">Email Address</div>
                            <div class="info-value"><c:out value="${user.email}"/></div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-label">Phone Number</div>
                            <div class="info-value"><c:out value="${user.phone}"/></div>

                        </div>
                    </div>

                    <hr class="my-4 opacity-10">

                    <div class="row g-3">
                        <div class="col-md-6">
                            <h6 class="fw-bold mb-3">Account Settings</h6>
                            <a href="<c:url value='/userinfo/edituser' />" class="btn btn-warning w-100 fw-bold">
                                Edit Profile
                            </a>
                        </div>
                        <div class="col-md-6">
                            <h6 class="fw-bold mb-3">Activity History</h6>
                            <div class="d-flex gap-2">
                                <a href="<c:url value='/me/voting-history' />" class="btn history-btn flex-grow-1 py-2">
                                    Votes
                                </a>
                                <a href="<c:url value='/me/comment-history' />" class="btn history-btn flex-grow-1 py-2">
                                    Comments
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <p class="text-center mt-4">
                <a href="<c:url value='/indexpage' />" class="text-muted text-decoration-none small">
                    ← Return to main dashboard
                </a>
            </p>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>