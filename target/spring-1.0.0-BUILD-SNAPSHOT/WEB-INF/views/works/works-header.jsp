<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<link rel="stylesheet" href="/css/template/exam.css"/>
<style>




    a {
        text-decoration: none;
    }


</style>
<div class="mainHeader surface-bright">
    <div class="detail-menu-header">
        <div class="detail-menu-title">
            <span class="material-icons">dashboard</span>
            <span> works</span>
        </div>
        <button class="detail-menu-toggle-btn">
            <span class="material-icons">menu</span>
        </button>
    </div>
    <div class="detail-menu-modal">
        <ul class="detail-menu-list">
            <li class="detail-menu-item" onClick="location.href='/notice/list?page=1'">
                <span class="material-icons">notifications</span>
                <span>Works 메인/span>
                <span class="detail-badge">5</span>
            </li>
            <li class="detail-menu-item"  onClick="location.href='/work/write'">
                <span class="material-icons">bookmark</span>
                <span class="detail-menu-disc">업무 작성하기</span>
                <span class="detail-badge">12</span>
            </li>
        </ul>
        <button class="detail-modal-close">
            <span class="material-icons">close</span>
        </button>
    </div>
</div>
<div class="mainContainer">
    <div class="mainBody">
        <script src="/js/main/contact.js" type="text/javascript"></script>

