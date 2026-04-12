<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Create Lecture</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; min-height: 100vh; }
        .navbar-brand { font-weight: 800; letter-spacing: -0.5px; }
        .create-card { border: none; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .form-label { font-size: 0.8rem; font-weight: 700; color: #6c757d; }
        .btn-submit { padding: 0.75rem; font-weight: 600; text-transform: uppercase; }
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

            <div class="card create-card p-4">
                <div class="card-body">
                    <h2 class="fw-bold mb-4 text-center">Create a New Lecture</h2>
                    <hr class="mb-4 opacity-10">

                    <form:form method="POST"
                               action="${pageContext.request.contextPath}/lecture/create"
                               enctype="multipart/form-data"
                               modelAttribute="lectureForm">

                        <div class="mb-3">
                            <form:label path="title" class="form-label text-uppercase">Lecture Title</form:label>
                            <form:input type="text" path="title" class="form-control form-control-lg" required="required" />
                        </div>

                        <div class="mb-3">
                            <form:label path="summary" class="form-label text-uppercase">Summary</form:label>
                            <form:textarea path="summary" class="form-control" rows="5"
                                           placeholder="Provide a brief overview of what this lecture covers..." required="required" />
                        </div>

                        <div class="mb-4">
                            <label class="form-label text-uppercase">Attachments</label>
                            <div class="input-group">
                                <input type="file" name="attachments" multiple="multiple" class="form-control" id="inputGroupFile02">
                                <label class="input-group-text" for="inputGroupFile02">Upload</label>
                            </div>
                        </div>

                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                        <div class="d-grid gap-2 mt-5">
                            <button type="submit" class="btn btn-success btn-lg btn-submit shadow-sm">Publish Lecture</button>
                            <a href="/indexpage" class="btn btn-outline-secondary">Cancel</a>
                        </div>

                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>