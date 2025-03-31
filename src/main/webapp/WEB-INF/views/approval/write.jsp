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
                    <div id="linePositions">인턴</div>
                    <div id="lineEmployeeName">임근한</div>
                    <div id="signDate">2025.03.28</div>
                </div>
            </div>
            <div class="addBox">
                <button id="add">결재선 추가</button>
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
        <div class="signImform" id="signButtons">
            <button id="signOk">제출</button>
            <button id="signCancle">취소</button>
        </div>
    </div>
</div>
<script src="/js/template/summernote.js" type="text/javascript"></script>
<script>
    $('#add').on('click', function () {
        window.open('addApproval.html', '_blank', 'width=600,height=400');
    });

    $('#contents').summernote(summernoteSetting());

</script>

</body>

</html>