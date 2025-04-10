<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<link rel="stylesheet" href="/css/template/exam.css" />
<style>
    .table-container {
        display: flex;
        flex-direction: row;
        width: 100%;
        gap: 20px;
        overflow-x: auto; /* 가로 스크롤 추가 */
        padding-bottom: 10px; /* 스크롤바 여유 공간 */
    }

    /* 테이블 헤더를 고정하고 싶은 경우 */
    .table-container table {
        width: 100%;
        border-collapse: collapse;
    }

    .table-container thead {
        position: sticky;
        top: 0;
        z-index: 1;
    }

    .table-container tbody {
        display: block;
        max-height: 500px; /* 원하는 최대 높이 */
        overflow-y: auto;
    }

    /* thead tr과 tbody tr을 같은 너비로 맞추기 */
    .table-container thead,
    .table-container tbody tr {
        display: table;
        width: 100%;
        table-layout: fixed;
    }

    .board-table .btn {
        display: flex;
        align-items: center;
        justify-content: space-evenly;
        gap: 5px;
    }

    .board-table button {
        padding: 5px 5px;
        border: none;
        border-radius: 3px;
        font-size: 10px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.2s ease;
        display: flex;
        align-items: center;
        gap: 6px;
    }


    /* 스크롤바 스타일링 */
    .table-container tbody::-webkit-scrollbar {
        width: 8px; /* 세로 스크롤바 너비 */
    }

    .table-container tbody::-webkit-scrollbar-track {
        background: var(--md-sys-color-outline); /* 스크롤바 트랙 배경 */
        border-radius: 4px;
    }

    .table-container tbody::-webkit-scrollbar-thumb {
        background: var(--md-sys-color-outline-variant); /* 스크롤바 색상 */
        border-radius: 4px;
    }

    .table-container tbody::-webkit-scrollbar-thumb:hover {
        background: #555; /* 스크롤바 호버 색상 */
    }

</style>
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
                                <th>권한 상태</th>
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
                                        <td>${item.role}</td>
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
                                <th>권한</th>
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
                                        <td>${item.role}</td>
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
    <script>
        $(document).ready(function() {
            $('.detail-menu-item').on('click', function() {
                $('.detail-menu-item').removeClass('active');
                $(this).addClass('active');
                // 클릭 이벤트 처리 로직
            });

            const $menuBtn = $('.detail-menu-toggle-btn');
            const $detailMenuModal = $('.detail-menu-modal');
            const $closeBtn = $('.detail-modal-close');

            // 메뉴 버튼 클릭 시 모달 열기
            $menuBtn.on('click', function() {
                $detailMenuModal.addClass('active');
                $('body').css('overflow', 'hidden');
            });

            // 닫기 버튼 클릭 시 모달 닫기
            $closeBtn.on('click', function() {
                $detailMenuModal.removeClass('active');
                $('body').css('overflow', '');
            });

            // 모달 외부 클릭 시 닫기
            $(window).on('click', function(e) {
                if ($(e.target).is($detailMenuModal)) {
                    $detailMenuModal.removeClass('active');
                    $('body').css('overflow', '');
                }
            });
        });
    </script>
    <script src="/js/main/contact.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>