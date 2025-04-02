<!DOCTYPE html>
<html lang="en">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
    <link rel="stylesheet" href="/css/approval/draft.css">
    <script src="/js/summernote/summernote-lite.js"></script>
    <script src="/js/summernote/lang/summernote-ko-KR.js"></script>
    <link rel="stylesheet" href="/js/summernote/summernote-lite.css">
    <title>Document</title>

</head>

<body>

<div class="overlay"></div>
<div class="modalContainer">
    <div class="approvalModalSelect">
        <div>
            <h3>사원 목록</h3>
            <div id="employees">
                <div id="departments1">
                    <label for="selector">부서 목록</label>
                    <select id="selector" onchange="employees(this.value)">
                        <option>부서명</option>
                        <option value="1">인사</option>
                        <option value="2">경영</option>
                        <option value="3">공무</option>
                    </select>
                </div>
                <div ondrop="drop(e)" ondragover="allowDrop(e)"></div>
            </div>

        </div>

        <div>
            <h3>결재선</h3>
            <div id="approvalLine" ondrop="drop(e)" ondragover="allowDrop(e)"></div>
        </div>
    </div>
    <div>
        <button id="addApproval">추가</button>
        <button id="closeModal">닫기</button>
    </div>
</div>


<form action="/approval/insert">
    <div class="container">
        <table>
            <th>
                기 안 문
            </th>
        </table>
        <hr>
        <div class="header">
            <div class="informBox">
                <div class="employeeNameBox">
                    <div class="employee">작성자</div>
                    <div id="name">임근한</div>
                </div>
                <div class="sysdateBox">
                    <div class="sysdate">기안 일자</div>
                    <div id="date">오늘</div>
                </div>
                <div class="positionsBox">
                    <div class="employeePosition">직위</div>
                    <div id="positions">인턴</div>
                </div>
            </div>

            <div class="approvalBox">
                <div class="lineBox">
                    <div class="line">
                        <div class="linePositions">인턴</div>
                        <div class="lineEmployeeName">임근한</div>
                        <div class="signDate">2025.03.28</div>
                    </div>
                    <input type="hidden" name="approver" value="1231231">
                </div>
                <div class="addBox">
                    <button type="button" id="add">결재선 추가</button>
                </div>
            </div>
        </div>
        <div class="body">
            <div class="titleBox">
                <input type="text" id="title" name="title">
            </div>
            <div class="contentsBox">
                <textarea id="contents" name="contents"></textarea>
            </div>
            <div class="signInform" id="signButtons">
                <input type="file" name="files">
                <button id="signOk">제출</button>
                <button type="button" onclick="location.href='/approval/list'">취소</button>
            </div>
        </div>
    </div>
</form>
<script src="/js/template/summernote.js" type="text/javascript"></script>
<script>

    $('#add').on('click', function () {
        $('.modalContainer').fadeIn();
        $('.overlay').fadeIn();
    });

    $('#closeModal').on('click', function () {
        $('.modalContainer').fadeOut();
        $('.overlay').fadeOut();
    });


    $('#contents').summernote({
        height: 300,
        lang: 'ko-KR'
    });


    function allowDrop(e) {
        e.preventDefault();
    }

    function drag(e) {
        e.dataTransfer.setData("text", e.target.textContent);
    }

    function drop(e) {
        e.preventDefault();
        let data = e.dataTransfer.getData("text");
        let div = document.createElement("div");
        div.className = "employee";
        div.textContent = data;
        div.draggable = true;
        div.ondragstart = drag;
        e.target.appendChild(div);
    }

    function employees(departmentId) {
        $.ajax({
            url: '/approval/employeeList',
            type: 'GET',
            dataType: 'json',
            data: { departmentId: departmentId },
            success: function(response) {
                let employeesHtml = '';
                if (response.length === 0) {
                    employeesHtml = "<p>해당 부서에 사원이 없습니다.</p>";
                } else {
                    response.forEach(function(employee) {
                        employeesHtml += `
                            <div class="employee" draggable="true" ondragstart="drag(event)" data-name="${employee.name}">
                                <span class="employee-name">${employee.name}</span> -
                            </div>
                        `;
                    });
                }
                $('#employeeList').html(employeesHtml);
            }
        });
    }




</script>

</body>

</html>