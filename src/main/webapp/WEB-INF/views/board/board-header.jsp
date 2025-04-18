<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<link rel="stylesheet" href="/css/template/exam.css"/>
<style>
    .category-modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        align-items: center;
        justify-content: center;
        z-index: 9999;
    }

    .category-modal.active {
        display: flex;
    }

    .modal-content {
        background-color: white;
        padding: 20px;
        border-radius: 8px;
        width: 400px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    #categoryName, #description {
        width: 100%;
        margin-top: 8px;
    }

    .saveBtn, .canBtn {
        margin-top: 10px;
        padding: 8px 16px;
        border: none;
        cursor: pointer;
    }

    a {
        text-decoration: none;
    }

    .saveBtn {
        background-color: #4CAF50;
        color: white;
    }

    .canBtn {
        background-color: #f44336;
        color: white;
    }

</style>
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
            <li class="detail-menu-item ${active eq 'notice' ? 'active' : ''}" onClick="location.href='/notice/list?page=1'">
                <span class="material-icons">notifications</span>
                <span>공지 게시판</span>
                <span class="detail-badge">5</span>
            </li>
            <li class="detail-menu-item ${empty active ? 'active' : ''}" onClick="location.href='/board/list'">
                <span class="material-icons">bookmark</span>
                <span class="detail-menu-disc">전사 게시판</span>
                <span class="detail-badge">12</span>
            </li>
            <li class="detail-menu-item">
                <span class="material-icons">folder</span>
                <span>자료실</span>
            </li>
        </ul>
        <button class="detail-modal-close">
            <span class="material-icons">close</span>
        </button>
    </div>
</div>
<div id="category-modal" class="category-modal">
    <form action="/board/category/insert" method="post">
        <div class="modal-content">
            <h3>게시판 만들기</h3>
            <label for="categoryName">카테고리 이름:</label>
            <input type="text" id="categoryName" name="name" required>

            <label for="categorySelect">분류선택:</label>
            <select name="category" id="categorySelect" required>
                <option VALUE="">분류</option>
                <option value="PUBLIC">공공게시판</option>
                <option value="GOURP">그룹게시판</option>
            </select>

            <c:forEach var="b" items="${boardCategoryList}">
                <li class="detail-menu-item">
                    <span class="material-icons">bookmark</span>
                    <span class="detail-menu-disc">${b.name}</span>
                    <span class="detail-badge">12</span>
                </li>
            </c:forEach>
            <div class="button-area">
                <button type="submit" class="saveBtn">저장</button>
                <button type="button" class="canBtn" id="cancel-btn">취소</button>
            </div>
        </div>
    </form>
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

                const $createCategoryBtn = $('#create-category');
                const $categoryModal = $('#category-modal');
                const $cancelBtn = $('#cancel-btn');

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

                //모달 외부 클릭 시 닫기
                $(window).on('click', function (e) {
                    if ($(e.target).is($detailMenuModal)) {
                        $detailMenuModal.removeClass('active');
                        $('body').css('overflow', '');
                    }
                });
                $createCategoryBtn.on('click', function () {
                    $categoryModal.addClass('active');
                    $('body').css('overflow', 'hidden');  // 모달 열 때 화면 고정
                });

                // 취소 버튼 클릭 시 카테고리 모달 닫기
                $cancelBtn.on('click', function () {
                    $categoryModal.removeClass('active');
                    $('body').css('overflow', '');  // 화면 고정 해제
                });
            });

        </script>
