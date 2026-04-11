<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Lecture</title>
</head>
<body>
<h2>Create a Lecture</h2>

<form:form method="POST"
           action="${pageContext.request.contextPath}/lecture/create"
           enctype="multipart/form-data"
           modelAttribute="lectureForm">

    <form:label path="title">Lecture Name</form:label><br/>
    <form:input type="text" path="title"/><br/><br/>

    <form:label path="summary">Summary</form:label><br/>
    <form:textarea path="summary" rows="5" cols="30"/><br/><br/>

    <b>Attachments</b><br/>
    <input type="file" name="attachments" multiple="multiple"/><br/><br/>

    <input type="submit" value="Submit"/>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form:form>
</body>
</html>