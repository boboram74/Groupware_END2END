<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/mail/mail.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<div class="mainContainer">
    <div class="mainHeader">
        <div class="title">
            <h2><span class="material-icons">mail</span>제목</h2>
        </div>
        <div class="search">
            <div class="serchOption">
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
                <button id="searchBtn"> <span class="material-icons">search</span> 검색</button>
            </div>
        </div>
    </div>
    <div class="mainBody">
        <div class="content">
            출력 공간(높이 주지말고 컨텐츠 내용에 따라 유동적으로 증가하게 두세요)
        </div>
        <div class="pageNavi">
            1 2 3 4 5
        </div>
    </div>
</div>

<script src="/js/main/contact.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
