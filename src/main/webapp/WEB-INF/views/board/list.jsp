<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/board/board-header.jsp"/>
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
<div class="box surface-bright">
    <div class="box-title">전사 게시판</div>
    <div class="box-content">
        <table class="board-table">
            <thead>
            <tr>
                <th width="8%">번호</th>
                <th width="52%">제목</th>
                <th width="15%">작성자</th>
                <th width="15%">등록일</th>
                <th width="10%">조회</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="board" items="${boardList}">
                <tr>
                    <td>${board.id}</td>
                    <td class="title" onClick="location.href='/board/detail/${board.id}'">
                        <span>${board.title}</span>
                    </td>
                    <td class="writer-info">
                        <div class="profile-img" style="background-image: url('${board.profileImg}')"></div>
                        <span>${board.employeeName}</span>
                    </td>
                    <td>${board.regDate}</td>
                    <td>${board.viewCount}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="pageNavi">
        <c:if test="${pageNavi.hasPrev}">
            <span class="material-icons paging" onclick="location.href='${url}${pageNavi.start - 1}'">chevron_left</span>
        </c:if>
        <c:forEach begin="${pageNavi.start}" end="${pageNavi.end}" var="item">
            <c:choose>
                <c:when test="${item == pageNavi.page}">
                    <span class="paging active" onClick="location.href='${url}${item}'">${item}</span>
                </c:when>
                <c:otherwise>
                    <span class="paging" onClick="location.href='${url}${item}'">${item}</span>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:if test="${pageNavi.hasNext}">
            <span class="material-icons paging" onclick="location.href='${url}${pageNavi.end + 1}'">chevron_right</span>
        </c:if>
    </div>
</div>

<jsp:include page="/WEB-INF/views/board/board-footer.jsp"/>
