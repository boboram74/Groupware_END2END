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

    /*----------------버-------------------*/
    .replyContainer {
        border: 1px solid black;
        width: 100%;
        height: 120px;
    }

    .addReply {
        width: 100%;
        height: 100%;
        display: flex;
    }

    .addFile {
        width: 10%;
        height: 100%;
    }

    .addFile input {
        width: 100%;
        height: 100%
    }

    .addInput {
        width: 85%;
        height: 100%;
    }

    .addInput textarea {
        width: 100%;
        height: 100%;
    }

    .addBtn {
        width: 5%;
        height: 100%;
    }

    .addBtn button {
        width: 100%;
        height: 100%;
    }

    .replyList {
        width: 100%;
        height: 120px;
        border: 1px solid black;
        display: flex;
    }

    .profile {
        width: 10%;
        height: 100%;
        border: 1px solid black;
    }

    .replyWrite {
        width: 85%;
        height: 100%;
    }

    .writerSysdate {
        width: 100%;
        height: 23%;
    }

    .realContents {
        width: 30%;
        height: 100%;
        display: flex;
    }

    .realContents input {
        width: 50%;
        height: 100%;
    }

    .inputReply {
        width: 100%;
        height: 77%;
    }

    .inputReply input {
        width: 100%;
        height: 100%;
    }

    .replyReport {
        width: 5%;
        height: 100%;
        display: flow;
    }

    .reReply {
        width: 100%;
        height: 50%;
    }

    .reReply button {
        width: 100%;
        height: 100%;
    }

    .report {
        width: 100%;
        height: 50%;
    }

    .report button {
        width: 100%;
        height: 100%;
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
    <a href="/board/list">
        <button class="backBtn">목록</button>
    </a>
    <a href="/board/write/update?id=${board.id}">
        <button type="button" class="editBtn">수정</button>
    </a>
    <form action="/board/delete" method="post">
        <input type="hidden" name="id" value="${board.id}"/>
        <button type="submit" class="deleteBtn">삭제</button>
    </form>
</div>
<hr>
<div class="replyContainer">
    <div class="addReply">
        <div class="addFile">
            <input type="file" placeholder="파일">
        </div>
        <div class="addInput">
            <textarea>댓글 입력</textarea>
        </div>
        <div class="addBtn">
            <button>등록</button>
        </div>
    </div>
</div>
<hr>
<h3>댓글 (viewCount)</h3>
<div class="replyList">
    <div class="profile"></div>
    <div class="replyWrite">
        <div class="writerSysdate">
            <div class="realContents">
                <input type="text" placeholder="사용자아이디(기능)">
                <input type="text" placeholder="등록날짜(기능)">
            </div>
        </div>
        <div class="inputReply">
            <input type="text" value="gg">
        </div>
    </div>
    <div class="replyReport">
        <div class="reReply">
            <button>댓글</button>
        </div>
        <div class="report">
            <button>신고</button>
        </div>
    </div>
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
