<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .body {
        margin-top: 20px;
    }
    .nightWork {

        border: 1px solid #ddd;
        border-radius: 6px;
        padding: 15px;
        background-color: #f9f9f9;
    }
    .nightWork h3 {
        margin-top: 0;
        margin-bottom: 15px;
        color: #333;
        font-size: 16px;
        border-bottom: 1px solid #ddd;
        padding-bottom: 10px;
    }
    .timeSelection {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        justify-content: space-between;
    }
    .timeGroup {
        display: flex;
        flex-direction: column;
        gap: 5px;
    }
    .timeGroup label {
        font-weight: bold;
        font-size: 14px;
        color: #555;
    }
    .timeGroup select, .timeGroup input {
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        width: 140px;
    }
    .totalHours {
        margin-top: 15px;
        text-align: right;
        font-weight: bold;
        color: #e74c3c;
    }
</style>
<body>
<input type="hidden" name="approvalFormId" value="4" />
<div class="container" type="overtime">
    <table>
        <th>
            연장근무 신청서
        </th>
    </table>
    <hr>
    <div class="header">
        <div class="informBox">
            <div class="employeeNameBox">
                <div class="employee">작성자</div>
                <div id="name">${employee.name}</div>
            </div>
            <div class="sysdateBox">
                <div class="sysdate">기안 일자</div>
                <div class="date" id="currentDate"></div>
            </div>
            <div class="positionsBox">
                <div class="employeePosition">직위</div>
                <div id="positions">${employee.jobName}</div>
            </div>
        </div>

        <div class="approvalBox">
            <div class="lineBox" id="lineBox">
                <div class="line">
                    <div class="linePositions">${employee.jobName}</div>
                    <div class="lineEmployeeName">${employee.name}</div>
                    <div class="date" id="approvalDate"></div>
                    <input type="hidden" name="approverId" value="${employee.id}" />
                </div>
            </div>
            <div class="addBox">
                <button type="button" id="add">결재선 추가</button>
            </div>
        </div>
    </div>

    <div class="body">
        <div class="nightWork" id="currentDateTime">
            <h3>연장근무 시간 선택</h3>
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

        <div class="titleBox">
            <input type="text" id="title" name="title" placeholder="제목을 입력하세요">
        </div>
        <div class="contentsBox">
            <textarea id="contents" name="contents" placeholder="연장근무 사유와 세부사항을 입력하세요"></textarea>
        </div>
        <div class="signInform" id="signButtons">
            <div class="fileUpload">
                <input type="file" id="fileInput" name="attachment">
            </div>
            <button id="signOk">제출</button>
            <button type="button" onclick="location.href='/approval/list'">취소</button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {

        function calculateHours() {
            const startTime = $('#startTime').val();
            const endTime = $('#endTime').val();

            if (startTime && endTime) {
                const start = new Date("2000-01-01T" + startTime + ":00");
                let end = new Date("2000-01-01T" + endTime + ":00");

                if (end <= start) {
                    end.setDate(end.getDate() + 1);
                }

                const diff = (end - start) / (1000 * 60 * 60);
                $('#totalHours').text("총 연장근무 시간: " + diff.toFixed(1) + "시간");

                $('input[name="overtimeHours"]').remove();
                $('<input>', {
                    type: 'hidden',
                    name: 'overtimeHours',
                    value: diff.toFixed(1)
                }).insertAfter('#totalHours');
            }
        }

        $('#startTime, #endTime').on('change', calculateHours);
    });
</script>