<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/board/board-header.jsp"/>
<div class="button-container">
    <button class="extended-button">연장근무 신청</button>
    <button class="vacation-button">휴가 신청</button>
    <button class="vacation-list-button">휴가 조회</button>
</div>
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
<div class="content">
</div>
<script src="/js/main/contact.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/board/board-footer.jsp"/>
