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

    .writer-info {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
    }

    .profile-img {
        width: 30px;
        height: 30px;
        border-radius: 50%;
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        border: 1px solid #eee;
    }

    select {
        padding: 0 8px;  /* 좌우 여백 추가 */
        background-color: var(--md-sys-color-surface-bright);
        color: var(--md-sys-color-surface);
    }

    .modal-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        display: none;
        justify-content: center;
        align-items: center;
        z-index: 1000;
    }

    .modal-container {
        background-color: white;
        padding: 20px;
        border-radius: 4px;
        width: 100%;
        max-width: 500px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        position: relative;
    }

    .form-group {
        display: flex;
        margin-bottom: 15px;
        align-items: center;
    }

    .form-group label {
        width: 80px;
        flex-shrink: 0;
    }

    .form-group select,
    .form-group input[type="text"],
    .form-group input[type="date"] {
        flex-grow: 1;
        padding: 6px 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    .date-range {
        display: flex;
        align-items: center;
        gap: 5px;
    }

    .radio-group {
        margin-bottom: 15px;
    }

    .radio-group label {
        margin-right: 15px;
    }

    .search-button {
        width: 100%;
        padding: 8px;
        background-color: #999;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        margin-top: 10px;
    }

    .search-button:hover {
        background-color: #777;
    }
</style>
<form action="/approval/searchDetail" method="get" id="search-form">
    <div class="modal-overlay">
        <div class="modal-container">

            <div class="form-group">
                <label>양식</label>
                <select name="form">
                    <option value="">(선택)</option>
                    <option value="기안문">기안문</option>
                    <option value="휴가계">휴가계</option>
                    <option value="지출결의서">지출결의서</option>
                </select>
            </div>

            <div class="form-group">
                <label>기간</label>
                <div class="date-range">
                    <input type="date" name="startDate"> ~
                    <input type="date" name="endDate">
                </div>
            </div>

            <div class="form-group">
                <label>상태</label>
                <select name="state">
                    <option value="">(선택)</option>
                    <option value="WAITING">대기 중</option>
                    <option value="ONGOING">진행 중</option>
                    <option value="SUBMIT">완료</option>
                    <option value="REJECT">반려</option>
                </select>
            </div>

            <div class="form-group">
                <label>기안자</label>
                <input type="text" name="EMPLOYEENAME">
            </div>

            <div class="radio-group">
                <label>검색 조건</label>
                <input type="radio" name="searchType" id="r1" value="any" checked>
                <label for="r1">하나만 만족</label>
                <input type="radio" name="searchType" id="r2" value="all">
                <label for="r2">모두 만족</label>
            </div>

            <button class="search-button">검색</button>
        </div>
    </div>
</form>
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
                <form action="/approval/search/" method="get" class="searchForm">
                    <input type="text" name="keyword" placeholder="문서종류,기안자,제목" class="searchInput" />
                    <button type="submit" class="searchBtn">검색</button>
                </form>
            </div>
        </div>
        <div class="button-container">
            <select class="apBtnNewDoc">
                <option>새 기안 쓰기</option>
                <c:forEach var="form" items="${formList}">
                    <option value="${form.id}">${form.name}</option>
                </c:forEach>
            </select>
            <button class="secondary apBtnRefresh">상세 조회</button>
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
                                            <td class="apColWriter writer-info">
                                                <div class="profile-img" style="background-image: url('${i.PROFILEIMG}')"></div>
                                                <span>${i.DRAFTERNAME}</span>
                                            </td>
                                            <td class="apColDate">${i.REGDATE}</td>
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
                                        <td class="apColWriter writer-info">
                                            <div class="profile-img" style="background-image: url('${i.PROFILEIMG}')"></div>
                                            <span>${i.DRAFTERNAME}</span>
                                        </td>
                                        <td class="apColDate">${i.REGDATE}</td>
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
                                        <td class="apColWriter writer-info">
                                            <div class="profile-img" style="background-image: url('${i.PROFILEIMG}')"></div>
                                            <span>${i.DRAFTERNAME}</span>
                                        </td>
                                        <td class="apColDate">${i.REGDATE}</td>
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
                                        <td class="apColWriter writer-info">
                                            <div class="profile-img" style="background-image: url('${i.PROFILEIMG}')"></div>
                                            <span>${i.DRAFTERNAME}</span>
                                        </td>
                                        <td class="apColDate">${i.REGDATE}</td>
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
    const detailButtons = document.querySelectorAll('.secondary');
    const modalOverlay = document.querySelector('.modal-overlay');

    detailButtons.forEach(button => {
        button.addEventListener('click', () => {
            modalOverlay.style.display = 'flex';
        });
    });


    // 모달 외부 클릭 시 모달 숨기기
    modalOverlay.addEventListener('click', (e) => {
        if (e.target === modalOverlay) {
            modalOverlay.style.display = 'none';
        }
    });

    $(document).ready(function() {
        $('.detail-menu-item').on('click', function() {
            $('.detail-menu-item').removeClass('active');
            $(this).addClass('active');
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

        // 모달 외부 클릭 시 닫기
        $(window).on('click', function(e) {
            if ($(e.target).is($detailMenuModal)) {
                $detailMenuModal.removeClass('active');
                $('body').css('overflow', '');
            }
        });
    });

    $('#search-form').on('submit', function(e) {

        const form = $(this);


        const formValue = form.find('select[name="form"]').val();
        if (!formValue) {
            alert('양식을 선택해주세요.');
            return false;
        }


        const startDate = form.find('input[name="startDate"]').val();
        const endDate = form.find('input[name="endDate"]').val();
        if (!startDate || !endDate) {
            alert('기간을 선택해주세요.');
            return false;
        }

        const stateValue = form.find('select[name="state"]').val();
        if (!stateValue) {
            alert('상태를 선택해주세요.');
            return false;
        }

        const EMPLOYEENAME = form.find('input[name="EMPLOYEENAME"]').val();
        if (!EMPLOYEENAME) {
            alert('기안자를 입력해주세요.');
            return false;
        }

        if (startDate && endDate) {
            const start = new Date(startDate);
            const end = new Date(endDate);

            if (start > end) {
                alert('시작 날짜가 종료 날짜보다 늦을 수 없습니다.');
                return false;
            }
        }
        this.submit();
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
