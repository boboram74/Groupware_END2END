<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


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
                <div id="name">${approval.employeeId}</div>
            </div>
            <div class="sysdateBox">
                <div class="sysdate">기안 일자</div>
                <div class="date">${approval.regDate}</div>
            </div>
            <div class="positionsBox">
                <div class="employeePosition">직위</div>

                <%--   <div id="positions">${approval.jobName}</div>--%>
            </div>
        </div>

        <div class="approvalBox">
            <div class="lineBox" id="lineBox">

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
            <c:forEach var="nextId" items="${nextId}">
                <c:if test="${nextId eq employee.id}">
                    <input type="file" name="files">
                    <form action="/approval/approve" method="post" style="display:inline;">
                        <input type="hidden" name="approvalId" value="${approval.id}"/>
                        <button type="submit" id="signOk">승인</button>
                    </form>
                    <form action="/approval/reject" method="post" style="display:inline;">
                        <input type="hidden" name="approvalId" value="${approval.id}"/>
                        <button type="submit" class="cancle">반려</button>
                    </form>
                </c:if>
            </c:forEach>
        </div>
    </div>
    <button><a href="/approval/list">목록으로</a></button>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
