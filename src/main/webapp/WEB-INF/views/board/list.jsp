<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/board/board-header.jsp"/>
<style>
    .board-table {
        width: 100%;
        border-collapse: collapse;
        font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
        font-size: 14px;
    }

    .board-table thead th {
        background-color: #5a6673;
        color: white;
        padding: 10px;
        text-align: center;
        border: 1px solid #4a5568;
    }

    .board-table th:first-child,
    .board-table td:first-child {
        width: 80px;
        text-align: center;
    }

    /* 번호 열 스타일 */
    .board-table th:nth-child(2),
    .board-table td:nth-child(2) {
        width: 800px;
        text-align: center;
    }

    /* 제목 열 스타일 */
    .board-table th:nth-child(3),
    .board-table td:nth-child(3) {
        width: auto;
        text-align: center;
    }

    /* 작성자 열 스타일 */
    .board-table th:nth-child(4),
    .board-table td:nth-child(4) {
        width: 100px;
        text-align: center;
    }

    /* 등록일 열 스타일 */
    .board-table th:nth-child(5),
    .board-table td:nth-child(5) {
        width: 120px;
        text-align: center;
    }

    /* 조회수 열 스타일 */
    .board-table th:nth-child(6),
    .board-table td:nth-child(6) {
        width: 60px;
        text-align: center;
    }

    /* 테이블 행 스타일 */
    .board-table tbody tr {
        border-bottom: 1px solid #e2e8f0;
    }

    /* 홀수 행 배경색 */
    .board-table tbody tr:nth-child(odd) {
        background-color: #f8f9fa;
    }

    /* 짝수 행 배경색 */
    .board-table tbody tr:nth-child(even) {
        background-color: #ffffff;
    }

    /* 행 호버 효과 */
    .board-table tbody tr:hover {
        background-color: #edf2f7;
    }

    /* 셀 패딩 */
    .board-table td {
        padding: 8px 10px;
        border: 1px solid #e2e8f0;
    }

    /* 체크박스 스타일 */
    .board-table input[type="checkbox"] {
        width: 16px;
        height: 16px;
    }

</style>
<div class="button-container">

    <a href="/board/write">
        <button id="writeBtn" class="primary">글쓰기</button>
    </a>

</div>
<form action="/board/search" method="get" class="searchForm">
<div class="search">
    <div>
            <select id="searchOption" name="option">
                <option value="writer">작성자</option>
                <option value="title">제목</option>
            </select>
    </div>
        <div class="search">
            <input id="input" type="text" name="keyword" placeholder="검색어 입력">

            <button id="searchBtn" type="submit"><span class="material-icons">search</span> 검색</button>
        </div>
    </form>
</div>
<table class="board-table">
    <thead>
    <tr>
        <h1>목록</h1>
    </tr>
    <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>등록일</th>
        <th>조회</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="board" items="${boardList}">
        <tr>
            <td>${board.id}</td>
            <td><a href="/board/detail/${board.id}">${board.title}</a></td>
            <td>${board.employeeName}</td>
            <td>${board.regDate}</td>
            <td>${board.viewCount}</td>
        </tr>
    </c:forEach>

    <!-- 추가 행 -->
    </tbody>
</table>
<div class="pageNavi">
    <c:if test="${pageNavi.hasPrev}">
        <span class="material-icons paging" onclick="location.href='/board/list?page=${pageNavi.start - 1}'">chevron_left</span>
    </c:if>
    <c:forEach begin="${pageNavi.start}" end="${pageNavi.end}" var="item">
        <c:choose>
            <c:when test="${item == pageNavi.page}">
                <span class="paging active" onClick="location.href='/board/list?page=${item}'">${item}</span>
            </c:when>
            <c:otherwise>
                <span class="paging" onClick="location.href='/board/list?page=${item}'">${item}</span>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <c:if test="${pageNavi.hasNext}">
        <span class="material-icons paging" onclick="location.href='/board/list?page=${pageNavi.end + 1}'">chevron_right</span>
    </c:if>
</div>

<jsp:include page="/WEB-INF/views/board/board-footer.jsp"/>
