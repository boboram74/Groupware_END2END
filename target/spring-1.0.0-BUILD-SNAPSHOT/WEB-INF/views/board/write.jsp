<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/board/board-header.jsp"/>
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/js/summernote/summernote-lite.css">
<style>
    * {
        box-sizing: border-box;
        font-family: 'Malgun Gothic', sans-serif;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        border-top: 1px solid #ccc;
        border-bottom: 1px solid #ccc;
    }

    th, td {
        padding: 10px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    th {
        width: 15%;
        background-color: #f9f9f9;
        font-weight: normal;
        vertical-align: top;
    }

    th .required {
        color: #ff0000;
        margin-left: 3px;
    }

    input[type="text"], textarea {
        width: 100%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 2px;
    }

    textarea {
        min-height: 150px;
        resize: vertical;
    }

    .checkboxArea {
        display: flex;
        align-items: center;
    }

    .date {
        background-color: #f9f9f9;
        border: 1px solid #ddd;
        padding: 8px;
        border-radius: 2px;
    }

    .buttonArea {
        margin-top: 15px;
        text-align: center;
    }

    .saveBtn, .canBtn {
        padding: 6px 20px;
        margin: 0 3px;
        border: 1px solid #ccc;
        border-radius: 2px;
        cursor: pointer;
    }

    .saveBtn {
        background-color: #0099cc;
        color: white;
        border: 1px solid #0088bb;
    }

    .canBtn {
        background-color: white;
        color: #333;
    }
    /* 파일 첨부 관련 스타일 */
    .fileUpload {
        padding: 10px 0;
    }

    .file-upload-button {
        display: inline-block;
        padding: 6px 12px;
        background-color: #f0f0f0;
        border: 1px solid #ccc;
        border-radius: 3px;
        cursor: pointer;
        margin-right: 10px;
    }
    #searchOption{
        width: 120px;
        height: 30px;
        border-radius: 5px;
    }
</style>
<div class="content">
</div>
<form action="${action == null ?  '/board/insert' : action}" method="post" enctype="multipart/form-data">
<table>
    <tr>
        <th>등록일</th>
        <td>
            <div class="date"></div>
        </td>
    </tr>
    <tr>
        <th>제목 <span class="required">*</span></th>
        <td colspan="3">
            <input type="text" name="title">
        </td>
    </tr>
    <tr>
        <th>이름 <span class="required"></span></th>
        <td colspan="3">
           <div class="name">${action == null ? employee.name : '관리자'}</div>
        </td>
    </tr>
    <tr>
        <th>첨부파일</th>
        <td colspan="3">
            <jsp:include page="/WEB-INF/views/template/fileInput.jsp"/>
        </td>
    </tr>
    <tr>
        <th>내용 <span class="required">*</span></th>
        <td colspan="3">
            <input type="text" id="content" name="content">
        </td>
    </tr>
</table>
<div class="button-area">
    <button class="saveBtn">저장</button>
    <a href="${action == null ? 'board/list' : '/notice/list?page=1'}">
        <button type="button" class="canBtn">취소</button>
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
