
<!DOCTYPE html>
<html>
<head>
    <title>Course</title>
</head>
<body>

<h2>List of lecture</h2><a href="<c:url value="/lecture/create" />">Create a Lecture</a><br/><br/>

<c:choose>
    <c:when test="${fn:length(lectureDatabase) == 0}">
        <i>There are no lecture in the system.</i>
    </c:when>
    <c:otherwise>
        <c:forEach items="${lectureDatabase}" var="lecture">
            <div class="lecture-item">
                <strong>Lecture ${lecture.id}:</strong>
                <a href="<c:url value='/lecture/view/${lecture.id}' />">
                    <c:out value="${lecture.title}"/>
                </a>
                <p><c:out value="${lecture.summary}"/></p>
            </div>
        </c:forEach>
    </c:otherwise>
</c:choose>
</body>
</html>