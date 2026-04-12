<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; min-height: 100vh; }
        .navbar-brand { font-weight: 800; letter-spacing: -0.5px; }
        .edit-card { border: none; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .form-label { font-size: 0.8rem; font-weight: 700; color: #6c757d; }
        .readonly-info { background-color: #e9ecef; color: #6c757d; font-weight: 600; }
    </style>
</head>
<body>

<nav class="navbar navbar-dark bg-dark mb-5 shadow-sm">
    <div class="container justify-content-center">
        <a class="navbar-brand" href="/indexpage">Online Course</a>
    </div>
</nav>

<div class="container pb-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">

            <div class="card edit-card p-4">
                <div class="card-body">
                    <h2 class="fw-bold mb-1 text-center">Edit Information</h2>
                    <p class="text-center text-muted small mb-4">Update your personal account details</p>
                    <hr class="mb-4 opacity-10">

                    <form action="<c:url value='/userinfo/edituser' />" method="post">

                        <input type="hidden" name="id" value="${user.id}" />
                        <input type="hidden" name="username" value="${user.username}">
                        <input type="hidden" name="role" value="${user.role}" />

                        <div class="mb-3">
                            <label class="form-label text-uppercase">Username (Permanent)</label>
                            <input type="text" class="form-control readonly-info" value="${user.username}" readonly disabled>
                        </div>

                        <div class="mb-3">
                            <label class="form-label text-uppercase">Full Name</label>
                            <div class="input-group">
                                <input type="text" name="fullName" class="form-control" value="${user.fullName}" required />
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label text-uppercase">Email Address</label>
                            <div class="input-group">
                                <input type="email" name="email" class="form-control" value="${user.email}" required />
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label text-uppercase">Phone Number</label>
                            <div class="input-group">
                                <input type="text" name="phone" class="form-control" value="${user.phone}" />
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label text-uppercase">New Password</label>
                            <div class="input-group">
                                <input type="password" name="password" class="form-control" placeholder="Leave blank to keep current" />
                            </div>
                        </div>

                        <c:if test="${not empty _csrf}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </c:if>

                        <div class="d-grid gap-2 mt-5">
                            <button type="submit" class="btn btn-primary btn-lg fw-bold shadow-sm">Save Changes</button>
                            <a href="<c:url value='/userinfo' />" class="btn btn-outline-secondary">Cancel & Go Back</a>
                        </div>

                    </form>
                </div>
            </div>

            <p class="text-center mt-4 text-muted small">
                Security notice: If you change your password, you may be required to log in again.
            </p>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>