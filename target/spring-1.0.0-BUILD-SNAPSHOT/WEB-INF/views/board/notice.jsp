<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/board/board-header.jsp"/>
<div class="button-container">
  <div>
    <select id="category-select" onChange="location.href='/notice/list/' + this.value + '?page=1'">
      <option value="0" ${empty noticeCategory ? 'selected' : ''}>선택하십시오</option>
      <c:forEach items="${noticeCategoryList}" var="item">
        <option value="${item.id}" ${item.id eq noticeCategory.id ? 'selected' : ''}>${item.name}</option>
      </c:forEach>
    </select>
  </div>
  <c:if test="${employee.role eq 'ADMIN'}">
    <button id="writeBtn" class="primary" onclick="location.href='/notice/write'">글쓰기</button>
  </c:if>
</div>
<div class="search">
  <div>
    <select id="searchOption">
      <optio>선택</optio>
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
      <c:when test="${noticeCategory == null}">
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
        <th width="10%">번호</th>
        <th width="10%">분류</th>
        <th width="60%">제목</th>
        <th width="20%">등록 일자</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach items="${boardList}" var="item">
        <tr>
          <td>${item.id}</td>
          <td>${item.noticeCtName}</td>
          <td onclick="location.href='/notice/detail/${item.id}'"> ${item.title}</td>
          <td><fmt:formatDate value="${item.regDate}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
  <div class="pageNavi">
    <c:if test="${pageNavi.hasPrev}">
      <span class="material-icons paging" onclick="location.href='/notice/list?page=${pageNavi.start - 1}'">chevron_left</span>
    </c:if>
    <c:forEach begin="${pageNavi.start}" end="${pageNavi.end}" var="item">
      <c:choose>
        <c:when test="${item == pageNavi.page}">
          <span class="paging active" onClick="location.href='/notice/list?page=${item}'">${item}</span>
        </c:when>
        <c:otherwise>
          <span class="paging" onClick="location.href='/notice/list?page=${item}'">${item}</span>
        </c:otherwise>
      </c:choose>
    </c:forEach>
    <c:if test="${pageNavi.hasNext}">
      <span class="material-icons paging" onclick="location.href='/notice/list?page=${pageNavi.end + 1}'">chevron_right</span>
    </c:if>
  </div>
<script src="/js/main/contact.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/board/board-footer.jsp"/>
