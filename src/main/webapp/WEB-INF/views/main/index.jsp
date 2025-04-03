<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:choose>
    <c:when test="${employee == null}">
        <jsp:include page="login.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="/WEB-INF/views/template/header.jsp"/>
        <script src="/js/summernote/summernote-lite.js"></script>
        <script src="/js/summernote/lang/summernote-ko-KR.js"></script>
        <link rel="stylesheet" href="/js/summernote/summernote-lite.css">
        <div>
            <form action="file/upload/test" method="post" enctype="multipart/form-data">
                <jsp:include page="/WEB-INF/views/template/fileInput.jsp" />
                <input type="hidden" name="id" value="1">
                <textarea id="contents"></textarea>
                <button>submit</button>
            </form>
        </div>
        <script src="/js/template/summernote.js" type="text/javascript"></script>
        <script>
            $(document).ready(() => {
                $('#contents').summernote(summernoteSetting());
            })
        </script>
        <jsp:include page="/WEB-INF/views/template/footer.jsp"/>
    </c:otherwise>
</c:choose>


