<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/css/color/newColor.css" />
<input type="hidden" name="approvalFormId" value="4" />
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
                <th>연장근무 시간 선택</th>
                <td colspan="3">
                    <div class="nightWork" id="currentDateTime">
                        <div class="timeSelection">
                            <div class="timeGroup">
                                <label for="workDate">근무 날짜</label>
                                <input type="date" id="workDate" name="workDate">
                            </div>
                            <div class="timeGroup">
                                <label for="startTime">시작 시간</label>
                                <select id="startTime" name="startTime">
                                    <option value="">선택</option>
                                    <option value="18:00">18:00</option>
                                    <option value="18:30">18:30</option>
                                    <option value="19:00">19:00</option>
                                    <option value="19:30">19:30</option>
                                    <option value="20:00">20:00</option>
                                    <option value="20:30">20:30</option>
                                    <option value="21:00">21:00</option>
                                </select>
                            </div>
                            <div class="timeGroup">
                                <label for="endTime">종료 시간</label>
                                <select id="endTime" name="endTime">
                                    <option value="">선택</option>
                                    <option value="19:00">19:00</option>
                                    <option value="19:30">19:30</option>
                                    <option value="20:00">20:00</option>
                                    <option value="20:30">20:30</option>
                                    <option value="21:00">21:00</option>
                                    <option value="21:30">21:30</option>
                                    <option value="22:00">22:00</option>
                                    <option value="22:30">22:30</option>
                                    <option value="23:00">23:00</option>
                                </select>
                            </div>
                        </div>
                        <div class="totalHours" id="totalHours">총 연장근무 시간: 0시간</div>
                    </div>

                </td>
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
<script>
    $(document).ready(function () {

        function calculateHours() {
            const startTime = $('#startTime').val();
            const endTime = $('#endTime').val();
            if (startTime && endTime) {
                const start = Date.parse('2000-01-01T' + startTime + ':00');
                const end = Date.parse('2000-01-01T' + endTime + ':00');

                if (!isNaN(start) && !isNaN(end)) {
                    if (end > start) {
                        const diff = (end - start) / (1000 * 60 * 60);
                        const hours = diff.toFixed(1);

                        $('#totalHours').text('총 연장근무 시간: ' + hours + '시간');

                        $('input[name="overtimeHours"]').remove();
                        $('<input>', {
                            type: 'hidden',
                            name: 'overtimeHours',
                            value: hours
                        }).insertAfter('#totalHours');
                    } else {
                        $('#totalHours').text('종료 시간은 시작 시간보다 나중이어야 합니다.');
                    }
                } else {
                    $('#totalHours').text('시간 정보를 제대로 불러오지 못했습니다.');
                }
            }
        }


        $('#startTime, #endTime').on('change', calculateHours);
    });
</script>