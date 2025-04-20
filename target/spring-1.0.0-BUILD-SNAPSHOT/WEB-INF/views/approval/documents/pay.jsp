<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/css/color/newColor.css" />
<input type="hidden" name="approvalFormId" value="1" />
<div class="approval-document surface-bright">
    <div class="document-header">
        <h1 class="document-title">지출 결의서</h1>
        <div class="approval-section">
            <!-- 결재란 테이블 -->
            <table class="approval-table">
                <tr id="approval-table-header">
                    <th>기안</th>

                </tr>
                <tr class="sign-rows" id="lineBox">
                    <td class="sign-cell">
                        <div class="position">${employee.jobName}</div>
                        <div class="name">${employee.name}</div>
                        <div class="date"></div>
                        <input type="hidden" name="employeeId" value="${employee.id}" />
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
        <div class="attachment-section file-input-section">
            <h3>첨부파일</h3>
            <jsp:include page="/WEB-INF/views/template/fileInput.jsp" />
        </div>

        <div class="button-group">
            <button type="submit" id="signOk" class="submit-btn primary">상신하기</button>
            <button type="button" onclick="location.href='/approval/list'" class="cancel-btn secondary">취소</button>
        </div>
    </div>
</div>