<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/hr/list.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<div class="mainContainer">
    <div class="mainHeader">
        <div class="title">
            <h2><span class="material-icons">badge</span>직원 관리</h2>
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
                <table border="1">
                    <tr>
                        <th>이름</th>
                        <th>부서</th>
                        <th>직급</th>
                    </tr>
                    <c:forEach items="${employeeList}" var="item">
                        <c:if test="${!item.role.equals('NO_AUTH')}">
                        <tr>
                            <td>${item.id}</td>
                            <td>${item.name}</td>
                            <td>${item.role}</td>
                        </tr>
                        </c:if>
                    </c:forEach>
                </table>
            </div>
            <div class="new">
                <table border="1">
                    <tr>
                        <th>이름</th>
                        <th>부서</th>
                        <th>직급</th>
                        <th>승인</th>
                        <th>반려</th>
                    </tr>
                    <c:forEach items="${employeeList}" var="item">
                        <c:if test="${item.role.equals('NO_AUTH')}">
                            <tr>
                                <td>${item.id}</td>
                                <td>${item.name}</td>
                                <td>${item.role}</td>
                                <td><button id="approveBtn">O</button></td>
                                <td><button id="rejectBtn">X</button></td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </table>
            </div>
        </div>
        <div class="pageNavi">
            1 2 3 4 5
        </div>

    </div>

    <script src="/js/hr/list.js" type="text/javascript"></script>
    <jsp:include page="/WEB-INF/views/template/footer.jsp"/>
