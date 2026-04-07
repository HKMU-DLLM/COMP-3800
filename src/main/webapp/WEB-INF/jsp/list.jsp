<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Course</title>
</head>
<body>

<!--<h2>List of lecture</h2><a href="<c:url value="/ticket/create" />">Create a Ticket</a><br/><br/>--!>

<c:choose>
    <c:when test="${fn:length(lectureDatabase) == 0}">
        <i>There are no lecture in the system.</i>
    </c:when>
    <c:otherwise>
        <c:forEach items="${lectureDatabase}" var="entry">
            Lecture ${entry.key}:
            <a href="<c:url value="/lecture/view/${entry.key}" />">
                <c:out value="${entry.value.subject}"/></a>
            (customer: <c:out value="${entry.value.customerName}"/>)<br />
        </c:forEach>
    </c:otherwise>
</c:choose>
</body>
</html>