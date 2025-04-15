<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<link rel="stylesheet" href="/css/template/exam.css"/>
<div class="mainHeader surface-bright">
    <div class="detail-menu-header">
        <div class="detail-menu-title">
            <span class="material-icons">mail</span>
            <span>메일함</span>
        </div>
        <button class="detail-menu-toggle-btn">
            <span class="material-icons">menu</span>
        </button>
    </div>
    <div class="detail-menu-modal">
        <ul class="detail-menu-list">
            <li class="detail-menu-item">
                <span class="material-icons">star</span>
                <span>중요 메일함</span>
                <span class="detail-badge">5</span>
            </li>
            <li class="detail-menu-item">
                <span class="material-icons">all_inbox</span>
                <span>전체 메일함</span>
                <span class="detail-badge">32</span>
            </li>
            <li class="detail-menu-item">
                <span class="material-icons">send</span>
                <span>보낸 메일함</span>
            </li>
            <li class="detail-menu-item">
                <span class="material-icons">move_to_inbox</span>
                <span class="detail-menu-disc">받은 메일함</span>
                <span class="detail-badge">12</span>
            </li>
            <li class="detail-menu-item">
                <span class="material-icons">drafts</span>
                <span>임시 저장함</span>
                <span class="detail-badge">2</span>
            </li>
            <li class="detail-menu-item">
                <span class="material-icons">delete</span>
                <span>휴지통</span>
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
        <div class="content">
            출력 공간(높이 주지말고 컨텐츠 내용에 따라 유동적으로 증가하게 두세요)
        </div>
        <!-- 배경색 hover 효과 -->
        <button class="primary primary-hover">호버 효과가 있는 기본 버튼</button>
        <div class="primary-container primary-container-hover">호버 효과가 있는 컨테이너</div>

        <!-- 텍스트 hover 효과 -->
        <a class="primary-text primary-text-hover">호버 효과가 있는 링크</a>

        <!-- 여러 효과 조합 -->
        <button class="secondary secondary-hover">
            <span class="primary-text primary-text-hover">혼합된 호버 효과</span>
        </button>
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