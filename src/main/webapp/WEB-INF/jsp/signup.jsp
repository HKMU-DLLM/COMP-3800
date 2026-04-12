<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sign Up</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; min-height: 100vh; }
        .navbar-brand { font-weight: 800; letter-spacing: -0.5px; }
        .register-card { border: none; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .btn-register { padding: 0.6rem; font-weight: 600; }
    </style>
</head>
<body>

<nav class="navbar navbar-dark bg-dark mb-4 shadow-sm">
    <div class="container justify-content-center">
        <a class="navbar-brand" href="/indexpage">Online Course</a>
    </div>
</nav>

<div class="container pb-5">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-5">

            <div class="card register-card p-4">
                <div class="card-body">
                    <h2 class="text-center fw-bold mb-4">Create Account</h2>

                    <form:form method="post"
                               action="${pageContext.request.contextPath}/signup"
                               modelAttribute="userForm">

                        <div class="row g-3">
                            <div class="col-12">
                                <form:label path="username" class="form-label text-uppercase">Username</form:label>
                                <form:input path="username" class="form-control" maxlength="50" required="required"/>
                            </div>

                            <div class="col-12">
                                <form:label path="password" class="form-label text-uppercase">Password</form:label>
                                <form:password path="password" class="form-control" required="required"/>
                            </div>

                            <div class="col-12">
                                <form:label path="fullName" class="form-label text-uppercase">Full Name</form:label>
                                <form:input path="fullName" class="form-control" maxlength="100" required="required"/>
                            </div>

                            <div class="col-md-6">
                                <form:label path="email" class="form-label text-uppercase">Email</form:label>
                                <form:input path="email" type="email" class="form-control" maxlength="120" required="required"/>
                            </div>

                            <div class="col-md-6">
                                <form:label path="phone" class="form-label text-uppercase">Phone</form:label>
                                <form:input path="phone" class="form-control" maxlength="30" required="required"/>
                            </div>

                            <div class="col-12">
                                <form:label path="role" class="form-label text-uppercase">Join As</form:label>
                                <form:select path="role" class="form-select">
                                    <form:option value="STUDENT">Student</form:option>
                                    <form:option value="TEACHER">Teacher</form:option>
                                </form:select>
                            </div>
                        </div>

                        <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </c:if>

                        <div class="d-grid mt-4 pt-2">
                            <button type="submit" class="btn btn-success btn-lg btn-register shadow-sm">Sign Up</button>
                        </div>

                    </form:form>

                    <!-- CSRF token if Spring Security is enabled -->
                    <c:if test="${not empty _csrf}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </c:if>


                    <div class="text-center mt-4">
                        <span class="text-muted small">Already have an account?</span>
                        <a href="<c:url value="/login" />" class="text-decoration-none fw-bold ms-1">Log in</a>
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