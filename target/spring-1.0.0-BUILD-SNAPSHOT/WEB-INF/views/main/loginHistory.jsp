<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/template/exam.css"/>
<div class="mainHeader surface-bright">
    <div class="detail-menu-header">
        <div class="detail-menu-title">
            <span class="material-icons">person</span>
            <span>마이페이지</span>
        </div>
        <button class="detail-menu-toggle-btn">
            <span class="material-icons">menu</span>
        </button>
    </div>
    <div class="detail-menu-modal">
        <ul class="detail-menu-list">
            <li class="detail-menu-item" onclick="location.href='/mypage/${employee.id}'">
                <span class="material-icons">person</span>
                <span>사원 정보</span>
            </li>
            <li class="detail-menu-item active" onclick="location.href='/login/history/1'">
                <span class="material-icons">login</span>
                <span>로그인 기록</span>
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
            <div class="box-title">로그인 기록</div>
            <div class="box-content">
                <table class="board-table">
                    <thead>
                        <tr>
                            <th>IP</th>
                            <th>상태</th>
                            <th>시간</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${loginHistoryList}" var="item">
                            <tr>
                                <td>${item.accessIp}</td>
                                <td>${item.state.equals('LOGIN') ? '로그인' : '로그아웃'}</td>
                                <td><fmt:formatDate value="${item.regDate}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="pageNavi">
                <c:if test="${pageNavi.hasPrev}">
                    <span class="material-icons paging" onclick="location.href='/login/history?page=${pageNavi.start - 1}'">chevron_left</span>
                </c:if>
                <c:forEach begin="${pageNavi.start}" end="${pageNavi.end}" var="item">
                    <c:choose>
                        <c:when test="${item == pageNavi.page}">
                            <span class="paging active" onClick="location.href='/login/history?page=${item}'">${item}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="paging" onClick="location.href='/login/history?page=${item}'">${item}</span>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${pageNavi.hasNext}">
                    <span class="material-icons paging" onclick="location.href='/login/history?page=${pageNavi.end + 1}'">chevron_right</span>
                </c:if>
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
    <script src="/js/main/contact.js" type="text/javascript"></div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>