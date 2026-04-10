
<!DOCTYPE html>
<html>
<head>
    <title>Course</title>
</head>
<body>
<c:url var="logoutUrl" value="/logout"/>
<form action="${logoutUrl}" method="post">
    <input type="submit" value="Log out" />
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>

<a href="<c:url value="/login" />">
    <button type="button">Login</button>
</a>

<security:authorize access="hasAnyRole('TEACHER','STUDENT')">
    <a href="<c:url value='/userinfo' />">
        <security:authentication property="name" />
    </a>
</security:authorize>

<security:authorize access="hasRole('TEACHER')">
    <a href="<c:url value="/user" />">Manage User Accounts</a><br /><br />
</security:authorize>

<h2>List of lecture</h2>
<security:authorize access="hasRole('TEACHER')">
    <a href="<c:url value="/lecture/create" />">Create a Lecture</a><br/><br/>
</security:authorize>

<c:choose>
    <c:when test="${fn:length(lectureDatabase) == 0}">
        <i>There are no lecture in the system.</i>
    </c:when>
    <c:otherwise>
        <c:forEach items="${lectureDatabase}" var="lecture">
            <div class="lecture-item">
                <strong>Lecture ${lecture.id}:</strong>
                <a href="<c:url value='/lecture/coursematerial/${lecture.id}' />">
                    <c:out value="${lecture.title}"/>
                </a>
                <p><c:out value="${lecture.summary}"/></p>
            </div>
        </c:forEach>
    </c:otherwise>
</c:choose>

<h2>List of Poll</h2>
<security:authorize access="hasRole('TEACHER')">
    <a href="<c:url value="/poll/admin/polls/new" />">Create a Poll</a><br/><br/>
</security:authorize>
<c:choose>
    <c:when test="${fn:length(pollDatabase) == 0}">
        <i>There are no poll in the system.</i>
    </c:when>
    <c:otherwise>
        <c:forEach items="${pollDatabase}" var="poll">
            <div class="poll-item">
                <strong>Poll ${poll.id}:</strong>
                <a href="<c:url value='/poll/${poll.id}' />">
                    <c:out value="${poll.question}"/>
                </a>
            </div>
        </c:forEach>
    </c:otherwise>
</c:choose>

</body>
</html>