<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<link rel="stylesheet" href="/css/template/exam.css"/>
<div class="mainHeader surface-bright">
    <div class="detail-menu-header">
        <div class="detail-menu-title">
            <span class="material-icons">dashboard</span>
            <span>게시판</span>
        </div>
        <button class="detail-menu-toggle-btn">
            <span class="material-icons">menu</span>
        </button>
    </div>
    <div class="detail-menu-modal">
        <ul class="detail-menu-list">
            <li class="detail-menu-item">
                <span class="material-icons">notifications</span>
                <span>공지 게시판</span>
                <span class="detail-badge">5</span>
            </li>
            <li class="detail-menu-item">
                <span class="material-icons">star</span>
                <span>중요 게시판</span>
                <span class="detail-badge">32</span>
            </li>
            <li class="detail-menu-item">
                <span class="material-icons">bookmark</span>
                <span class="detail-menu-disc">전사 게시판</span>
                <span class="detail-badge">12</span>
            </li>
            <li class="detail-menu-item">
                <span class="material-icons">person</span>
                <span>그룹 게시판</span>
                <span class="detail-badge">2</span>
            </li>
            <li class="detail-menu-item">
                <span class="material-icons">folder</span>
                <span>자료실</span>
            </li>
            <li class="detail-menu-item">
                <span class="material-icons">create</span>
                <span>게시판 만들기</span>
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
        <script>
            $(document).ready(function () {
                $('.detail-menu-item').on('click', function () {
                    $('.detail-menu-item').removeClass('active');
                    $(this).addClass('active');
                    // 클릭 이벤트 처리 로직
                });

                const $menuBtn = $('.detail-menu-toggle-btn');
                const $detailMenuModal = $('.detail-menu-modal');
                const $closeBtn = $('.detail-modal-close');

                // 메뉴 버튼 클릭 시 모달 열기
                $menuBtn.on('click', function () {
                    $detailMenuModal.addClass('active');
                    $('body').css('overflow', 'hidden');
                });

                // 닫기 버튼 클릭 시 모달 닫기
                $closeBtn.on('click', function () {
                    $detailMenuModal.removeClass('active');
                    $('body').css('overflow', '');
                });

                // 모달 외부 클릭 시 닫기
                $(window).on('click', function (e) {
                    if ($(e.target).is($detailMenuModal)) {
                        $detailMenuModal.removeClass('active');
                        $('body').css('overflow', '');
                    }
                });
            });
        </script>
        <script src="/js/main/contact.js" type="text/javascript"></script>