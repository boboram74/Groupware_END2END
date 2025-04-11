<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/board/board-header.jsp"/>
<style>
    table {
        width: 100%;
        border-collapse: collapse;
        border-top: 1px solid #ccc;
        border-bottom: 1px solid #ccc;

    }

    th, td {
        padding: 8px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    .label {
        background-color: #f8f8f8;
        width: 15%;
        border-right: 1px solid #ddd;
    }

    .contents {
        width: 60%;
    }

    .meta {
        width: 15%;
        text-align: center;
        border-left: 1px solid #ddd;
    }

    .date {
        width: 20%;
        text-align: center;
        border-left: 1px solid #ddd;
    }

    .btnGroup {
        margin-top: 10px;
        text-align: center;
        display: flex;
    }

    .editBtn, .deleteBtn, .replyBtn, .backBtn {
        padding: 6px 12px;
        margin: 0 2px;
        border: 1px solid #ccc;
        background-color: white;
        cursor: pointer;
    }

    .editBtn {
        background-color: #f8f8f8;
        color: #333;
    }

    .deleteBtn {
        background-color: #f8f8f8;
        color: #333;
    }

    .replyBtn {
        background-color: #f8f8f8;
        color: #333;
    }

    .backBtn {
        background-color: #f8f8f8;
        color: #333;
    }
</style>
<div class="content">

</div>
<div class="button-container">
    <button class="extended-button">연장근무 신청</button>
    <button class="vacation-button">휴가 신청</button>
</div>
<table>
    <tr>
        <td class="label">글유형</td>
        <td class="contents">공지</td>
        <td class="meta">등록일</td>
        <td class="date">${board.regDate}</td>
    </tr>
    <tr>
        <td class="label">제목</td>
        <td class="contents">${board.title}</td>
        <td class="meta">조회</td>
        <td class="date">${board.viewCount}</td>
    </tr>
    <tr>
        <td class="label">이름</td>
        <td colspan="3">${board.employeeId}</td>
    </tr>
    <tr>
        <td class="label">내용</td>
        <td colspan="3">${board.content}</td>
    </tr>
    <c:forEach var="file" items="${fileList}">
        <tr>
            <td class="label">첨부파일</td>
            <td colspan="3">
                <span>${file.originFileName}</span>
                <a href="/download/${file.id}">다운로드</a>
            </td>
        </tr>
    </c:forEach>
</table>
<div class="btnGroup">
    <a href="/board/write/update?id=${board.id}">
        <button type="button" class="editBtn">수정</button>
    </a>
    <form action="/board/delete" method="post">
        <input type="hidden" name="id" value="${board.id}"/>
        <button type="submit" class="deleteBtn">삭제</button>
    </form>
    <button class="replyBtn">답변</button>
    <a href="/board/list">
        <button class="backBtn">뒤로</button>
    </a>
</div>

<script>
    document.querySelector(".deleteBtn").addEventListener("click", function (e) {
        if (!confirm("정말 삭제하시겠습니까?")) {
            e.preventDefault();
        }
    })
</script>


<script src="/js/main/contact.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/board/board-footer.jsp"/>
