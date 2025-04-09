<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/css/approval/draft.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<style>
    .modal {
        position: fixed;
        z-index: 1000;
        left: 0; top: 0;
        width: 100%; height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
    }
    .modalContent {
        background: #fff;
        padding: 20px;
        margin: 10% auto;
        width: 400px;
        border-radius: 10px;
    }
    .modalContent textarea {
        width: 100%;
        height: 100px;
        margin-bottom: 10px;
    }
    .modalActions {
        text-align: right;
    }
    .modalActions button {
        margin-left: 10px;
    }
</style>
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
    <div id="rejectModal" class="modal" style="display: none;">
        <div class="modalContent">
            <h3>반려 사유 입력</h3>
            <textarea id="rejectReason" placeholder="반려 사유를 입력해주세요."></textarea>
            <input type="hidden" id="modalApprovalId">
            <input type="hidden" id="modalApproverId">
            <div class="modalActions">
                <button id="confirmRejectBtn">반려</button>
                <button id="cancelRejectBtn">취소</button>
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
                url: '/approval/reject',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    approvalId: approvalId,
                    approverId: approverId,
                    reason: reason
                }),
                success: function(response) {
                    if (response === "success") {
                        $('#approverStatus' + approverId).text('승인');
                        $('#approverStatus' + approverId).removeClass('N').addClass('done');
                        location.reload();
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
            const approvalId = $(this).siblings('input[name="approvalId"]').val();
            const approverId = $(this).siblings('input[name="approverId"]').val();

            $('#modalApprovalId').val(approvalId);
            $('#modalApproverId').val(approverId);
            $('#rejectReason').val('');
            $('#rejectModal').show();
        });

        $('#cancelRejectBtn').click(function() {
            $('#rejectModal').hide();
        });

        $('#confirmRejectBtn').click(function() {
            const approvalId = $('#modalApprovalId').val();
            const approverId = $('#modalApproverId').val();
            const reason = $('#rejectReason').val();

            if (!reason.trim()) {
                alert("반려 사유를 입력해주세요.");
                return;
            }

            $.ajax({
                url: '/approval/reject',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    approvalId: approvalId,
                    approverId: approverId,
                    reason: reason
                }),
                success: function(response) {
                    $('#rejectModal').hide();
                    $('#approverStatus' + approverId).text('반려');
                    $('#approverStatus' + approverId).removeClass('N').addClass('rejected');
                    location.reload();
                },
                error: function(xhr, status, error) {
                    alert('반려 처리에 실패했습니다.');
                    console.error("에러 상태:", status);
                    console.error("에러 메시지:", error);
                    console.error("응답 본문:", xhr.responseText);
                }
            });
        });
    });
</script>
