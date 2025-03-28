<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:choose>
    <c:when test="${login == null}">
        <jsp:include page="login.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="/WEB-INF/views/template/header.jsp"/>
        <div>
            HELLO END2END
        </div>
        <jsp:include page="/WEB-INF/views/template/footer.jsp"/>
    </c:otherwise>
</c:choose>


