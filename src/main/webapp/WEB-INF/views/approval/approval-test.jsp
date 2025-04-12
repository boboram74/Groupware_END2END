<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/template/exam.css" />
<link rel="stylesheet" href="/css/mail/mail-list.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<style>
    .approval-list-wrapper {
        display: flex;
        flex-direction: column;
        gap: 20px;
    }
</style>
<div class="mainHeader surface-bright">
    <div class="detail-menu-header">
        <div class="detail-menu-title">
            <span class="material-icons">description</span>
            <span>전자 결재</span>
        </div>
        <button class="detail-menu-toggle-btn">
            <span class="material-icons">menu</span>
        </button>
    </div>
    <div class="detail-menu-modal">
        <ul class="detail-menu-list">
            <li class="detail-menu-item">
                <span class="material-icons">star</span>
                <span>자주 쓰는 문서</span>
                <span class="detail-badge"><span>1</span></span>
            </li>
            <li class="detail-menu-item">
                <span class="material-icons">star</span>
                <span>중요 문서함</span>
                <span class="detail-badge"><span>1</span></span>
            </li>
            <li class="detail-menu-item">
                <span class="material-icons">person</span>
                <span>나의 전자결재</span>
            </li>
            <li class="detail-menu-item">
                <span class="material-icons">description</span>
                <span class="detail-menu-disc">전자 결재함</span>
                <span class="detail-badge"><span>1</span></span>
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
                    <option>보낸 사람 </option>
                    <option>내용 </option>
                    <option>제목 </option>
                </select>
            </div>
            <div class="searchInput">
                <input id="input" type="text" name="keyword" placeholder="중요메일함">
            </div>
            <div>
                <button id="searchBtn"><span class="material-icons">search</span> 검색</button>
            </div>
        </div>
        <div class="button-container">
            <select class="apBtnNewDoc">
                <option>새 기안 쓰기</option>
                <c:forEach var="form" items="${formList}">
                    <option value="${form.id}">${form.name}</option>
                </c:forEach>
            </select>
            <button class="secondary" onclick="location.href='/mail/write'">상세 조회</button>
        </div>
        <div class="approval-list-wrapper">
            <div class="box surface-bright">
                <div class="box-title">
                    결재 대기 중
                </div>
                <div class="box-content">
                    <table class="board-table">
                        <thead>
                        <tr>
                            <th class="apColStar"></th>
                            <th class="apColTitle">제목</th>
                            <th class="apColStatus">결재 상태</th>
                            <th class="apColWriter">기안자</th>
                            <th class="apColDate">기안일</th>
                            <th class="apColType">문서 종류</th>
                        </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty waitingList}">
                                    <tr>
                                        <td colspan="6" class="emptyMessage">대기 중인 문서가 없습니다.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="i" items="${waitingList}">
                                        <tr>
                                            <td class="apColStar">★</td>
                                            <td class="apColTitle title" onClick="location.href='/approval/detail/${i.ID}'">${i.TITLE}</td>
                                            <td class="apColStatus">결재 대기중</td>
                                            <td class="apColWriter">${i.DRAFTERNAME}</td>
                                            <td class="apColDate">${i.REGDATE}"</td>
                                            <td class="apColType">${i.FORMNAME}</td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="box surface-bright">
                <div class="box-title">
                    결재 진행 중
                </div>
                <div class="box-content">
                    <table class="board-table">
                        <thead>
                        <tr>
                            <th class="apColStar"></th>
                            <th class="apColTitle">제목</th>
                            <th class="apColStatus">결재 상태</th>
                            <th class="apColWriter">기안자</th>
                            <th class="apColDate">기안일</th>
                            <th class="apColType">문서 종류</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${empty goingList}">
                                <tr>
                                    <td colspan="6" class="emptyMessage">진행 중인 문서가 없습니다.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="i" items="${goingList}">
                                    <tr>
                                        <td class="apColStar">★</td>
                                        <td class="apColTitle title" onClick="location.href='/approval/detail/${i.ID}'">${i.TITLE}</td>
                                        <td class="apColStatus">결재 진행중</td>
                                        <td class="apColWriter">${i.DRAFTERNAME}</td>
                                        <td class="apColDate">${i.REGDATE}"</td>
                                        <td class="apColType">${i.FORMNAME}</td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="box surface-bright">
                <div class="box-title">
                    결재 완료
                </div>
                <div class="box-content">
                    <table class="board-table">
                        <thead>
                        <tr>
                            <th class="apColStar"></th>
                            <th class="apColTitle">제목</th>
                            <th class="apColStatus">결재 상태</th>
                            <th class="apColWriter">기안자</th>
                            <th class="apColDate">기안일</th>
                            <th class="apColType">문서 종류</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${empty completedList}">
                                <tr>
                                    <td colspan="6" class="emptyMessage">완료된 문서가 없습니다.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="i" items="${completedList}">
                                    <tr>
                                        <td class="apColStar">★</td>
                                        <td class="apColTitle" onClick="location.href='/approval/detail/${i.ID}'">${i.TITLE}</td>
                                        <td class="apColStatus">결재 완료</td>
                                        <td class="apColWriter">${i.DRAFTERNAME}</td>
                                        <td class="apColDate">${i.REGDATE}"</td>
                                        <td class="apColType">${i.FORMNAME}</td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="box surface-bright">
                <div class="box-title">
                    반려 문서
                </div>
                <div class="box-content">
                    <table class="board-table">
                        <thead>
                        <tr>
                            <th class="apColStar"></th>
                            <th class="apColTitle">제목</th>
                            <th class="apColStatus">결재 상태</th>
                            <th class="apColWriter">기안자</th>
                            <th class="apColDate">기안일</th>
                            <th class="apColType">문서 종류</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${empty reject}">
                                <tr>
                                    <td colspan="6" class="emptyMessage">반려된 문서가 없습니다.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="i" items="${reject}">
                                    <tr>
                                        <td class="apColStar">★</td>
                                        <td class="apColTitle title" onClick="location.href='/approval/detail/${i.ID}'">${i.TITLE}</td>
                                        <td class="apColStatus">반려</td>
                                        <td class="apColWriter">${i.DRAFTERNAME}</td>
                                        <td class="apColDate">${i.REGDATE}"</td>
                                        <td class="apColType">${i.FORMNAME}</td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
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

    $(".apBtnNewDoc").on("change", function () {
        let selectDoc = $(this).val();
        if (selectDoc) {
            let url = "/approval/write/" + selectDoc;
            window.open(url, "new", "width=1000,height=1000");
        }
    });
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
