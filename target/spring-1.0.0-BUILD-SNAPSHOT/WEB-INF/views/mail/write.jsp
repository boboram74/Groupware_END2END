<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/template/exam.css" />
<link rel="stylesheet" href="/css/mail/mail-list.css" />
<link rel="stylesheet" href="/css/mail/write.css" />
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
        border-right: 1px solid var(--md-sys-color-outline);
        z-index: 100;
        margin-top: 70px;
        transition: none;
    }

    .mainContainer {
        width: calc(100% - 200px);  /* boxContents 전체 너비에서 mainHeader(200px)만큼 뺌 */
        margin-left: 200px;  /* mainHeader 너비만큼 왼쪽 마진 */
        min-height: 100vh;
        padding: 20px;
        display: flex;
        justify-content: center;
        transition: none;
    }

    .mainBody {
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
        border-bottom: 1px solid var(--md-sys-color-outline);
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
        color: var(--md-sys-color-secondary);
    }

    .detail-menu-item:hover:not(.active) {
        background-color: rgba(var(--md-sys-color-secondary-rgb), 0.1);
    }

    .detail-menu-disc {
        font-size: 12px;
    }

    .detail-menu-item>.material-icons {
        font-size: 18px;
        color: var(--md-sys-color-secondary);
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
        background-color: var(--md-sys-color-secondary);
        color: var(--md-sys-color-on-secondary);
    }

    .detail-menu-item.active .material-icons {
        color: var(--md-sys-color-on-secondary);
    }

    .detail-menu-item.active .detail-badge {
        background-color: var(--md-sys-color-on-secondary);
        color: var(--md-sys-color-secondary);
    }

    .search {
        display: flex;
        justify-content: flex-end;  /* 오른쪽 정렬 */
        align-items: center;
        gap: 10px;  /* search 내부 자식 요소들 간의 간격 */
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
        background-color: var(--md-sys-color-surface-bright);
        color: var(--md-sys-color-surface);
    }

    /* placeholder 색상 변경 */
    .search input::placeholder {
        color: var(--md-custom-read-color);
        opacity: 0.87;
    }

    /* Firefox를 위한 별도 설정 */
    input::-moz-placeholder {
        color: #DEDEDE;
        opacity: 0.87;
    }

    .search button {
        background-color: var(--md-sys-color-primary);
        color: var(--md-sys-color-on-primary);
        padding: 10px 8px;
        border: none;
        border-radius: 3px;
        font-size: 12px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.2s ease;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .search button .material-icons {
        font-size: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .search button:hover {
        opacity: 0.9;
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
        background: var(--md-sys-color-secondary-hover);
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

    .button-container {
        display: flex;
        justify-content: end;
        gap: 10px;
    }

    /* 기본 버튼 스타일 */
    .button-container button {
        padding: 8px 16px;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.2s ease;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .button-container .primary:hover {
        opacity: 0.9;
    }

    .button-container .secondary:hover {
        opacity: 0.9;
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

    /* 게시판 테이블 스타일 */
    .board-table-container {
        overflow-x: auto;
    }

    .board-table {
        width: 100%;
        border-collapse: collapse;
    }

    .board-table th {
        background-color: var(--md-sys-color-surface-container);
        padding: 12px;
        font-weight: 600;
        text-align: center;
        border-bottom: 1px solid var(--md-sys-color-outline);
        border-top: 1px solid var(--md-sys-color-primary);
    }

    .board-table td {
        padding: 10px;
        border-bottom: 1px solid var(--md-sys-color-outline);
        text-align: center;
        vertical-align: middle;
    }

    .board-table td.title {
        text-align: left;
        cursor: pointer;
    }

    .board-table td.title:hover {
        text-decoration: underline;
        color: var(--md-sys-color-primary);
    }

    /* 테이블 행 호버 효과 */
    .board-table tbody tr:hover {
        background-color: var(--md-sys-color-surface-container);
    }

    .box {
        display: flex;
        flex-direction: column;
        height: 100%; /* 전체 높이 사용 */
        border-radius: 8px;
    }

    .box-title {
        padding: 15px;
        font-size: 20px;
        font-weight: 600;
        border-bottom: 1px solid var(--md-sys-color-outline);
        flex-shrink: 0; /* 크기 고정 */
    }

    .box-content {
        flex: 1; /* 남은 공간 모두 사용 */
        padding: 20px;
        display: flex; /* flex 컨테이너로 설정 */
        flex-direction: column; /* 세로 방향 정렬 */
    }
</style>
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
            <li class="detail-menu-item" onclick="location.href='/mail/important'">
                <span class="material-icons">star</span>
                <span>중요 메일함</span>
                <span class="detail-badge"><span id="importantMailBox"></span></span>
            </li>
            <li class="detail-menu-item" onclick="location.href='/mail/list'">
                <span class="material-icons">all_inbox</span>
                <span>전체 메일함</span>
                <span class="detail-badge"><span id="allMailBox"></span></span>
            </li>
            <li class="detail-menu-item" onclick="location.href='/mail/sendList'">
                <span class="material-icons">send</span>
                <span>보낸 메일함</span>
            </li>
            <li class="detail-menu-item" onclick="location.href='/mail/inbox'">
                <span class="material-icons">move_to_inbox</span>
                <span class="detail-menu-disc">받은 메일함</span>
                <span class="detail-badge"><span id="receiveMailBox"></span></span>
            </li>
            <li class="detail-menu-item" onclick="location.href='/mail/temp'">
                <span class="material-icons">drafts</span>
                <span>임시 저장함</span>
                <span class="detail-badge">2</span>
            </li>
            <li class="detail-menu-item" onClick="location.href='/mail/trash'">
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
            <form action="/mail/reSend" method="post">
                <div class="formContainer">
                    <div class="formGroup">
                        <label>받는 사람</label>
                        <input type="hidden" id="sender" value=${employee.email}>
                        <c:choose>
                            <c:when test="${not empty receiveMail}">
                                <input type="text" id="receiveMail" value="${receiveMail}">
                            </c:when>
                            <c:otherwise>
                                <input type="text" id="receiveMail" placeholder="받는 사람을 입력해주십시오">
                            </c:otherwise>
                        </c:choose>
                        <button class="addressBtn">주소록</button>
                    </div>
                    <div class="formGroup">
                        <label>제목</label>
                        <c:choose>
                            <c:when test="${not empty title}">
                                <input type="text" id="inputTitle" value="re : ${title}">
                            </c:when>
                            <c:otherwise>
                                <input type="text" id="inputTitle" placeholder="제목을 입력하십시오">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="formGroup">
                        <label>파일 첨부</label>
                        <div class="dragDropArea" id="dropArea">
                            <span class="material-icons upload-icon">cloud_upload</span>
                            <p>파일을 이곳에 드래그하거나<br>클릭하여 업로드하세요</p>
                            <p class="file-info">선택된 파일 없음</p>
                        </div>
                        <input type="file" id="fileInput" style="display:none;" multiple>
                        <span class="fileSize">0/30 MB</span>
                    </div>
                </div>
                <div class="mainBody">
                    <div class="content">
                    <c:choose>
                        <c:when test="${not empty content}">
                            <textarea id="mailContent">원본내용 :

${content}

============================================

                            </textarea>
                        </c:when>
                        <c:otherwise>
                            <textarea id="mailContent"></textarea>
                        </c:otherwise>
                    </c:choose>
                    </div>
                    <div class="button-container">
                        <button class="secondary" type="button">임시 저장</button>
                        <button class="primary" type="button" id="sendMail">보내기</button>
                    </div>
                </div>
            </form>
    </div>
</div>
<input type="hidden" id="employeeId" value=${employee.id}>
<script>
    $(document).ready(function() {
        var activeIndex = localStorage.getItem("activeMenuIndex");
        if (activeIndex !== null) {
            $('.detail-menu-item').eq(activeIndex).addClass('active');
        }

        $('.detail-menu-item').on('click', function() {
            $('.detail-menu-item').removeClass('active');
            $(this).addClass('active');
            var index = $('.detail-menu-item').index(this);
            localStorage.setItem("activeMenuIndex", index);
        });

        const $menuBtn = $('.detail-menu-toggle-btn');
        const $detailMenuModal = $('.detail-menu-modal');
        const $closeBtn = $('.detail-modal-close');

        $menuBtn.on('click', function() {
            $detailMenuModal.addClass('active');
            $('body').css('overflow', 'hidden');
        });

        $closeBtn.on('click', function() {
            $detailMenuModal.removeClass('active');
            $('body').css('overflow', '');
        });

        $(window).on('click', function(e) {
            if ($(e.target).is($detailMenuModal)) {
                $detailMenuModal.removeClass('active');
                $('body').css('overflow', '');
            }
        });
        $.ajax({
            url: "/mail/alertList",
            method: "POST",
            data: { employeeId: $("#employeeId").val() }
        }).done(function (resp) {
            $("#importantMailBox").text(resp.importantMailBox);
            $("#allMailBox").text(resp.allMailBox);
            $("#receiveMailBox").text(resp.receiveMailBox);
        });

    });
</script>
<script src="/js/mail/write.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>