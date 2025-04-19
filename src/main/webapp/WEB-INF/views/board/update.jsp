<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/board/board-header.jsp"/>
<style>
    .form-container {
        width: 100%;
        max-width: 650px;
        margin: 0 auto;
        font-family: 'Noto Sans KR', sans-serif;
        border: 1px solid #dee2e6;
        border-radius: 4px;
        overflow: hidden;
    }

    /* 테이블 스타일 */
    .form-table {
        width: 100%;
        border-collapse: collapse;
    }

    /* 테이블 셀 공통 스타일 */
    .form-table th, .form-table td {
        padding: 12px 15px;
        border-bottom: 1px solid #dee2e6;
        border-right: 1px solid #dee2e6;
        vertical-align: top;
    }

    /* 헤더 셀 스타일 */
    .form-table th {
        width: 120px;
        background-color: #f8f9fa;
        text-align: right;
        font-weight: normal;
        color: #495057;
    }

    /* 필수 입력 표시 (*) */
    .required {
        color: #dc3545;
        margin-left: 2px;
    }

    /* 입력 필드 스타일 */
    .form-input {
        width: 100%;
        padding: 8px 12px;
        border: 1px solid #ced4da;
        border-radius: 4px;
        font-size: 14px;
        box-sizing: border-box;
    }

    /* 텍스트 영역 스타일 */
    .form-textarea {
        width: 100%;
        min-height: 120px;
        padding: 8px 12px;
        border: 1px solid #ced4da;
        border-radius: 4px;
        font-size: 14px;
        resize: vertical;
        box-sizing: border-box;
    }

    /* 체크박스 컨테이너 */
    .checkbox-container {
        display: flex;
        align-items: center;
    }

    /* 체크박스 스타일 */
    .form-checkbox {
        margin-right: 6px;
    }

    /* 버튼 컨테이너 */
    .button-container {
        display: flex;
        justify-content: center;
        padding: 15px 0;
        gap: 10px;
    }

    /* 기본 버튼 스타일 */
    .btn {
        padding: 8px 16px;
        border: none;
        border-radius: 4px;
        font-size: 14px;
        cursor: pointer;
    }

    /* 저장 버튼 */
    .btn-primary {
        background-color: #17a2b8;
        color: white;
    }

    /* 취소 버튼 */
    .btn-secondary {
        background-color: #f8f9fa;
        border: 1px solid #ced4da;
        color: #495057;
    }

    /* 날짜 스타일 */
    .date-field {
        color: #6c757d;
        font-size: 14px;
    }
</style>

<div class="search">
    <div>

    </div>

</div>
<div class="content">
</div>
<div class="form-container">
    <form action="/board/update" method="post">
    <table class="form-table">
        <tr>
            <th>등록일<span class="required"></span></th>
            <td><span class="date-field"></span>
                <div class="date">${board.regDate}</div>
            </td>

        </tr>
        <tr>
            <th>제목<span class="required"></span></th>
            <td colspan="3">
                <input type="text" class="form-input" name="title" value="${board.title}">
            </td>
        </tr>
        <tr>
            <th>이름<span class="required"></span></th>
            <td colspan="3">
                <input type="text" class="form-input" name="employeeName" value="${board.employeeName}" readonly>
            </td>
        </tr>
        <tr>
            <th>내용<span class="required"></span></th>
            <td colspan="3">
                <textarea class="form-textarea" name="content">${board.content}</textarea>
            </td>
        </tr>
        <input type="hidden" name="id" value="${board.id}">
    </table>
    <div class="button-container">
        <button class="btn btn-primary">수정</button>
        <button type="button" class="btn btn-secondary" onclick="location.href = '/board/detail/${board.id}'">취소</button>

    </div>
    </form>
</div>

<script src="/js/main/contact.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/board/board-footer.jsp"/>
