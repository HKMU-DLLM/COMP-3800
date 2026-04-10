<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>
</head>
<body>

<h2>Sign Up</h2>

<form:form method="post"
           action="${pageContext.request.contextPath}/signup"
           modelAttribute="userForm">

    <div>
        <form:label path="username">Username:</form:label><br/>
        <form:input path="username" maxlength="50" required="required" />
    </div>
    <br/>

    <div>
        <form:label path="password">Password:</form:label><br/>
        <form:password path="password" required="required" />
    </div>
    <br/>

    <div>
        <form:label path="fullName">Full Name:</form:label><br/>
        <form:input path="fullName" maxlength="100" required="required" />
    </div>
    <br/>

    <div>
        <form:label path="email">Email:</form:label><br/>
        <form:input path="email" type="email" maxlength="120" required="required" />
    </div>
    <br/>

    <div>
        <form:label path="phone">Phone:</form:label><br/>
        <form:input path="phone" maxlength="30" required="required" />
    </div>
    <br/>

    <div>
        <form:label path="role">Role:</form:label><br/>
        <form:select path="role">
            <form:option value="STUDENT">Student</form:option>
            <form:option value="TEACHER">Teacher</form:option>
        </form:select>
    </div>
    <br/>

    <div>
        <input type="submit" value="Sign Up"/>
    </div>

    <!-- CSRF token if Spring Security is enabled -->
    <c:if test="${not empty _csrf}">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </c:if>

</form:form>

</body>
</html>