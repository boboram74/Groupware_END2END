<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/approval/draft.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>

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
                <div id="name">${approval.employeeName}</div>
            </div>
            <div class="sysdateBox">
                <div class="sysdate">기안 일자</div>
                <div class="date">${approval.regDate}</div>
            </div>
            <div class="positionsBox">
                <div class="employeePosition">직위</div>
                <div id="positions">${approval.jobName}</div>
            </div>
        </div>

        <div class="approvalBox">
            <div class="lineBox" id="lineBox">
                <c:forEach var="approver" items="${approvers}">
                    <div class="line">
                        <div class="linePositions">${approver.jobName}</div>
                        <div class="lineEmployeeName">${approver.employeeName}</div>
                        <div class="date"></div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <div class="body">
        <div class="titleBox">
            <input type="text" id="title" name="title" value="${approval.title}" readonly>
        </div>
        <div class="contentsBox">
            <textarea readonly>${approval.content}</textarea>
        </div>

        <div class="signInform" id="signButtons">
            <c:if test="${nextId}">
                <input type="file" name="files">
                <button id="signOk">승인</button>
                <button type="button" onclick="location.href='/approval/list'" class="cancle">반려</button>
            </c:if>
        </div>
    </div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
