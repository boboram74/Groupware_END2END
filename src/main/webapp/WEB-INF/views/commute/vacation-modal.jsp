<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="vacationModal" class="modal">
    <div class="modal-content surface-bright">
        <div class="modal-header">
            <h2>휴가 사용 현황</h2>
            <span class="close">&times;</span>
        </div>
        <div class="modal-body">
            <div class="vacation-history">
                <table class="board-table">
                    <thead>
                    <tr>
                        <th>일자</th>
                        <th>구분</th>
                        <th>사용일수</th>
                        <th>상태</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach begin="1" end="10" varStatus="status">
                        <tr>
                            <td>2024-0${status.index}-01</td>
                            <td>
                                <c:choose>
                                    <c:when test="${status.index % 3 == 0}">연차</c:when>
                                    <c:when test="${status.index % 3 == 1}">반차</c:when>
                                    <c:otherwise>병가</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${status.index % 3 == 1}">0.5일</c:when>
                                    <c:otherwise>1일</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${status.index % 2 == 0}">승인</c:when>
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
</div>