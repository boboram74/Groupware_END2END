<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/hr/list.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>

<div class="mainContainer">
    <div class="mainHeader">
        <div class="title">
            <h2><span class="material-icons">mail</span>직원 관리</h2>
        </div>
        <div class="search">
            <div>
                <select id="searchOption">
                    <option>이름</option>
                    <option>부서</option>
                    <option>직급</option>
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
            <div class="list">
                직원 목록
            </div>
            <div class="new">
                신입 승인
            </div>
        </div>
        <div class="pageNavi">
            1 2 3 4 5
        </div>
    </div>
</div>

<script src="/js/hr/list.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
