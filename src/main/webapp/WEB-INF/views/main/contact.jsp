<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/css/main/contact.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>

<div class="hrContainer">
    <div class="hrHeader">
        <div class="title"><h2>연락처</h2></div>
        <div class="search">
            <div class="serchOption">
                <select name="searchOption" id="searchOption">
                    <option value="name">이름 </option>
                    <option value="contact">연락처 </option>
                </select>
            </div>
            <div class="searchInput">
                <input id="input" type="text" name="keyword" placeholder="검색어 입력">
            </div>
            <div class="searchBtn">
                <button id="searchBtn"><i class="fas fa-magnifying-glass"></i></button>
            </div>
        </div>
    </div>
    <div class="hrBody">
        <div class="content">
            연락처 출력 공간
        </div>
        <div class="pageNavi">
            1 2 3 4 5
        </div>
    </div>
</div>

<script src="/js/main/contact.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
