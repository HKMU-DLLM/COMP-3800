<!DOCTYPE html>
<html>
<head>
    <title>User Info</title>
</head>
<body>

<c:if test="${param.success != null}">
    <p style="color: green;">Profile updated successfully.</p>
</c:if>

<h2>Your Information</h2>

<table>
    <tr><th>ID</th><td><c:out value="${user.id}"/></td></tr>
    <tr><th>Username</th><td><c:out value="${user.username}"/></td></tr>
    <tr><th>Full Name</th><td><c:out value="${user.fullName}"/></td></tr>
    <tr><th>Email</th><td><c:out value="${user.email}"/></td></tr>
    <tr><th>Phone</th><td><c:out value="${user.phone}"/></td></tr>
    <tr><th>Role</th><td><c:out value="${user.role}"/></td></tr>
</table>

<br/>

<a href="<c:url value='/userinfo/edituser' />">Edit your information</a>

</body>
</html>