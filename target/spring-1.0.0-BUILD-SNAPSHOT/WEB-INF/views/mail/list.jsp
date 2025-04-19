<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/template/exam.css" />
<link rel="stylesheet" href="/css/mail/mail-list.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
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
<%--            <li class="detail-menu-item" onclick="location.href='/mail/temp'">--%>
<%--                <span class="material-icons">drafts</span>--%>
<%--                <span>임시 저장함</span>--%>
<%--                <span class="detail-badge">2</span>--%>
<%--            </li>--%>
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
        <div class="search">
            <div>
                <select id="searchOption">
                    <option>제목 </option>
                    <option>보낸 사람 </option>
                </select>
            </div>
            <div class="searchInput">
                <input id="input" type="text" name="keyword" placeholder="검색할 키워드 입력">
            </div>
            <div>
                <button id="searchBtn" type="button"><span class="material-icons">search</span> 검색</button>
            </div>
        </div>
        <div class="button-container">
            <button class="primary" onclick="location.href='/mail/write'">메일쓰기</button>
        </div>
        <div class="titleArea">
            <h4>전체 메일 (<span id="recordCount"></span>)</h4>
            <h4>안읽은 메일 (<span id="recordReadCount"></span>)</h4>
        </div>
        <div class="content board-table-container">
            <table class="mailList board-table">
                <thead>
                <tr>
                    <th><input style="zoom: 1.5;" type="checkbox" id="checkAll"></th>
                    <th>중요</th>
                    <th>보낸사람</th>
                    <th></th>
                    <th>제목</th>
                    <th>발송 일자</th>
                </tr>
                </thead>
                <tbody class="surface-bright" id="mailBody">
                </tbody>
                <tfoot id="buttons"></tfoot>
            </table>
        </div>
        <div class="pageNavi">
        </div>
        <div class="button-container">
            <button class="primary" type="button" id="readBtn">읽음</button>
            <button class="secondary" type="button" id="trashBtn">휴지통</button>
        </div>
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
<script src="/js/mail/list.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>