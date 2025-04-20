<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%-- 날짜 포맷 태그 추가 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<link rel="stylesheet" href="/css/template/exam.css"/>
<link rel="stylesheet" href="/css/approval/draft.css"/>
<link rel="stylesheet" href="/css/approval/list.css">
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

    .vacationTable {
        width: 100%;
        border-collapse: collapse;
    }
    .vacationTable th, .vacationTable td {
        border: 1px solid #ccc;
        padding: 8px 12px;
    }
    .vacationTable th {
        background-color: #f0f0f0;
        text-align: left;
    }
    .fileBox{
        border: 1px solid black;
    }

    .approval-content {
        height: 500px;
        overflow: auto;
        vertical-align: top;
        padding: 15px;
    }
</style>
<div class="mainHeader surface-bright">
    <div class="detail-menu-header">
        <div class="detail-menu-title">
            <span class="material-icons">description</span>
            <span>전자 결재</span>
        </div>
        <button class="detail-menu-toggle-btn">
            <span class="material-icons">menu</span>
        </button>
    </div>
    <div class="detail-menu-modal">
        <ul class="detail-menu-list">
            <li class="detail-menu-item" onclick="location.href='/approval/list'">
                <span class="material-icons">person</span>
                <span>나의 전자결재</span>
            </li>
            <li class="detail-menu-item" onclick="location.href='/approval/important'">
                <span class="material-icons">star</span>
                <span>중요 문서함</span>
                <span class="detail-badge"><span>${importantSize != null ? importantSize : 0}</span></span>
            </li>
            <c:if test="${team}">
                <li class="detail-menu-item" onclick="location.href='/approval/all'">
                    <span class="material-icons">description</span>
                    <span class="detail-menu-disc">모든 전자 결재함</span>
                    <span class="detail-badge"><span>${totalSize != null ? totalSize : 0}</span></span>
                </li>
            </c:if>
        </ul>
        <button class="detail-modal-close">
            <span class="material-icons">close</span>
        </button>
    </div>
</div>
<div class="container">
    <div class="approval-document surface-bright">
        <div class="document-header">
            <h1 class="document-title">${approvalFormDTO.name}</h1>
            <div class="approval-section">
                <!-- 결재란 테이블 -->
                <table class="approval-table">
                    <tr id="approval-table-header">
                        <th>기안</th>
                        <c:forEach begin="2" end="${fn:length(approvers)}" var="i">
                            <th>결재</th>
                        </c:forEach>
                    </tr>
                    <tr class="sign-rows" id="lineBox">
                        <c:forEach var="approver" items="${approvers}">
                            <td class="sign-cell">
                                <div class="position">${approver.JOBNAME}</div>
                                <div class="name">${approver.NAME}</div>
                                <div>
                                <span class="approverStatus" id="approverStatus${approver['ID']} ${approver["SUBMITYN"] eq 'Y' ? 'done' : 'N'}">
                                    <c:choose>
                                        <c:when test="${approver['SUBMITYN'] eq 'Y'}">승인</c:when>
                                        <c:otherwise>반려</c:otherwise>
                                    </c:choose>
                                </span>
                                </div>
                                <c:if test="${approver['SUBMITDATE'] != null}">
                                    <div class="date">${approver["SUBMITDATE"]}</div>
                                </c:if>

                                <c:if test="${approver['EMPLOYEEID'] eq employee.id and (empty approver['SUBMITYN'])}">
                                    <form action="/approval/submit/approve/${approval.ID}" method="post" style="display:inline;">
                                        <input type="hidden" name="approvalId" value="${approval.ID}" />
                                        <input type="hidden" name="approverId" value="${approver['ID']}" />
                                        <button type="submit" class="approveBtn">승인</button>
                                    </form>
                                    <form action="/approval/reject" method="post" style="display:inline;">
                                        <input type="hidden" name="approvalId" value="${approval.ID}" />
                                        <input type="hidden" name="approverId" value="${approver['ID']}" />
                                        <button type="button" class="rejectBtn">반려</button>
                                    </form>
                                </c:if>
                            </td>
                        </c:forEach>
                    </tr>
                </table>
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


        <div class="document-info">
            <table class="info-table">
                <tr>
                    <th>제목</th>
                    <td colspan="3">${approval.TITLE}</td>
                </tr>
                <tr>
                    <th>기안부서</th>
                    <td>${approval.DEPARTMENTNAME}</td>
                    <th>기안자</th>
                    <td>${employee.name}</td>
                </tr>
                <tr>
                    <th>기안일자</th>
                    <td colspan="3"><span class="date">${approval.REGDATE}</span></td>
                </tr>
                <tr>
                    <c:if test="${approvalFormDTO.name eq '휴가계'}">
                        <th>휴가 정보</th>
                        <td colspan="3">
                            <table class="vacationTable">
                                <tr>
                                    <th>휴가 유형</th>
                                    <td>
                                        <c:choose>
                                            <c:when test="${vacationDTO.type eq 'ANNUAL'}">
                                                연차
                                            </c:when>
                                            <c:otherwise>
                                                반차
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <th>시작일</th>
                                    <td>
                                        <c:choose>
                                            <c:when test="${vacationDTO.type eq 'ANNUAL'}">
                                                <fmt:formatDate value="${vacationDTO.startDate}" pattern="yyyy/MM/dd"/>
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatDate value="${vacationDTO.startDate}" pattern="yyyy/MM/dd HH:mm:ss"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <th>종료일</th>
                                    <td>
                                        <c:choose>
                                            <c:when test="${vacationDTO.type eq 'ANNUAL'}">
                                                <fmt:formatDate value="${vacationDTO.endDate}" pattern="yyyy/MM/dd"/>
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatDate value="${vacationDTO.endDate}" pattern="yyyy/MM/dd HH:mm:ss"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <th>총 휴가 일수</th>
                                    <td>${vacationDTO.vacationDate}일</td>
                                </tr>
                            </table>
                        </td>
                    </c:if>
                    <c:if test="${approvalFormDTO.name eq '연장근무신청서'}">
                        <th>근무 시간</th>
                        <td colspan="3">
                            <table class="vacationTable">
                                <tr>
                                    <th>신청일</th>
                                    <td><fmt:formatDate value="${extendedCommuteDTO.workOffTime}" pattern="yyyy/MM/dd"/></td>
                                </tr>
                                <tr>
                                    <th>종료일</th>
                                    <td><fmt:formatDate value="${extendedCommuteDTO.workOffTime}" pattern="HH:mm:ss"/></td>
                                </tr>
                            </table>
                        </td>
                    </c:if>
                </tr>
                <tr>
                    <td colspan="4" class="approval-content" style="min-height: 500px;">${approval.CONTENT}</td>
                </tr>
            </table>
        </div>

        <div class="document-footer">
            <div class="attachment-section file-input-section">
                <h3>첨부파일</h3>
                <ul style="list-style: none; padding: 0; margin: 0;">
                    <c:forEach var="file" items="${fileList}">
                        <li>
                            <a href="/file/download?path=${file.path}">${file.originFileName}</a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="button-container">
            <button onclick="location.href='/approval/list'" class="secondary">목록으로</button>
        </div>
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
</html>