<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<title>프로젝트 상세</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- Date Range Picker CSS & JS -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css"/>
<script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq"
        crossorigin="anonymous"></script>
<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

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
        border-right: 1px solid var(--md-sys-color-outline);
        z-index: 100;
        margin-top: 60px;
        transition: none;
    }

    .mainContainer {
        width: calc(100% - 200px); /* boxContents 전체 너비에서 mainHeader(200px)만큼 뺌 */
        margin-left: 200px; /* mainHeader 너비만큼 왼쪽 마진 */
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
        gap: 20px; /* 자식 요소들 간의 간격 */

    }

    .projectHeader {
        padding: 20px 0;
        border-bottom: 2px solid #f0f2f5;
        margin-bottom: 30px;
    }

    .projectHeader h2 {
        color: #2c3e50;
        font-size: 28px;
        margin-bottom: 10px;
    }

    .projectTime {
        color: #7f8c8d;
        font-size: 15px;
    }

    .movingBoard {
        gap: 25px;
        padding: 20px;
        background-color: #f8f9fa;
        border-radius: 15px;
        display: flex;
        justify-content: space-evenly;
        height: 80%;


    }

    .movingBoardColumn {
        width: 30%;
        background: #ffffff;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
    }

    .movingBoardColumn:hover {
        transform: translateY(-5px);
        box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
    }

    .column-title {
        font-size: 18px;
        font-weight: 600;
        color: #2c3e50;
        padding: 12px;
        margin-bottom: 15px;
        border-radius: 8px;
        text-align: center;
        background: linear-gradient(to right, #f8f9fa, #ffffff);
    }

    /* 작업 아이템 스타일링 */
    .work-item {
        background: #ffffff;
        border-radius: 10px;
        padding: 15px;
        margin-bottom: 12px;
        border: 1px solid #edf2f7;
        transition: all 0.3s ease;
    }

    .work-item:hover {
        transform: translateY(-3px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        border-color: #4a90e2;
    }

    .work-item h4 {
        color: #2c3e50;
        margin-bottom: 10px;
        font-size: 16px;
    }

    .priority {
        font-size: 12px;
        font-weight: 500;
        padding: 4px 10px;
        border-radius: 20px;
    }

    .priority.high {
        background: linear-gradient(45deg, #ff6b6b, #ff8787);
    }

    .priority.middle {
        background: linear-gradient(45deg, #ffd43b, #ffa931);
    }

    .priority.low {
        background: linear-gradient(45deg, #69db7c, #51cf66);
    }

    .detail-menu-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 10px 10px 0 10px;
        width: 100%;
        border-bottom: 1px solid var(--md-sys-color-outline);
    }


    .detail-menu-title {
        font-size: 18px;
        font-weight: 600;
        margin: 10px 0;
        display: flex;
        align-items: center;
        justify-content: start;
        gap: 8px;
    }

    .detail-menu-title .material-icons {
        font-size: 22px;
    }


    .detail-menu-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .detailMenuItem {
        display: flex;
        align-items: center;
        padding: 8px 12px;
        gap: 10px;
        cursor: pointer;
        transition: background-color 0.2s;
        border-radius: 4px;
        color: var(--md-sys-color-secondary);
    }

    .detailMenuItem:hover {
        background-color: #f5f5f5;
    }

    .detail-menu-disc {
        font-size: 12px;
    }

    .detail-menu-item > .material-icons {
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
        justify-content: flex-end;
        align-items: center;
        gap: 20px;
    }

    .search * {

        height: 25px !important;
    }

    /* 입력 필드나 버튼 등의 추가 스타일 필요시 */
    .search input,
    .search button,
    .search select {
        height: 25px;
        line-height: 25px;
        padding: 0 8px;
    }

    #searchBtn {
        font-size: 13px;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 0 12px;
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
        display: none; /* 기본적으로 숨김 */
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
        display: none; /* 기본적으로 숨김 */
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
            display: flex; /* 모바일에서만 보이게 */
        }

        .detail-modal-close {
            display: block; /* 모바일에서만 보이게 */
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
            margin-top: 30px; /* 닫기 버튼과의 간격 */
            max-height: 80vh;
            overflow-y: auto;
            padding-top: 10px; /* 리스트 상단 간격 */
        }

        .detail-menu-modal {
            display: none;
            position: absolute;
            top: 100%; /* 헤더 바로 아래에 위치 */
            width: 250px; /* 너비 250px로 설정 */
            right: 0;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            z-index: 1100;
            margin-top: 10px; /* 헤더와의 간격 */
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

        .projectTime {
            font-size: 1rem;
            color: #666;
        }

        /* 칸반보드 기본 스타일 */
        .movingBoard {
            display: flex;
            justify-content: space-evenly; /* 균등 분배 */
            gap: 20px;
            margin: 20px auto;
            padding: 10px;
            background: #f9f9f9;
            border-radius: 12px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 1400px;
            overflow: hidden;
        }

        /* 칸반 컬럼 스타일 */
        .movingBoardColumn {
            flex: 1;
            background: #ffffff;
            border-radius: 8px;
            padding: 15px;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.1);
            transition: 0.3s transform ease;
            min-height: 400px;
        }

        /* 컬럼 타이틀 스타일 */
        .column-title {
            text-align: center;
            font-size: 1.2rem;
            font-weight: bold;
            color: #444;
            padding: 10px 0;
            margin-bottom: 10px;
            background: #f1f1f1;
            border-radius: 8px;
        }

        /* 다른 상태에 따라 다른 배경색 */
        .ready-column {
            border: 2px solid #007bff; /* 시작전 */
        }

        .ongoing-column {
            border: 2px solid #f39c12; /* 작성중 */
        }

        .finish-column {
            border: 2px solid #28a745; /* 완료 */
        }

        /* 작업 아이템(카드) */
        .work-items {
            min-height: 300px;
            display: flex;
            flex-direction: column;
            gap: 15px; /* 작업 간격 */
        }

        /* 카드 스타일 */
        .work-item {
            background: #f8f9fa;
            border: 1px solid #e0e0e0;
            border-radius: 6px;
            padding: 10px 15px;
            cursor: grab;
            transition: transform 0.2s, background-color 0.3s;
        }

        .work-item:hover {
            transform: translateY(-5px);
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
            background: #ffffff;
        }

        .work-item:active {
            cursor: grabbing;
        }

        /* 우선순위 뱃지 */
        .priority {
            display: inline-block;
            padding: 5px 10px;
            font-size: 12px;
            font-weight: bold;
            color: #fff;
            border-radius: 12px;
            text-transform: uppercase;
        }

        .priority.high {
            background: #e74c3c;
        }

        /* 높은 우선순위 */
        .priority.middle {
            background: #f1c40f;
        }

        /* 중간 우선순위 */
        .priority.low {
            background: #2ecc71;
        }

        /* 낮은 우선순위 */
        /* 드래그 상태 강조 */
        .work-items.drag-over {
            background: rgba(0, 123, 255, 0.1);
            border: 2px dashed #007bff;
            border-radius: 8px;
        }

        .movingBoardColumn.drag-over {
            border: 2px dashed #007bff;
            background-color: rgba(0, 123, 255, 0.1);
        }

        .work-items {
            min-height: 300px;
            margin-top: 20px;
            cursor: grab;

        }

        /* 작업 카드 */
        .work-item {
            background: #ffffff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 10px;
            cursor: grab;
            transition: transform 0.2s;
        }


        .work-item:hover {
            transform: scale(1.03);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }


        .work-item h4 {
            font-size: 1.2rem;
            font-weight: bold;
            color: #444;
            margin: 0;
        }

        .priority {
            display: inline-block;
            padding: 5px 10px;
            font-size: 0.8rem;
            color: #fff;
            border-radius: 12px;
        }

        .priority.high {
            background: #ff6b6b;
        }

        .priority.middle {
            background: #ffa931;
        }

        .priority.low {
            background: #1dd1a1;
        }

        /* 드래그 오버 상태 */
        .drag-over {
            background: #f0f9ff;
            border: 2px dashed #00aaff;
            border-radius: 8px;
        }

        .closeBtn {
            display: flex;
            justify-content: flex-end; /* 오른쪽 정렬 */
            margin-bottom: 5px; /* 아래 내용과의 간격 */
        }

        .btn-close {
            padding: 0.15rem !important; /* 패딩 줄임 */
            font-size: 0.6rem !important; /* 글자 크기 줄임 */
            opacity: 0.5; /* 투명도 조절 */
        }

        .btn-close:hover {
            opacity: 1; /* 호버시 완전 불투명 */
        }


    }
</style>
<div class="mainHeader surface-bright">
    <div class="detail-menu-header">
        <div class="detail-menu-title">
            <span class="material-icons">mail</span>
            <span>Works</span>
        </div>
        <button class="detail-menu-toggle-btn">
            <span class="material-icons">menu</span>
        </button>
    </div>
    <div class="detail-menu-modal">
        <ul class="detail-menu-list">
            <li class="detailMenuItem">
                <span class="material-icons">star</span>
                <span>프로젝트 모음</span>
                <span class="detail-badge">5</span>
            </li>
            <li class="detailMenuItem">
                <span class="material-icons">all_inbox</span>
                <span>전체 메일함</span>
                <span class="detail-badge">32</span>
            </li>
            <li class="detailMenuItem">
                <span class="material-icons">send</span>
                <span>보낸 메일함</span>
            </li>
            <li class="detailMenuItem">
                <span class="material-icons">move_to_inbox</span>
                <span class="detail-menu-disc">받은 메일함</span>
                <span class="detail-badge">12</span>
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


        <div class="projectHeader">
            <h2>프로젝트 : ${project.name}</h2>
            <div class="projectTime">
                <span>기간: ${project.regDate} ~ ${project.deadLine}</span>

            </div>
            <a href="/work/write/${project.id}">
                <button>작성하기</button>
            </a>

        </div>

        <!-- 칸반보드 -->
        <div class="movingBoard">
            <!-- 시작전 -->
            <div class="movingBoardColumn ready-column surface-bright" data-state="READY">
                <h3 class="column-title">프로젝트 작업 진행전</h3>
                <div class="work-items">
                    <c:forEach items="${works}" var="work">
                        <c:if test="${work.state == 'READY'}">
                            <div class="work-item" draggable="true"
                                 data-work-id="${work.id}" onclick="openWorkModal(${work.id})">
                                <c:if test="${employee.role != 'TeamLeader'}">
                                    <div class="closeBtn">
                                        <button type="button" class="btn-close btn-sm"
                                                onclick="deleteWork(event, ${work.id})
                                                        "></button>
                                    </div>
                                </c:if>
                                <h4>${work.title}</h4>
                                <p class="priority ${work.priority.toLowerCase()}">${work.priority}</p>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>

            <!-- 작성중 -->
            <div class="movingBoardColumn ongoing-column surface-bright" data-state="ONGOING">
                <h3 class="column-title">프로젝트 작업 진행중</h3>


                <div class="work-items">
                    <c:forEach items="${works}" var="work">
                        <c:if test="${work.state == 'ONGOING'}">
                            <div class="work-item" draggable="true"
                                 data-work-id="${work.id}" onclick="openWorkModal(${work.id})">
                                <c:if test="${employee.role != 'TeamLeader'}">
                                    <div class="closeBtn">
                                        <button type="button" class="btn-close btn-sm"
                                                onclick="deleteWork(event, ${work.id})
                                                        "></button>
                                    </div>
                                </c:if>
                                <h4>${work.title}</h4>
                                <p class="priority ${work.priority.toLowerCase()}">${work.priority}</p>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>

            </div>

            <!-- 완료 -->
            <div class="movingBoardColumn finish-column surface-bright" data-state="FINISH">
                <h3 class="column-title">완료</h3>
                <div class="work-items">
                    <c:forEach items="${works}" var="work">
                        <c:if test="${work.state == 'FINISH'}">
                            <div class="work-item" draggable="true"
                                 data-work-id="${work.id}" onclick="openWorkModal(${work.id})">
                                <c:if test="${employee.role != 'TeamLeader'}">
                                    <div class="closeBtn">
                                        <button type="button" class="btn-close btn-sm"
                                                onclick="deleteWork(event, ${work.id})
                                                        "></button>
                                    </div>
                                </c:if> <h4>${work.title}</h4>
                                <p class="priority ${work.priority.toLowerCase()}">${work.priority}</p>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>

        <!-- 모달 구조 -->
        <div class="modal fade" id="workModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalTitle"></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- 업무 상세 정보 -->
                        <h5>게시물 type</h5>
                        <div id="workType">
                            <h2>게시물 type</h2></div>
                        <h5>중요도</h5>
                        <div id="workPriority"><h2>중요도</h2></div>
                        <h5>진행도</h5>
                        <div id="workState"><h2>진행도</h2></div>
                        <h5>기간</h5>
                        <div id="workDate"><h2>기간</h2></div>
                        <h5>내용</h5>
                        <div id="workContet"></div>

                        <!-- 파일 목록 표시 영역 -->
                        <div id="fileList"></div>


                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function deleteWork(event, workId) {
            // 이벤트 전파 차단
            // event.stopPropagation();
            console.log(workId);
            $.ajax({
                url: '/work/delete/',
                type: 'POST',
                data: {workId: workId},
                success: function (response) {
                    console.log('삭제 성공:', response);
                    location.reload();


                },
                error: function (error) {
                    console.error('저장 실패:', error);
                }
            });
        }


        function openWorkModal(workId) {
            $.ajax({
                url: '/work/detail/' + workId,
                type: 'GET',
                dataType: 'json',
                success: function (response) {
                    console.log(response);
                    const work = response.worksDTO;
                    const files = response.files;

                    $('#modalTitle').html(work.title);
                    $('#workType').html(work.type);
                    $('#workPriority').html(work.priority);
                    $('#workState').html(work.state);
                    $('#workDate').html(work.regDate + ' ~ ' + work.deadLine);
                    $('#workContent').html(work.content);

                    // 파일 목록 업데이트

                    let fileList = "";
                    if (files && files.length > 0) {
                        files.forEach(function (file) {
                            console.log(file);
                            fileList += '<li class="mb-2">' +
                                '<i class="bi bi-paperclip"></i> ' +
                                '<a href="/download/' + file.filesId +
                                '" class="text-decoration-none">' +

                                file.originFileName
                                + '</a></li>';
                        });

                    } else {
                        filesList = '<li>첨부된 파일이 없습니다.</li>';
                    }
                    $('#fileList').html(fileList);

                    // 모달 표시
                    $('#workModal').modal('show');
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                    console.error('Status:', status);
                    console.error('Response:', xhr.responseText);
                    alert('데이터를 불러오는데 실패했습니다.');
                }
            });


        }

        // 모달 코드


        $(document).ready(function () {
            let dragged = null;

            $('.work-item').on('dragstart', function (e) {
                dragged = this;

            });

            $('.work-item').on('dragend', function (e) {
                dragged = null;

                // 드래그가 끝난 후 처리할 일이 있다면 여기에 작성
            });

            $('.work-item').on('drag', function (e) {
                // 드래그 중에 처리할 일이 있다면 여기에 작성
            });

            $('.movingBoardColumn'
            ).on('drop', function (e) {
                console.log("도착");
                e.preventDefault();
                $(this).append(dragged);

                const columnState = $(this).data('state');
                const workItemId = $(dragged).data('work-id');

                $(this).find('.work-items').append(dragged);
                console.log(columnState);
                console.log(workItemId);
                $.ajax({
                    url: '/work/updateState',
                    type: 'POST',

                    data: {
                        workItemId: workItemId,
                        state: columnState
                    },

                    success: function (response) {
                        console.log('저장 성공:', response);
                    },
                    error: function (error) {
                        console.error('저장 실패:', error);
                    }
                });
            });

            $('.movingBoardColumn').on('dragover', function (e) {
                e.preventDefault();
            });

        });


    </script>

    <jsp:include page="/WEB-INF/views/template/footer.jsp"/>
