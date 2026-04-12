<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; min-height: 100vh; }
        .navbar-brand { font-weight: 800; letter-spacing: -0.5px; }
        .login-card { border: none; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .btn-login { padding: 0.6rem; font-weight: 600; }
    </style>
</head>
<body>

<nav class="navbar navbar-dark bg-dark mb-5 shadow-sm">
    <div class="container justify-content-center">
        <a class="navbar-brand" href="/indexpage">Online Course</a>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">

            <c:if test="${param.error != null}">
                <div class="alert alert-danger border-0 shadow-sm mb-4" role="alert">
                    <strong>Login failed!</strong> Please check your credentials.
                </div>
            </c:if>
            <c:if test="${param.logout != null}">
                <div class="alert alert-success border-0 shadow-sm mb-4" role="alert">
                    You have been successfully logged out.
                </div>
            </c:if>

            <div class="card login-card p-4">
                <div class="card-body">
                    <h2 class="text-center fw-bold mb-4">Login</h2>

                    <form action="login" method="POST">
                        <div class="mb-3">
                            <label for="username" class="form-label text-muted small fw-bold">USERNAME</label>
                            <input type="text" id="username" name="username" class="form-control form-control-lg" placeholder="Enter username" required autofocus/>
                        </div>

                        <div class="mb-4">
                            <label for="password" class="form-label text-muted small fw-bold">PASSWORD</label>
                            <input type="password" id="password" name="password" class="form-control form-control-lg" placeholder="Enter password" required/>
                        </div>

                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary btn-lg btn-login">Log In</button>
                        </div>
                    </form>

                    <div class="text-center">
                        <span class="text-muted small">Don't have an account?</span>
                        <a href="<c:url value="/signup" />" class="text-decoration-none fw-bold ms-1">Sign up</a>
                    </div>
                </div>
            </div>

            <div class="text-center mt-4">
                <a href="/indexpage" class="btn btn-link text-secondary text-decoration-none small">
                    &larr; Back to Home Page
                </a>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>