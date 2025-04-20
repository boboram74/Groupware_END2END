<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/board/board-header.jsp"/>
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/js/summernote/summernote-lite.css">
<link rel="stylesheet" href="/css/board/write.css" />
<div class="form-container">
    <form action="${action == null ? '/board/update' : '/notice/update'}" method="post" enctype="multipart/form-data">
    <table class="form-table">
        <tr>
            <th class="label">등록일<span class="required"></span></th>
            <td>
                <span class="date-field"></span>
                <div class="date">${board.regDate}</div>
            </td>
            <c:if test="${action != null}">
                <th class="label">분류</th>
                <td>${board.noticeCtName}</td>
            </c:if>
        </tr>
        <tr>
            <th class="label">제목<span class="required"></span></th>
            <td colspan="3">
                <input type="text" class="form-input" name="title" value="${board.title}">
            </td>
        </tr>
        <tr>
            <th class="label">이름<span class="required"></span></th>
            <td colspan="3">
                <c:choose>
                    <c:when test="${action == null}">
                        <input type="text" value="${board.employeeName}" disabled />
                    </c:when>
                    <c:otherwise>
                        관리자
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th class="label">첨부파일</th>
            <td colspan="3">
                <jsp:include page="/WEB-INF/views/template/fileInput.jsp" />
                <c:forEach items="${fileList}" var="file">
                    <div>
                        <span>${file.originFileName}</span>
                        <button onclick="$(this).parent().remove();">삭제</button>
                        <input type="hidden" name="fileId" value="${file.id}" />
                    <div/>
                </c:forEach>
            </td>
        </tr>
        <tr>
            <td colspan="5" class="board-detail-content">
                <textarea class="form-textarea" name="content" id="content">${board.content}</textarea>
            </td>
        </tr>
        <input type="hidden" name="id" value="${board.id}">
    </table>
    <div class="button-container">
        <button class="primary">수정</button>
        <button type="button" class="secondary" onclick="location.href = ${actaion == null ?'/board/detail/' : '/notice/detail/'}${board.id};">취소</button>

    </div>
    </form>
</div>
<script type="text/javascript" src="/js/template/summernote.js"></script>
<script>
    $('#content')
        .summernote(summernoteSetting($('#content')))
        .summernote('code', '${board.content}');

    $('form').on('submit', function(e) {
        $('input [name="content"]').val($('#content').summernote('code'));
    })
</script>
<script src="/js/main/contact.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/board/board-footer.jsp"/>
