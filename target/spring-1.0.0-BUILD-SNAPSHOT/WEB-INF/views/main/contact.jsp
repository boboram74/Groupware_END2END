<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<link rel="stylesheet" href="/css/template/exam.css"/>
<link rel="stylesheet" href="/css/main/contact.css"/>

<div class="mainHeader surface-bright">
    <div class="detail-menu-header">
        <div class="detail-menu-title">
            <span class="material-icons">phone_in_talk</span>
            <span>연락처</span>
        </div>
        <button class="detail-menu-toggle-btn">
            <span class="material-icons">menu</span>
        </button>
    </div>
    <div class="detail-menu-modal">
        <ul class="detail-menu-list">
        </ul>
        <button class="detail-modal-close">
            <span class="material-icons">close</span>
        </button>
    </div>
</div>

<div class="mainContainer">
    <div class="mainBody">
        <div class="search">
            <div>
                <select id="searchOption">
                    <option>이름</option>
                    <option>연락처</option>
                </select>
            </div>
            <div class="searchInput">
                <input id="input" type="text" name="keyword" placeholder="검색어 입력">
            </div>
            <div>
                <button id="searchBtn"><span class="material-icons">search</span> 검색</button>
            </div>
        </div>
        <div class="bord-table-container">
            <table class="board-table">
                <thead>
                <tr>
                    <th>이름</th>
                    <th>부서명</th>
                    <th>직급명</th>
                    <th>연락처</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${contactList}" var="contact">
                    <tr>
                        <td class="writer-info">
                            <div class="profile-img" style="background-image: url('${contact.profileImg}')"></div>
                            <span>${contact.name}</span>
                        </td>
                        <td>${contact.departmentName}</td>
                        <td>${contact.jobName}</td>
                        <td>${contact.contact}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="pageNavi">
            <c:if test="${pageNavi.hasPrev}">
                <span class="material-icons paging" onclick="location.href='/contact?page=${pageNavi.start - 1}'">chevron_left</span>
            </c:if>
            <c:forEach begin="${pageNavi.start}" end="${pageNavi.end}" var="item">
                <c:choose>
                    <c:when test="${item == page}">
                        <span class="paging active" onClick="location.href='/contact?page=${item}'">${item}</span>
                    </c:when>
                    <c:otherwise>
                        <span class="paging" onClick="location.href='/contact?page=${item}'">${item}</span>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${pageNavi.hasNext}">
                <span class="material-icons paging" onclick="location.href='/contact?page=${pageNavi.end + 1}'">chevron_right</span>
            </c:if>
        </div>
    </div>

<script src="/js/main/contact.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>