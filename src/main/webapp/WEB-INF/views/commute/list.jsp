<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/commute/commute-header.jsp"/>
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
    출력 공간(높이 주지말고 컨텐츠 내용에 따라 유동적으로 증가하게 두세요)
<jsp:include page="/WEB-INF/views/commute/commute-footer.jsp"/>