<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Create Poll</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; min-height: 100vh; }
        .navbar-brand { font-weight: 800; letter-spacing: -0.5px; }
        .create-card { border: none; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .form-label { font-size: 0.8rem; font-weight: 700; color: #6c757d; }
        .input-group-text { min-width: 40px; justify-content: center; font-weight: bold; color: #198754; }
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
                    <h2 class="fw-bold mb-1 text-center">New Poll</h2>
                    <p class="text-center text-muted small mb-4">Engage your students with a quick question</p>
                    <hr class="mb-4 opacity-10">

                    <form:form method="POST" modelAttribute="pollForm" action="/poll/admin/polls/new">

                        <div class="mb-4">
                            <label class="form-label text-uppercase">Poll Question</label>
                            <form:input path="question" cssClass="form-control form-control-lg border-success"
                                        placeholder="e.g. Which topic should we cover next?" required="true"/>
                        </div>

                        <h6 class="form-label text-uppercase mb-3">Response Options <span class="text-lowercase fw-normal">(All 5 required)</span></h6>

                        <div class="space-y-2">
                            <div class="input-group mb-2 shadow-sm">
                                <span class="input-group-text bg-white">1</span>
                                <form:input path="option1" cssClass="form-control" placeholder="First option" required="true"/>
                            </div>

                            <div class="input-group mb-2 shadow-sm">
                                <span class="input-group-text bg-white">2</span>
                                <form:input path="option2" cssClass="form-control" placeholder="Second option" required="true"/>
                            </div>

                            <div class="input-group mb-2 shadow-sm">
                                <span class="input-group-text bg-white">3</span>
                                <form:input path="option3" cssClass="form-control" placeholder="Third option" required="true"/>
                            </div>

                            <div class="input-group mb-2 shadow-sm">
                                <span class="input-group-text bg-white">4</span>
                                <form:input path="option4" cssClass="form-control" placeholder="Fourth option" required="true"/>
                            </div>

                            <div class="input-group mb-4 shadow-sm">
                                <span class="input-group-text bg-white">5</span>
                                <form:input path="option5" cssClass="form-control" placeholder="Fifth option" required="true"/>
                            </div>
                        </div>

                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                        <div class="d-grid gap-2 mt-5">
                            <button type="submit" class="btn btn-success btn-lg fw-bold shadow-sm">Launch Poll</button>
                            <a href="<c:url value='/indexpage' />" class="btn btn-outline-secondary">Cancel</a>
                        </div>

                    </form:form>
                </div>
            </div>

            <div class="text-center mt-4 text-muted small">
                <p>Polls are visible to all students immediately after creation.</p>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>