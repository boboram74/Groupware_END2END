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

    /*-----------------------------------*/
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
<div class="replyContainer" style="border:1px solid black; width: 100%; height:120px;">
    <div class="addReply" style="width:100%; height:100%; display: flex">
        <div class="addFile" style="width:10%; height:100%; ">
            <input type="file" placeholder="파일" style="width:100%; height:100%;">
        </div>
        <div class="addInput" style="width:85%; height:100%;">
            <textarea style="width:100%; height:100%;">댓글 입력</textarea>
        </div>
        <div class="addBtn" style="width:5%; height:100%;">
            <button style="width:100%; height:100%;">등록</button>
        </div>
    </div>
</div>
<hr>
<h3>댓글 (viewCount)</h3>
<div class="replyList" style="width:100%; height:120px; border:1px solid black; display: flex">
    <div class="profile" style="width:10%; height:100%; border:1px solid black"></div>
    <div class="replyWrite" style="width:85%; height:100%; border:1px solid black">
        <div class="writerSysdate" style="width:100%; height:23%; border:1px solid black">
            <div class="realContents" style="width:30%; height:100%; border:1px solid red; display: flex">
                <input type="text" style="width:50%; height:100%; border:1px solid yellow" placeholder="사용자아이디(기능)">
                <input type="text" style="width:50%; height:100%; border:1px solid yellow" placeholder="등록날짜(기능)">
            </div>
        </div>
        <div class="inputReply" style="width:100%; height:77%; border:1px solid black">
            <input type="text" value="gg" style="width:100%; height:100%;">
        </div>
    </div>
    <div class="replyReport" style="width:5%; height:100%; border:1px solid black; display: flow">
        <div class="reReply" style="width:100%; height:50%; border:1px solid red;">
            <button style="width:100%; height:100%;">댓글</button>
        </div>
        <div class="report" style="width:100%; height:50%; border:1px solid red;">
            <button style="width:100%; height:100%;">신고</button>
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
