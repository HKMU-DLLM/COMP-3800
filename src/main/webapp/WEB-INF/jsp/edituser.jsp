<!DOCTYPE html>
<html>
<head>
    <title>Edit User Info</title>
</head>
<body>

<h2>Edit Your Information</h2>

<form action="<c:url value='/userinfo/edituser' />" method="post">

    <input type="hidden" name="id" value="${user.id}" />
    <input type="hidden" name="username" value="${user.username}">



    <div>
        <label>New Password:</label><br/>
        <input type="password" name="password" />
    </div>
    <br/>

    <div>
        <label>Full Name:</label><br/>
        <input type="text" name="fullName" value="${user.fullName}" />
    </div>
    <br/>

    <div>
        <label>Email:</label><br/>
        <input type="email" name="email" value="${user.email}" />
    </div>
    <br/>

    <div>
        <label>Phone:</label><br/>
        <input type="text" name="phone" value="${user.phone}" />
    </div>
    <br/>


    <div>
        <input type="submit" value="Save Changes" />
    </div>

    <c:if test="${not empty _csrf}">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </c:if>
</form>

<br/>
<a href="<c:url value='/userinfo' />">Back to your info</a>

</body>
</html>