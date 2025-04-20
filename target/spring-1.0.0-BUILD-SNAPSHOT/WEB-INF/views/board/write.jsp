<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/board/board-header.jsp"/>
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/js/summernote/summernote-lite.css">
<link rel="stylesheet" href="/css/board/write.css" />
<div class="content">
</div>
<form action="${action == null ?  '/board/insert' : action}" method="post" enctype="multipart/form-data">
<table>
    <tr>
        <th class="label">등록일</th>
        <td>
            <div class="date"></div>
        </td>
    </tr>
    <c:if test="${not empty action}">
        <tr>
            <th>종류</th>
            <td colspan="3">
                <div class="checkboxArea">
                    <select id="searchOption" name="noticeCtId" required>
                        <option value="">선택하십시오</option>
                        <c:forEach items="${noticeCategoryList}" var="noticeCt">
                            <option value="${noticeCt.id}">${noticeCt.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </td>
        </tr>
    </c:if>
    <tr>
        <th class="label">제목 <span class="required">*</span></th>
        <td colspan="3">
            <input type="text" name="title">
        </td>
    </tr>
    <tr>
        <th class="label">이름 <span class="required">*</span></th>
        <td colspan="3">
            <c:choose>
                <c:when test="${action != null}">
                    <input type="text" readonly value="관리자" disabled/>
                </c:when>
                <c:otherwise>
                    <input type="text" value="${employee.name}" disabled/>
                </c:otherwise>
            </c:choose>
        </td>
    </tr>
    <tr>
        <th class="label">첨부파일</th>
        <td colspan="3">
            <jsp:include page="/WEB-INF/views/template/fileInput.jsp"/>
        </td>
    </tr>
    <tr>
        <td colspan="4" class="board-detail-content">
            <input type="text" id="content" name="content">
        </td>
    </tr>
</table>
<div class="button-container">
    <button class="primary">저장</button>
    <a href="${action == null ? '/board/list?page=1' : '/notice/list?page=1'}">
        <button type="button" class="secondary">취소</button>
    </a>
</div>
</form>
<script type="text/javascript" src="/js/template/summernote.js"></script>
<script>
    window.onload = function () {
        const date = new Date(); // 올바른 작성법: new Date()
        document.querySelector('.date').innerHTML = date.toLocaleString(); // 현재 날짜와 시간을 형식에 맞게 출력
    };

    $(document).ready(function () {
        $('#content').summernote(summernoteSetting($('#content')));

        $('form').on('submit', function () {
            const content = $('#content').summernote('code');
            $('input[name="content"]').val(content);
            return true;
        })
    })
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
