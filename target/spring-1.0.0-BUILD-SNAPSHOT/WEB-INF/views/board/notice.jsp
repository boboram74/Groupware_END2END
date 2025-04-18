<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/board/board-header.jsp"/>
<div class="mainContainer">
  <div class="mainBody">
    <div class="search">
      <div>
        <select id="searchOption">
          <option>선택</option>
          <option>선택</option>
          <option>선택</option>
        </select>
      </div>
      <div class="searchInput">
        <input id="input" type="text" name="keyword" placeholder="검색어 입력">
      </div>
      <div>
        <button id="searchBtn"><span class="material-icons">search</span> 검색</button>
      </div>
    </div>
    <div class="box surface-bright">
      <div class="box-title">
        <c:choose>
          <c:when test="${noticeCtegory == null}">
            전체 공지
          </c:when>
          <c:otherwise>
            ${noticeCategory.name}
          </c:otherwise>
        </c:choose>
      </div>
      <div class="box-content">
        <table class="board-table">
          <thead>
          <tr>
            <th>번호</th>
            <th>제목</th>
            <th>등록 일자</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach items="${boardList}" var="item">
            <tr>
              <td>${item.id}</td>
              <td>${item.noticeCtName} ${item.title}</td>
              <td><fmt:formatDate value="${item.regDate}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
      <div class="pageNavi">
        <c:if test="${pageNavi.hasPrev}">
          <span class="material-icons paging" onclick="location.href='/login/history?page=${pageNavi.start - 1}'">chevron_left</span>
        </c:if>
        <c:forEach begin="${pageNavi.start}" end="${pageNavi.end}" var="item">
          <c:choose>
            <c:when test="${item == pageNavi.page}">
              <span class="paging active" onClick="location.href='/login/history?page=${item}'">${item}</span>
            </c:when>
            <c:otherwise>
              <span class="paging" onClick="location.href='/login/history?page=${item}'">${item}</span>
            </c:otherwise>
          </c:choose>
        </c:forEach>
        <c:if test="${pageNavi.hasNext}">
          <span class="material-icons paging" onclick="location.href='/login/history?page=${pageNavi.end + 1}'">chevron_right</span>
        </c:if>
      </div>
    </div>
  </div>
<script src="/js/main/contact.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/board/board-footer.jsp"/>
