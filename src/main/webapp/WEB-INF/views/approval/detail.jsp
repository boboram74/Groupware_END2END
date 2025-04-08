<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/css/approval/draft.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>

<div class="container">
    <table>
        <th>기 안 문</th>
    </table>
    <hr>

    <div class="header">
        <div class="informBox">
            <div class="employeeNameBox">
                <div class="employee">작성자</div>
                <div id="name">${approval.NAME}</div>
            </div>
            <div class="sysdateBox">
                <div class="sysdate">기안 일자</div>
                <div class="date">${approval.REGDATE}</div>
            </div>
            <div class="positionsBox">
                <div class="employeePosition">직위</div>
                <div id="positions">${approval.JOBNAME}</div>
            </div>
        </div>

        <div class="approvalBox">
            <div class="approverCardContainer">
                <c:forEach var="approver" items="${approvers}">
                    <div class="approverCard">
                        <div class="approverInfo">
                            <div>${approver["ORDERS"]}</div>
                            <div>${approver["NAME"]}</div>
                            <div>${approver["JOBNAME"]}</div>
                            <div>
                                <span class="approverStatus" id="approverStatus${approver['ID']} ${approver["SUBMITYN"] eq 'Y' ? 'done' : 'N'}">
                                    <c:choose>
                                        <c:when test="${approver['SUBMITYN'] eq 'Y'}">승인</c:when>
                                        <c:otherwise>대기</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <c:if test="${approver['SUBMITDATE'] != null}">
                                <div>${approver["SUBMITDATE"]}</div>
                            </c:if>
                        </div>

                        <c:if test="${approver['EMPLOYEEID'] eq employee.id and (empty approver['SUBMITYN'] or approver['SUBMITYN'] eq 'N')}">
                            <form action="/approval/submit/approve/${approval.ID}" method="post" style="display:inline;">
                                <input type="hidden" name="approvalId" value="${approval.ID}" />
                                <input type="hidden" name="approverId" value="${approver['ID']}" />
                                <button type="submit" class="approveBtn">승인</button>
                            </form>
                            <form action="/approval/reject" method="post" style="display:inline;">
                                <input type="hidden" name="approvalId" value="${approval.ID}" />
                                <input type="hidden" name="approverId" value="${approver['ID']}" />
                                <button type="submit" class="rejectBtn">반려</button>
                            </form>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <div class="body">
        <div class="titleBox">
            <input type="text" id="title" name="title" value="${approval.TITLE}" readonly>
        </div>
        <div class="contentsBox">
            <textarea readonly>${approval.CONTENT}</textarea>
        </div>
    </div>

    <div class="signInform">
        <button><a href="/approval/list">목록으로</a></button>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>

<script>
    $(document).ready(function() {
        $('.approveBtn').click(function(e) {
            e.preventDefault();

            const approvalId = $(this).siblings('input[name="approvalId"]').val();
            const approverId = $(this).siblings('input[name="approverId"]').val();

            $.ajax({
                url: '/approval/submit/approve/' + approvalId,
                type: 'POST',
                data: {
                    approvalId: approvalId,
                    approverId: approverId
                },
                success: function(response) {
                    if (response.status === "success") {
                        $('#approverStatus' + approverId).text('승인');
                        $('#approverStatus' + approverId).removeClass('N').addClass('done');
                    } else {
                        alert("승인 처리에 실패했습니다.");
                    }
                },
                error: function() {
                    alert('승인 처리에 실패했습니다.');
                }
            });
        });
    });
    $(document).ready(function() {
        $('.rejectBtn').click(function(e) {
            e.preventDefault();

            var approvalId = $(this).siblings('input[name="approvalId"]').val();
            var approverId = $(this).siblings('input[name="approverId"]').val();

            $.ajax({
                url: '/approval/reject',
                type: 'POST',
                data: {
                    approvalId: approvalId,
                    approverId: approverId
                },
                success: function(response) {
                    $('#approverStatus' + approverId).text('반려');
                    $('#approverStatus' + approverId).removeClass('N').addClass('rejected');
                },
                error: function() {
                    alert('반려 처리에 실패했습니다.');
                }
            });
        });
    });
</script>
