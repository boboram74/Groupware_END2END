<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%-- 날짜 포맷 태그 추가 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/approval/list.css">
<link ref="stylesheet" href="/css/temapalte/exam.css"/>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<style>
    .searchBox {
        margin: 20px 0;
        text-align: right;
    }
    .searchInput {
        padding: 5px 10px;
        font-size: 14px;
        color: white;
        border: 1px solid #ccc;
        border-radius: 4px;
        background-color: black;
    }
    .searchBtn {
        padding: 5px 10px;
        background-color: #ff0000;
        color: white;
        border: none;
        border-radius: 4px;
        margin-left: 5px;
        cursor: pointer;
    }
</style>
<div class="userInfo">
    <div class="userIcon"></div>
    <div class="userText">나의 전자결재</div>
</div>
<div class="searchBox">
    <form action="/approval/search/" method="get" class="searchForm">
        <input type="text" name="keyword" placeholder="문서종류,기안자,제목" class="searchInput" />
        <button type="submit" class="searchBtn">검색</button>
    </form>
</div>
<div class="apControls">
    <select class="apBtnNewDoc">
        <option>새 기안 쓰기</option>
        <c:forEach var="form" items="${formList}">
            <option value="${form.id}">${form.name}</option>
        </c:forEach>
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
                <th class="apColType">문서 종류</th>
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
                            <td class="apColType">${i.FORMNAME}</td>
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
                <th class="apColType">문서 종류</th>
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
                            <td class="apColType">${i.FORMNAME}</td>
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
                <th class="apColType">문서 종류</th>
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
                            <td class="apColType">${i.FORMNAME}</td>
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
        <h3 class="apSectionTitle">반려 문서</h3>
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
                <c:when test="${empty rejectList}">
                    <tr><td colspan="5" class="emptyMessage">반려된 문서가 없습니다.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="i" items="${rejectList}">
                        <tr>
                            <td class="apColStar">★</td>
                            <td class="apColTitle"><a href="/approval/detail/${i.ID}">${i.TITLE}</a></td>
                            <td class="apColStatus">반려</td>
                            <td class="apColWriter">${i.DRAFTERNAME}</td>
                            <td class="apColDate">${i.REGDATE}"</td>
                            <td class="apColType">${i.FORMNAME}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>


<script>
    $(".apBtnNewDoc").on("change", function () {
        let selectDoc = $(this).val();
        if (selectDoc) {
            let url = "/approval/write/" + selectDoc;
            window.open(url, "new", "width=1000,height=1000");
        }
    });
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
