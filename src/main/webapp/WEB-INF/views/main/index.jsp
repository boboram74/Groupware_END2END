<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:choose>
    <c:when test="${login != null}">
        <jsp:include page="login.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="/WEB-INF/views/template/header.jsp"/>
        <div>
            <form>
                <jsp:include page="/WEB-INF/views/template/fileInput.jsp" />
                <button>submit</button>
            </form>
        </div>
        <script>
            $('form').on('submit', (event) => {
                event.preventDefault();
                console.log($('input[name="files"]')[0].files)
            })
        </script>
        <jsp:include page="/WEB-INF/views/template/footer.jsp"/>
    </c:otherwise>
</c:choose>


