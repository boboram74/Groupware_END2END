<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/main/contact.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<div class="mainContainer">
    <div class="mainHeader">
        <div class="title">
            <h2><span class="material-icons">phone_in_talk</span>연락처</h2>
        </div>
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
                <button id="searchBtn"> <span class="material-icons">search</span> 검색</button>
            </div>
        </div>
    </div>
    <div class="mainBody">
        <div class="content">
            <table>
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
                        <td>${contact.name}</td>
                        <td>${contact.departmentName}</td>
                        <td>${contact.jobName}</td>
                        <td>${contact.contact}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="pageNavi">
            1 2 3 4 5
        </div>
    </div>
</div>

<script src="/js/main/contact.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
