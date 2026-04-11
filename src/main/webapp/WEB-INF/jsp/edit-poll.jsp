<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Poll</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
    <h2 class="mb-4">Edit Poll #${pollId}</h2>

    <form:form method="POST" modelAttribute="pollEditForm"
               action="/poll/admin/polls/${pollId}/edit" cssClass="card p-4 shadow">

        <div class="mb-3">
            <label class="form-label fw-bold">Poll Question</label>
            <form:input path="question" cssClass="form-control" required="true"/>
        </div>

        <h5 class="mt-4">Five Options</h5>
        <div class="mb-3">
            <form:input path="option1" cssClass="form-control mb-2" required="true"/>
            <form:input path="option2" cssClass="form-control mb-2" required="true"/>
            <form:input path="option3" cssClass="form-control mb-2" required="true"/>
            <form:input path="option4" cssClass="form-control mb-2" required="true"/>
            <form:input path="option5" cssClass="form-control mb-2" required="true"/>
        </div>

        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

        <button type="submit" class="btn btn-primary btn-lg">Save Changes</button>
        <a href="<c:url value='/indexpage' />" class="btn btn-secondary btn-lg">Cancel</a>
    </form:form>
</div>
</body>
</html>