<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<style>
    * {
        box-sizing: border-box;
    }

    .mainHeader {
        position: fixed;
        left: 60px;
        top: 0;
        width: 200px;
        height: 100vh;
        background-color: #fff;
        border-right: 1px solid #e0e0e0;
        z-index: 100;
        margin-top: 60px;
        transition: none;
    }

    .mainContainer {
        width: calc(100% - 200px);  /* boxContents 전체 너비에서 mainHeader(200px)만큼 뺌 */
        margin-left: 200px;  /* mainHeader 너비만큼 왼쪽 마진 */
        min-height: 100vh;
        background-color: #fff;
        padding: 20px;
        display: flex;
        justify-content: center;
        transition: none;
    }

    .mainBody {
        max-width: 1200px;
        width: 100%;
        padding: 0;
        gap: 20px;  /* 자식 요소들 간의 간격 */
        display: flex;  /* flex 컨테이너로 설정 */
        flex-direction: column;  /* 세로 방향 정렬 */
    }


    /* 메뉴 헤더 컨테이너 */
    .detail-menu-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 10px 10px 0 10px;
        width: 100%;
        border-bottom: 1px solid #e0e0e0;
    }


    .detail-menu-title {
        font-size: 18px;                    /* 폰트 크기 증가 */
        font-weight: 600;
        margin: 10px 0;                     /* 상단 여백 추가 */
        display: flex;
        align-items: center;
        justify-content: start;
        gap: 8px;
    }

    .detail-menu-title .material-icons {
        font-size: 22px;                    /* 아이콘 크기도 약간 증가 */
    }


    .detail-menu-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .detail-menu-item {
        display: flex;
        align-items: center;
        padding: 8px 12px;
        gap: 10px;
        cursor: pointer;
        transition: background-color 0.2s;
        border-radius: 4px;
    }

    .detail-menu-item:hover {
        background-color: #f5f5f5;
    }

    .detail-menu-disc {
        font-size: 12px;
    }

    .detail-menu-item>.material-icons {
        font-size: 18px;
        color: #757575;
    }

    .detail-menu-item span:not(.material-icons):not(.detail-badge) {
        font-size: 12px;
        flex: 1;
    }

    .detail-badge {
        background-color: #e0e0e0;
        color: #424242;
        padding: 2px 8px;
        border-radius: 12px;
        font-size: 12px;
        min-width: 20px;
        text-align: center;
    }

    .detail-menu-item.active {
        background-color: #e3f2fd;
        color: #1976d2;
    }

    .detail-menu-item.active .material-icons {
        color: #1976d2;
    }

    .detail-menu-item.active .detail-badge {
        background-color: #1976d2;
        color: white;
    }

    .search {
        display: flex;
        justify-content: flex-end;  /* 오른쪽 정렬 */
        align-items: center;
        gap: 20px;  /* search 내부 자식 요소들 간의 간격 */
    }

    .search * {  /* search의 모든 자식 요소 */
        height: 25px !important;  /* 모든 자식 요소 높이 통일 */
    }

    /* 입력 필드나 버튼 등의 추가 스타일 필요시 */
    .search input,
    .search button,
    .search select {
        height: 25px;
        line-height: 25px;
        padding: 0 8px;  /* 좌우 여백 추가 */
    }

    #searchBtn {
        font-size: 13px;  /* 글자 크기 조정 */
        display: flex;
        align-items: center;  /* 수직 가운데 정렬 */
        justify-content: center;  /* 수평 가운데 정렬 */
        padding: 0 12px;  /* 좌우 여백 */
    }


    .content {
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: white;
    }

    .pageNavi {
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .detail-menu-modal {
        position: relative;
    }

    /* 모바일 메뉴 버튼 */
    .detail-menu-toggle-btn {
        display: none;  /* 기본적으로 숨김 */
        padding: 8px;
        background: #fff;
        border: 1px solid #e0e0e0;
        border-radius: 4px;
        cursor: pointer;
        align-items: center;
        justify-content: center;
        margin: 10px 0;
    }

    .detail-menu-toggle-btn:hover {
        background: #f5f5f5;
    }

    .detail-menu-toggle-btn .material-icons {
        font-size: 24px;
    }

    /* 모달 닫기 버튼 */
    .detail-modal-close {
        display: none;  /* 기본적으로 숨김 */
        position: absolute;
        top: 10px;
        right: 10px;
        background: transparent;
        border: none;
        cursor: pointer;
        padding: 5px;
    }

    .detail-modal-close:hover {
        opacity: 0.7;
    }

    .detail-modal-close .material-icons {
        font-size: 24px;
        color: #666;
    }

    /* 반응형 디자인 */
    @media (max-width: 768px) {
        .mainHeader {
            position: relative;
            left: 0;
            width: 100%;
            height: auto;
        }

        .mainContainer {
            margin-left: 0;
            width: 100%;
        }

        .detail-menu-toggle-btn {
            display: flex;  /* 모바일에서만 보이게 */
        }

        .detail-modal-close {
            display: block;  /* 모바일에서만 보이게 */
            position: absolute;
            top: 10px;
            right: 10px;
            background: transparent;
            border: none;
            cursor: pointer;
            padding: 5px;
        }

        .detail-modal-close:hover {
            opacity: 0.7;
        }

        .detail-menu-list {
            margin-top: 30px;  /* 닫기 버튼과의 간격 */
            max-height: 80vh;
            overflow-y: auto;
            padding-top: 10px;  /* 리스트 상단 간격 */
        }

        .detail-menu-modal {
            display: none;
            position: absolute;
            top: 100%;  /* 헤더 바로 아래에 위치 */
            width: 250px;  /* 너비 250px로 설정 */
            right: 0;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            z-index: 1100;
            margin-top: 10px;  /* 헤더와의 간격 */
        }

        .detail-menu-modal.active {
            display: block;
        }
    }

    /* 미디어 쿼리 추가 */
    @media screen and (max-width: 768px) {
        .mainHeader {
            margin-top: 10px;
        }

        .mainContainer {
            margin-top: 10px;
            width: 100%;
            margin-left: 0;
            min-height: calc(100vh - 70px);
        }
    }
</style>
<div class="mainHeader">
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