<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="vacationModal" class="modal">
    <div class="modal-content surface-bright">
        <div class="modal-header">
            <h2>휴가 사용 현황</h2>
            <span class="material-icons">close</span>
        </div>
        <div class="modal-body">
            <div class="vacation-history">
                <table class="board-table">
                    <thead>
                    <tr>
                        <th>일자</th>
                        <th>구분</th>
                        <th>사용일수</th>
                        <th>사유</th>
                        <th>상태</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${vacationList}" var="item">
                        <tr>
                            <td>${item.startDate} ~ ${item.endDate}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${item.type.equals('ANNUAL')}">연차</c:when>
                                    <c:when test="${item.type.equlas('HALF')}">반차</c:when>
                                    <c:otherwise>병가</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                    ${(item.vacationDate == null) ? 0 : item.vacationDate}일
                            </td>
                            <td>
                                ${item.reason}
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${item.submitYn.equals('Y')}">승인</c:when>
                                    <c:otherwise>대기</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>