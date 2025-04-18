<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/mail/detail.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<style>
    * {
        /*border: 1px solid red;*/
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
        margin-top: 50px;
        transition: none;
    }

    .mainContainer {
        width: calc(100% - 200px);
        margin-left: 200px;
        min-height: 100vh;
        background-color: #f5f5f5;
        padding: 20px;
        display: flex;
        justify-content: center;
        transition: none;
    }

    .mainBody {
        max-width: 1200px;
        width: 100%;
        padding: 0;
        gap: 20px;
        display: flex;
        flex-direction: column;
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

    .detail-menu-item a {
        display: flex;
        align-items: center;
        gap: 10px;
        text-decoration: none;
        color: inherit;
        width: 100%;
        height: 100%;
    }

    .detail-menu-item a .material-icons {
        font-size: 18px;
        color: #757575;
    }

    .detail-menu-item a:hover {
        text-decoration: none;
        color: inherit;
    }


    .search * {
        height: 25px !important;
    }

    .search input,
    .search button,
    .search select {
        height: 25px;
        line-height: 25px;
        padding: 0 8px;
    }

    .detail-menu-modal {
        position: relative;
    }

    .detail-menu-toggle-btn {
        display: none;
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

    .detail-modal-close {
        display: none;
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
            display: flex;
        }

        .detail-modal-close {
            display: block;
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
            margin-top: 30px;
            max-height: 80vh;
            overflow-y: auto;
            padding-top: 10px;
        }

        .detail-menu-modal {
            display: none;
            position: absolute;
            top: 100%;
            width: 250px;
            right: 0;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            z-index: 1100;
            margin-top: 10px;
        }

        .detail-menu-modal.active {
            display: block;
        }
    }

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
            <a href="/mail/important">
                <li class="detail-menu-item">
                    <span class="material-icons">star</span>
                    <span>중요 메일함</span>
                    <span class="detail-badge"><span id="importantMailBox"></span></span>
                </li>
            </a>
            <a href="/mail/list">
                <li class="detail-menu-item">
                    <span class="material-icons">all_inbox</span>
                    <span>전체 메일함</span>
                    <span class="detail-badge"><span id="allMailBox"></span></span>
                </li>
            </a>
            <a href="/mail/sendList">
                <li class="detail-menu-item">
                    <span class="material-icons">send</span>
                    <span>보낸 메일함</span>
                </li>
            </a>
            <a href="/mail/inbox">
                <li class="detail-menu-item">
                    <span class="material-icons">move_to_inbox</span>
                    <span class="detail-menu-disc">받은 메일함</span>
                    <span class="detail-badge"><span id="receiveMailBox"></span></span>
                </li>
            </a>
<%--            <a href="/mail/temp">--%>
<%--                <li class="detail-menu-item">--%>
<%--                    <span class="material-icons">drafts</span>--%>
<%--                    <span>임시 저장함</span>--%>
<%--                    <span class="detail-badge">2</span>--%>
<%--                </li>--%>
<%--            </a>--%>
            <a href="/mail/trash">
                <li class="detail-menu-item">
                    <span class="material-icons">delete</span>
                    <span>휴지통</span>
                </li>
            </a>
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
                        <label>보낸 사람</label>
                        <input type="hidden" id="sender" value=${employee.email}>
                        <input type="text" id="receiveMail" name="sender" value="${list.sender}" readonly>
                        <button class="addressBtn">주소록</button>
                    </div>
                    <div class="formGroup">
                        <label>제목</label>
                        <input type="text" id="inputTitle" name="title" value="${list.subject}" readonly>
                    </div>
                    <div class="formGroup">
                        <label>파일 첨부</label>
                        <div class="dragDropArea" id="dropArea">
                            <c:forEach var="i" items="${fileList}">
                                <div class="fileItem">
                                    <span class="material-icons">attachment</span>
                                    <a href="http://34.70.179.192/mail/files?path=${i.path}">
                                            ${i.originFileName}
                                    </a>&nbsp;
                                    <span class="fileItemSize" data-size="${i.fileSize}"></span>
                                </div>
                            </c:forEach>
                        </div>
                        <input type="file" id="fileInput" style="display:none;" multiple>
                        <span class="fileSize">0/30 MB</span>
                    </div>
                </div>
                <div class="mainBody">
                    <textarea id="mailContent" name="content" readonly>${list.content}</textarea>
                    <div class="buttons">
                        <button type="submit">답장하기</button>
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
<script src="/js/mail/detail.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>