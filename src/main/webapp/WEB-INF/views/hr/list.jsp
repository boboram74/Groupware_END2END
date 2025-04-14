<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<link rel="stylesheet" href="/css/template/exam.css" />
<link rel="stylesheet" href="/css/hr/list.css" />

<div class="mainHeader surface-bright">
    <div class="detail-menu-header">
        <div class="detail-menu-title">
            <span class="material-icons">people</span>
            <span>인사 관리</span>
        </div>
        <button class="detail-menu-toggle-btn">
            <span class="material-icons">menu</span>
        </button>
    </div>
    <div class="detail-menu-modal">
        <ul class="detail-menu-list">
            <li class="detail-menu-item active">
                <span class="material-icons">badge</span>
                <span>직원 관리</span>
            </li>
            <li class="detail-menu-item">
                <span class="material-icons">insert_chart</span>
                <span>직원 통계</span>
            </li>
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
                    <option>부서</option>
                    <option>직급</option>
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
            <div class="box-title">사원 관리 테이블</div>
            <div class="box-content">
                <div class="table-container">
                    <table class="board-table">
                        <thead>
                        <tr>
                            <th>사번</th>
                            <th>이름</th>
                            <th>부서</th>
                            <th>직급</th>
                            <th>퇴직 처리</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${employeeList}" var="item">
                            <c:if test="${!item.role.equals('NO_AUTH')}">
                                <tr>
                                    <td>${item.id}</td>
                                    <td onclick="location.href='/mypage/${item.id}'" style="cursor:pointer;">${item.name}</td>
                                    <td>${item.departmentName}</td>
                                    <td>${item.jobName}</td>
                                    <td class="btn">
                                        <button type="button" class="resignationBtn secondary">처리 등록</button>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table>
                    <table class="board-table" style="display: ${(isNoAuthExist) ? 'block;' : 'none;'}">
                        <thead>
                        <tr>
                            <th>이름</th>
                            <th>부서</th>
                            <th>직급</th>
                            <th>확인</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${employeeList}" var="item">
                            <c:if test="${item.role.equals('NO_AUTH')}">
                                <tr>
                                    <td>${item.name}</td>
                                    <td>${item.departmentName}</td>
                                    <td>${item.jobName}</td>
                                    <td class="btn">
                                        <button type="button" class="approveBtn primary" data-id="${item.id}">승인</button>
                                        <button type="button" class="rejectBtn secondary" data-id="${item.id}">반려</button>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

<script src="/js/hr/list.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>