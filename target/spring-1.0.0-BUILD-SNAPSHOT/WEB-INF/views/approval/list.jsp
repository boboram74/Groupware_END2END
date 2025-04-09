<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%-- 날짜 포맷 태그 추가 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/approval/list.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>

<div class="userInfo">
    <div class="userIcon"></div>
    <div class="userText">나의 전자결재</div>
</div>

<div class="apControls">
    <select class="apBtnNewDoc">
        <option value="">새 기안 쓰기</option>
        <option value="1">기안문</option>
        <option value="2">휴가계</option>
        <option value="3">지출결의서</option>
    </select>
    <button class="apBtnRefresh">상세 조회</button>
</div>

<div class="apDocumentSection">
    <div class="apSectionHeader">
        <h3 class="apSectionTitle">결재 대기 중</h3>
    </div>
    <div class="apDocumentTable">
        <table>
            <thead>
            <tr>
                <th class="apColStar"></th>
                <th class="apColTitle">제목</th>
                <th class="apColStatus">결재 상태</th>
                <th class="apColWriter">기안자</th>
                <th class="apColDate">기안일</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty waitingList}">
                    <tr><td colspan="5" class="emptyMessage">대기 중인 문서가 없습니다.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="i" items="${waitingList}">
                        <tr>
                            <td class="apColStar">★</td>
                            <td class="apColTitle"><a href="/approval/detail/${i.ID}">${i.TITLE}</a></td>
                            <td class="apColStatus">결재 대기중</td>
                            <td class="apColWriter">${i.DRAFTERNAME}</td>
                            <td class="apColDate">${i.REGDATE}"</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>

<div class="apDocumentSection">
    <div class="apSectionHeader">
        <h3 class="apSectionTitle">결재 진행 중</h3>
    </div>
    <div class="apDocumentTable">
        <table>
            <thead>
            <tr>
                <th class="apColStar"></th>
                <th class="apColTitle">제목</th>
                <th class="apColStatus">결재 상태</th>
                <th class="apColWriter">기안자</th>
                <th class="apColDate">기안일</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty goingList}">
                    <tr><td colspan="5" class="emptyMessage">진행 중인 문서가 없습니다.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="i" items="${goingList}">
                        <tr>
                            <td class="apColStar">★</td>
                            <td class="apColTitle"><a href="/approval/detail/${i.ID}">${i.TITLE}</a></td>
                            <td class="apColStatus">결재 진행중</td>
                            <td class="apColWriter">${i.DRAFTERNAME}</td>
                            <td class="apColDate">${i.REGDATE}"</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>

<div class="apDocumentSection">
    <div class="apSectionHeader">
        <h3 class="apSectionTitle">결재 완료</h3>
    </div>
    <div class="apDocumentTable">
        <table>
            <thead>
            <tr>
                <th class="apColStar"></th>
                <th class="apColTitle">제목</th>
                <th class="apColStatus">결재 상태</th>
                <th class="apColWriter">기안자</th>
                <th class="apColDate">기안일</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty completedList}">
                    <tr><td colspan="5" class="emptyMessage">완료된 문서가 없습니다.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="i" items="${completedList}">
                        <tr>
                            <td class="apColStar">★</td>
                            <td class="apColTitle"><a href="/approval/detail/${i.ID}">${i.TITLE}</a></td>
                            <td class="apColStatus">결재 완료</td>
                            <td class="apColWriter">${i.DRAFTERNAME}</td>
                            <td class="apColDate">${i.REGDATE}"</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>

<div class="bottomButton">
    <button class="btnChat"> 채팅</button>
</div>

<script>
    $(".apBtnNewDoc").on("change", function () {
        let selectDoc = $(this).val();
        if (selectDoc) {
            let url = "/approval/write?" + selectDoc;
            window.open(url, "new", "width=1000,height=1000");
        }
    });
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
