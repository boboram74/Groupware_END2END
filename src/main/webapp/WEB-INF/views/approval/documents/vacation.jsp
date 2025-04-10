<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input type="hidden" name="approvalFormId" value="2" />
<div class="container">
    <table>
        <th>
            휴 가 계
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
                <div class="date"></div>
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
                    <div class="date"></div>
                    <input type="hidden" name="approverId" value="${employee.id}" />
                </div>
            </div>
            <div class="addBox">
                <button type="button" id="add">결재선 추가</button>
            </div>
        </div>
    </div>

    <div class="body">
        <div class="vacationKind">
            <input type="radio" name="type" value="1" />
            <label>연차</label>
            <input type="radio" name="type" value="2" />
            <label>병가</label>
            <input type="radio" name="type" value="3" />
            <label>반차</label>
            <input type="radio" name="type" value="4" />
            <label>조퇴</label>
        </div>
        <input type="text">
        <div class="titleBox">
            <input type="text" id="title" name="title">
        </div>
        <div class="contentsBox">
            <textarea id="contents"></textarea>
        </div>
        <div class="signInform" id="signButtons">
            <input type="file" name="files">
            <button id="signOk">제출</button>
            <button type="button" onclick="location.href='/approval/list'">취소</button>
        </div>
    </div>
</div>