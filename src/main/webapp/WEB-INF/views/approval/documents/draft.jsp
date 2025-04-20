<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/css/color/newColor.css" />
<input type="hidden" name="approvalFormId" value="1" />
<div class="approval-document">
    <div class="document-header">
        <h1 class="document-title">기 안 문</h1>
        <div class="approval-section">
            <!-- 결재란 테이블 -->
            <table class="approval-table">
                <tr>
                    <th>기안</th>
                    <th>결재</th>
                    <th>결재</th>
                    <th>결재</th>
                </tr>
                <tr class="sign-rows">
                    <td class="sign-cell">
                        <div class="position">${employee.jobName}</div>
                        <div class="name">${employee.name}</div>
                        <div class="date"></div>
                    </td>
                    <td class="sign-cell">
                        <div class="position">차장</div>
                        <div class="name">김차장</div>
                        <div class="date">2024-01-22</div>
                    </td>
                    <td class="sign-cell">
                        <div class="position">부장</div>
                        <div class="name">이부장</div>
                        <div class="date">2024-01-22</div>
                    </td>
                    <td class="sign-cell">
                        <div class="position">이사</div>
                        <div class="name">박이사</div>
                        <div class="date">2024-01-22</div>
                    </td>
                </tr>
            </table>
            <button type="button" id="add" class="add-approval primary">결재선 추가</button>
        </div>
    </div>

    <div class="document-info">
        <table class="info-table">
            <tr>
                <th>제목</th>
                <td colspan="3">
                    <input type="text" id="title" name="title" class="doc-title">
                </td>
            </tr>
            <tr>
                <th>기안부서</th>
                <td>${employee.departmentName}</td>
                <th>기안자</th>
                <td>${employee.name}</td>
            </tr>
            <tr>
                <th>기안일자</th>
                <td colspan="3"><span class="date"></span></td>
            </tr>
            <tr>
                <td colspan="4" style="padding: 0;">
                    <textarea id="contents"></textarea>
                </td>
            </tr>
        </table>
    </div>

    <div class="document-footer">
        <div class="attachment-section">
            <h3>첨부파일</h3>
            <jsp:include page="/WEB-INF/views/template/fileInput.jsp" />
        </div>

        <div class="button-group">
            <button type="submit" id="signOk" class="submit-btn primary">상신하기</button>
            <button type="button" onclick="location.href='/approval/list'" class="cancel-btn secondary">취소</button>
        </div>
    </div>
</div>

<style>
    .approval-document {
        width: 800px;
        margin: 20px auto;
        padding: 30px;
        background: #fff;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    .document-header {
        text-align: center;
        margin-bottom: 30px;
    }

    .document-title {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 20px;
        text-align: center;
    }

    .add-approval {
        display: block;  /* 블록 레벨 요소로 변경 */
        float: right;    /* 오른쪽 정렬 */
        padding: 4px 8px;
        font-size: 11px;
        border: 1px solid #dee2e6;
        border-radius: 4px;
        cursor: pointer;
        width: 100px;
    }

    .approval-section {
        margin-bottom: 20px;
        float: right;
        display: flex;
        flex-direction: column;
    }

    .approval-table {
        float: right;
        border-collapse: collapse;
        margin-bottom: 10px;
    }

    .approval-table th {
        width: 120px;  /* th 너비를 120px로 설정 */
        border: 1px solid #000;
        padding: 4px;
        text-align: center;
        font-size: 11px;
    }

    .approval-table td {
        border: 1px solid #000;
        padding: 4px;
        text-align: center;
        font-size: 15px;
        height: 80px;
    }

    .sign-cell {
        min-width: 120px;
    }

    .info-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 30px;
    }

    .info-table th {
        background-color: #f5f5f5;
        width: 100px;
    }

    .info-table th, .info-table td {
        border: 1px solid #000;
        padding: 8px;
    }

    .doc-title {
        width: 100%;
        padding: 5px;
        border: none;
    }

    .content-body {
        min-height: 400px;
        border: 1px solid #000;
        padding: 20px;
        margin-bottom: 30px;
    }

    .button-group {
        text-align: center;
        margin-top: 20px;
    }

    .submit-btn, .cancel-btn {
        padding: 8px 20px;
        margin: 0 5px;
        cursor: pointer;
    }

    .attachment-section {
        margin: 20px 0;
        padding: 10px;
        background-color: #f5f5f5;
    }

    .position {
        font-size: 15px;
        margin-bottom: 15px;
    }

    .name {
        font-size: 20px;
        margin-bottom: 10px;
    }

    .add-approval {
        padding: 5px 10px;
        margin-top: 10px;
        float: right;
    }
</style>
<style>
    #employees
    {
        width: 200px;
        min-height: 300px;
        border: 1px solid #ccc;
        padding: 10px;
        overflow-y: auto;
        background-color: #fff;
    }
    #approvalLine{
        flex-direction: row;
        width: 200px;
        min-height: 300px;
        gap: 10px;
        padding: 10px;
        border: 1px solid black;
    }

    h3 {
        margin-top: 0;
        font-size: 16px;
    }

    select {
        width: 100%;
        padding: 5px;
        margin-bottom: 10px;
    }

    .employee {
        padding: 5px;
        margin: 5px 0;
        background-color: #f0f0f0;
        cursor: grab;
        border-radius: 4px;
        user-select: none;
    }

    .modalContainer {
        display: none;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        z-index: 1000;
    }


    .overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.3);
        z-index: 999;
    }


    .employee {
        padding: 5px 10px;
        margin: 5px;
        background: #f4f4f4;
        cursor: grab;
        border-radius: 5px;
    }


    .approvalModalSelect {
        display: flex;
        padding: 10px;
        width: 500px;
        justify-content: space-between;
    }

    #departments {
        margin-left: 10px;
        height: fit-content;
    }
    .approverCardContainer {
        display: flex;
        gap: 10px;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 8px;
        background: #f9f9f9;
        align-items: flex-end; /* 추가: 컨테이너 내 항목들을 오른쪽 정렬 */
    }

    .approverCard {
        justify-content: space-between;
        align-items: center;
        border: 1px solid #ddd;
        border-radius: 6px;
        background-color: white;
        box-shadow: 1px 1px 3px rgba(0,0,0,0.05);
    }

    .approverInfo {
        flex-direction: column;
        flex: 1;
        text-align: right; /* 추가: 승인자 정보 텍스트 오른쪽 정렬 */
    }

    .approvalBox {
        float: right;
        width: 35%;
        height: 100%;
        display: flex; /* 추가: flex 컨테이너로 변경 */
        justify-content: flex-end; /* 추가: 내용을 오른쪽으로 정렬 */
    }

    .approverInfo div {
        margin-bottom: 2px;
    }

    .approverActions {
        display: flex;
        gap: 8px;
    }

    .approverStatus {
        font-weight: bold;
    }

    .approverStatus.waiting {
        color: #c0392b;
    }

    .approverStatus.done {
        color: #27ae60;
</style>