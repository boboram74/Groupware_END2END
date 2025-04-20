<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<title>프로젝트 상세</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/template/exam.css"/>
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
        width: calc(100% - 200px);
        margin-left: 200px;
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
        border: 1px solid #dadaeb;
        overflow-y: auto;
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
        width: 50px;
    }

    .priority.middle {
        background: linear-gradient(45deg, #ffd43b, #ffa931);
        width: 60px;
    }

    .priority.low {
        background: linear-gradient(45deg, #69db7c, #51cf66);
        width: 50px;
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


    .search select,
    .search input {

        border: none;
        border-radius: 8px;
        font-size: 0.95rem;
        outline: none;
    }

    .search select {
        background-color: #f9fafc;
        color: #333;
    }

    .search input {
        width: 220px;
        background-color: #ffffff;
    }

    .search button {
        background-color: #3a4b76;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 8px;
        cursor: pointer;
        font-weight: bold;
        display: flex;
        align-items: center;
        gap: 5px;
    }

    .search button:hover {
        background-color: #2b3b5b;
    }

    #writeBtn {
        background-color: #1f2a44;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 8px;
        margin-top: 10px;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s ease, box-shadow 0.3s ease;
    }

    #writeBtn:hover {
        background-color: #2b3b5b; /* 더 밝은 남색 */
        box-shadow: 0 4px 10px rgba(31, 42, 68, 0.3); /* 약한 그림자 */
    }


    .finishBtnDiv {
        margin-top: 15px;
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

    #finishProjectBtn {
        background-color: #1f2a44;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 10px;
        font-weight: bold;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s ease, transform 0.2s ease;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    #finishProjectBtn:hover {
        background-color: #162036;
        transform: translateY(-2px);
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


</style>

<c:if test="${project.status eq 'finish'}">
    <script>
        window.addEventListener('DOMContentLoaded', function () {
            disableProjectFeatures();
        });
    </script>
</c:if>
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
            <li class="detail-menu-item" onclick="location.href='/project/main'">
                <span class="material-icons">star</span>
                <span>Works 메인</span>
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

                    <option value="title" name="title">제목</option>
                    <option value="name" name="name">작성자</option>

                </select>
            </div>
            <div class="searchInput">
                <input id="input" type="text" name="keyword" placeholder="검색어 입력">
            </div>
            <div>
                <button id="searchBtn" onclick="submitSearchData(${project.id})"><span
                        class="material-icons">search</span> 검색
                </button>
            </div>
        </div>

        <div class="projectHeader">
            <h2>프로젝트 : ${project.name}</h2>
            <div class="projectTime">
                <span>기간: ${project.deadLine}</span>

            </div>
            <a href="/work/write/${project.id}">
                <button id="writeBtn" }>작성하기</button>
            </a>

                <div id="finishBtnDiv" class="finishBtnDiv">

                </div>

        </div>

        <!-- 칸반보드 -->
        <div class="movingBoard">
            <!-- 시작전 -->
            <div class="movingBoardColumn ready-column surface-bright" data-state="READY">
                <h3 class="column-title">READY</h3>
                <div class="work-items">
                    <c:forEach items="${works}" var="work">
                        <c:if test="${work.state == 'READY'}">
                            <div class="work-item" draggable="true"
                                 data-projectId="${work.projectId}"
                                 data-work-id="${work.id}"
                                 data-employee-id="${work.employeeId}"
                                 onclick="openWorkModal(${work.id}, ${work.employeeId})">
                                <c:if test="${employee.role != 'TeamLeader'}">
                                    <div class="closeBtn">
                                        <button type="button" class="btn-close btn-sm"
                                                onclick="event.stopPropagation(); deleteWork(${work.id});">
                                        </button>
                                    </div>
                                </c:if>

                                <h4>제목 : ${work.title}</h4>
                                <h4>작성자 :${work.departmentName} ${work.employeeName} ${work.jobName}</h4>
                                <input type="hidden" name="id" value="${work.employeeId}">
                                <p class="priority ${work.priority.toLowerCase()}">${work.priority}</p>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>

            <!-- 작성중 -->
            <div class="movingBoardColumn ongoing-column surface-bright" data-state="ONGOING">
                <h3 class="column-title">ONGOING</h3>
                <div class="work-items">
                    <c:forEach items="${works}" var="work">
                        <c:if test="${work.state == 'ONGOING'}">
                            <div class="work-item" draggable="true"
                                 data-projectId="${work.projectId}"
                                 data-work-id="${work.id}"
                                 data-employee-id="${work.employeeId}"
                                 onclick="openWorkModal(${work.id}, ${work.employeeId})">
                                <c:if test="${employee.role != 'TeamLeader'}">
                                    <div class="closeBtn">
                                        <button type="button" class="btn-close btn-sm"
                                                onclick="event.stopPropagation(); deleteWork(${work.id});">
                                        </button>
                                    </div>
                                </c:if>
                                <h4>제목 : ${work.title}</h4>
                                <h4>작성자 :${work.departmentName} ${work.employeeName} ${work.jobName}</h4>
                                <input type="hidden" name="id" value="${work.employeeId}">
                                <p class="priority ${work.priority.toLowerCase()}">${work.priority}</p>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>

            </div>

            <!-- 완료 -->
            <div class="movingBoardColumn finish-column surface-bright" data-state="FINISH">
                <h3 class="column-title">FINISH</h3>
                <div class="work-items">
                    <c:forEach items="${works}" var="work">
                        <c:if test="${work.state == 'FINISH'}">
                            <div class="work-item" draggable="true"
                                 data-projectId="${work.projectId}"
                                 data-work-id="${work.id}"
                                 data-employee-id="${work.employeeId}"
                                 onclick="openWorkModal(${work.id}, ${work.employeeId})">
                                <c:if test="${employee.role == 'TeamLeader'}">

                                    <div class="closeBtn">
                                        <button type="button" class="btn-close btn-sm"
                                                onclick="event.stopPropagation(); deleteWork(${work.id});">
                                        </button>
                                    </div>
                                </c:if>   <h4>제목 : ${work.title}</h4>
                                <h4>작성자 :${work.departmentName} ${work.employeeName} ${work.jobName}</h4>
                                <input type="hidden" name="id" value="${work.employeeId}">

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
                        <h5>게시물 type</h5>
                        <div id="workType">
                            <h2>게시물 type</h2></div>

                        <h5>중요도</h5>
                        <div id="workPriority"><h2>중요도</h2></div>
                        <h5>진행도</h5>
                        <div id="workState"><h2>진행도</h2></div>
<%--                        <h5>기간</h5>--%>
<%--                        <div id="workDate"><h2>기간</h2></div>--%>
                        <h5>내용</h5>
                        <div id="workContent"></div>
                        <h5>파일 리스트</h5>
                        <div id="fileList"></div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>


                        <button type="button" class="btn btn-primary" id="updateBtn"
                                onclick="openupdateModal(currentWorkId)">
                            수정하기
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!-- 모달 구조 -->
        <div class="modal fade" id="updateModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="updateForm">
                        <div class="modal-body">
                            <input type="hidden" name="id"/>
                            <input type="hidden" name="projectId" value="${project.id}"/>

                            <h5>게시물 title</h5>
                            <div id="updateTitle">

                            </div>
                            <h5>게시물 type</h5>
                            <div id="updateType">
                            </div>
                            <h5>중요도</h5>
                            <div id="updatePriority"></div>
                            <h5>진행도</h5>
                            <div id="updateState"></div>
<%--                            <h5>기간</h5>--%>
<%--                            <div id="updateDate"></div>--%>
                            <h5>내용</h5>
                            <div id="updateContet"></div>
                            <h5>파일 리스트</h5>
                            <div id="updatefileList"></div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                                    onclick="closeupdateModal() ">Close
                            </button>
                            <button type="submit" class="btn btn-primary">수정완료</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>

            const employeeRole = "${employee.role}";

            function submitSearchData(projectId) {
                $.ajax({
                    url: '/work/search/' + projectId,
                    type: 'POST',
                    data: {
                        keyword: $('#input').val(),
                        searchOption: $('#searchOption').val(),

                    },

                    success: function (response) {
                        $(`.movingBoardColumn[data-state="` + "READY" + `"]`).empty();
                        $(`.movingBoardColumn[data-state="` + "ONGOING" + `"]`).empty();
                        $(`.movingBoardColumn[data-state="` + "FINISH" + `"]`).empty();
                        // 응답이 리스트라고 가정 (List<ProjectWorkDTO>)
                        response.forEach(function (work) {


                            const closeBtnHtml = (employeeRole === 'TeamLeader' || work.isMine) ? `
                       <div class="closeBtn">
                       <button type="button" id="deleteBtn" class="btn-close btn-sm" onclick="deleteWork(` + work.id + `)"></button>
                       </div>
                      ` : '';

                            const itemHtml = `
                               <h3 class="column-title">` + work.state + `</h3>
                         <div class="work-item" draggable="true"
                          data-work-id="${work.id}"
                            data-employee-id="` + work.employeeId + `"
                         onclick="openWorkModal(` + work.id + `, ` + work.employeeId + `)">
                          ` + closeBtnHtml + `
                            <h4>제목 : ` + work.title + `</h4>
                            <h4>작성자 :  ` + work.employeeName + `</h4>
                            <p class="priority ` + work.priority.toLowerCase() + `">` + work.priority + `</p>
                          </div>
                        `;

                            let temp = $(itemHtml);
                            if (work.state == 'READY') {
                                $(`.movingBoardColumn[data-state="` + work.state + `"]`).append(itemHtml);


                            } else if (work.state === 'ONGOING') {
                                $(`.movingBoardColumn[data-state="` + work.state + `"]`).append(itemHtml);
                                // $('.ongoing-column .work-items').append(itemHtml);
                            } else if (work.state === 'FINISH') {
                                $(`.movingBoardColumn[data-state="` + work.state + `"]`).append(itemHtml);
                            }
                        });
                    },
                    error: function (xhr) {
                        console.error('검색 실패:', xhr);
                    }
                });
            }

            let currentWorkId = null;
            const loggedInEmployeeId = ${employee.id};
            function openWorkModal(workId, employeeId) {
                currentWorkId = workId;
                $.ajax({
                    url: '/work/detail/' + workId,
                    type: 'GET',
                    dataType: 'json',
                    success: function (response) {
                        const work = response.worksDTO;
                        const files = response.files;

                        $('#modalTitle').html(work.title);
                        $('#workType').html(work.type);
                        $('#workPriority').html(work.priority);
                        $('#workState').html(work.state);
                        $('#workDate').html(work.regDate + "~" + work.deadLine);
                        $('#workContent').html(work.content);
                        $('.work-item').append('<input type="hidden" name="projectId" value="' + workId + '">');

                        // 파일 목록 업데이트
                        let fileList = "";
                        if (files && files.length > 0) {
                            files.forEach(function (file) {
                                fileList += '<li class="mb-2">' +
                                    '<i class="bi bi-paperclip"></i> ' +
                                    '<a href="/file/download?path=' + file.path +
                                    '" class="text-decoration-none">' +

                                    file.originFileName
                                    + '</a>'
                                    + '<input type="hidden" name="fileId" value="' + file.id + '">'
                                    + '</li>';
                            });

                        } else {
                            fileList = '<li>첨부된 파일이 없습니다.</li>';
                        }
                        $('#fileList').html('<ul>' + fileList + '</ul>');
                        if (employeeId == ${employee.id}) {
                            $('#updateBtn').show();
                        } else {
                            $('#updateBtn').hide();
                        }


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


            $('#updateForm').submit(function (e) {
                e.preventDefault();
                const formData = new FormData(this);
                for (const [key, value] of formData.entries()) {

                }
                $.ajax({
                    url: '/work/update',
                    data: formData,
                    type: 'POST',
                    processData: false,
                    contentType: false,
                    enctype: 'multipart/form-data',
                    error: function (xhr, status, error) {
                        console.error('Error:', error);
                        console.error('Status:', status);
                        console.error('Response:', xhr.responseText);
                    }
                }).done(function (response) {
                    alert("글이 정상적으로 수정되었습니다.");
                    location.reload();


                })
            })


            function deleteWork(workId) {

                if (confirm("정말 삭제하시겠습니까?")) {
                    $.ajax({
                        url: '/work/delete/',
                        type: 'POST',
                        data: {workId: workId},
                        success: function (response) {
                            location.reload();
                        },
                        error: function (error) {
                            console.error('저장 실패:', error);
                        }
                    });
                }
            }

            function openupdateModal(currentWorkId) {
                $('#updateModal').modal('show');
                // 이전 내용 초기화
                $('#updateTitle').html('');
                $('#updateType').html('');
                $('#updatePriority').html('');
                $('#updateState').html('');
                $('#updateDate').html('');
                $('#updateContet').html('');
                $('#updatefileList').html('');

                $.ajax({
                    url: '/work/detail/' + currentWorkId,
                    type: 'GET',

                    success: function (response) {
                        const work = response.worksDTO;
                        const files = response.files;
                        // 값 가져오고있음
                        $('input[name="id"]').val(currentWorkId);
                        $('#updateTitle').html(`
  <input type="text" class="form-control" name="title" value="` + work.title + `">
`);

                        $('#updateType').html(`
                <select class="form-select" name="type">
                    <option value="DOCUMENT"` + work.type + ` == 'DOCUMENT' ? 'selected' : ''>문서</option>
                    <option value="REPORT"` + work.type + `== 'REPORT' ? 'selected' : ''>보고서</option>
   <option value="WBS"` + work.type + `== 'WBS' ? 'selected' : ''>WBS</option>
   <option value="MEETING"` + work.type + `== 'MEETING' ? 'selected' : ''>회의록</option>
   <option value="SPECIFICATION"` + work.type + `== 'SPECIFICATION' ? 'selected' : ''>명세서</option>
                </select>`);

                        $('#updatePriority').html(`
                <select class="form-select" name="priority">
                    <option value="HIGH"` + work.priority + ` == 'HIGH' ? 'selected' : ''>높음</option>
                    <option value="MIDDLE"` + work.priority + ` == 'MIDDLE' ? 'selected' : ''>중간</option>
                    <option value="LOW" ` + work.priority + `== 'LOW' ? 'selected' : ''>낮음</option>
                </select>`);

                        $('#updateState').html(`
                <select class="form-select" name="state">
                    <option value="READY" ` + work.state + ` == 'READY' ? 'selected' : ''>해야 할 일</option>
                    <option value="ONGOING"` + work.state + ` == 'ONGOING' ? 'selected' : ''}>진행중</option>
                    <option value="FINISH"` + work.state + ` == 'FINISH' ? 'selected' : ''}>완료</option>
                </select>`);

                        $('#updateDate').html(`<input type="date" class="form-control" name="deadLine" value="` + work.deadLine + `" >`);

                        $('#updateContet').html(`
                <textarea class="form-control" name="content">` + work.content + ` </textarea>`);

                        $('#updatefileList').append('<input type="file" class="form-control" name="files" multiple>');
                        let fileList = '';
                        if (files && files.length > 0) {
                            files.forEach(file => {
                                fileList +=
                                    '<li>'
                                    + '<a href="/file/download?path=' + file.path +
                                    '" class="text-decoration-none">' +
                                    file.originFileName
                                    + '</a>'
                                    + '<input type="hidden" name="fileId" value="' + file.id + '">'
                                    + '<button type="button" onClick="$(this).parent().remove();">삭제</button>' + '</li>';
                            });
                        } else {
                            fileList = '<li>첨부된 파일이 없습니다.</li>';
                        }


                        $('#updatefileList').append('<ul>' + fileList + '</ul>');
                    },
                    error: function (xhr, status, error) {
                        console.error('수정 모달 데이터 실패:', error);
                        alert('작업 데이터를 불러오는 데 실패했습니다.');
                    }
                });
            }

            function closeupdateModal() {
                $('#updateModal').modal('hide');
            }

            function updateClick(currentWorkId) {
                let dtobox = {

                    title: $('#updateTitle input').val(),
                    type: $('#updateType select').val(),
                    priority: $('#updatePriority select').val(),
                    state: $('#updateState select').val(),
                    regDate: $('input[name=regDate]').val(),
                    deadLine: $('input[type="date"][name=deadLine]').val(),
                    content: $('#updateContet textarea').val(),
                    id: currentWorkId

                };

                // let files =
                //     $("#updatefileList")[0].files;
                // for (let i = 0; i < files.length; i++) {
                //     formData.append("files", files[i]);
                // }

                // $.ajax({
                //     url: '/work/update',
                //     type: 'POST',
                //     data: {"dto": dtobox},
                //
                //     success: function (result) {
                //         if (result) {
                //             alert("글이 정상적으로 수정되었습니다.");
                //             $('#updateModal').modal('hide');
                //             location.reload();
                //
                //         }
                //
                //     }
                // })
            }

            // 모달 코드
            $(document).ready(function () {
                let dragged = null;


                $('.work-item').on('dragstart', function (e) {
                    dragged = this;

                });

                $('.work-item').on('dragend', function (e) {
                    dragged = null;

                });

                $('.work-item').on('drag', function (e) {

                });
                $(document).on('click', '#finishProjectBtn', function () {
                    const projectId = ${projectId};
                    finishWork(projectId);
                    disableProjectFeatures();
                });


                function finishWork(projectId) {
                    if (confirm("정말 프로젝트 작업을 마감하시겠습니까?")) {
                        $.ajax({
                            url: '/work/finish',
                            type: 'POST',
                            data: {projectId: projectId},
                            success: function (response) {
                                alert("프로젝트가 마감되었습니다.");
                                disableProjectFeatures();

                            },
                            error: function (error) {
                                console.error("마감 실패:", error);
                                alert("마감 처리 중 오류가 발생했습니다.");
                            }
                        });
                    }
                }

                function disableProjectFeatures() {

                    $('#writeBtn, #deleteBtn, #updateBtn').prop('disabled', true).css('cursor', 'not-allowed');
                    $('.work-item').removeAttr('draggable').css('cursor', 'not-allowed');
                    $('.movingBoardColumn').off('dragover drop');
                    $('.work-item').off('dragstart dragend');
                }

                // function disableProjectFeatures() {
                //
                //     $('#writeBtn,#deleteBtn, #updateBtn').prop('disabled', true);
                //
                //     $('.work-item').removeAttr('draggable');
                //     $('.btn-close').prop('disabled', true);
                //
                //     // $('.work-item').attr('draggable', false);
                //
                //     $('.movingBoardColumn').off('dragover drop');
                //     $('.work-item').off('dragstart dragend');
                //
                // }

                $('.movingBoardColumn'
                ).on('drop', function (e) {
                    e.preventDefault();
                    $(this).append(dragged);

                    const columnState = $(this).data('state');
                    const projectId = $(dragged).data('projectid');
                    const workItemId = $(dragged).data('work-id');
                    $(this).find('.work-items').append(dragged);

                    const formData = new FormData();
                    formData.append('workItemId', workItemId);
                    formData.append('projectId', projectId);
                    formData.append('state', columnState);

                    for (let pair of formData.entries()) {

                    }
                    $.ajax({
                        url: '/work/updateState',
                        type: 'POST',
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function (response) {
                            if (response == 0) {

                                $('#finishProjectBtn').remove();
                                $(`.finishBtnDiv`).append(`
                                     <button id="finishProjectBtn" class="btn btn-primary">
                                     프로젝트 마감
                                    </button> `);
                            } else {

                                location.reload();
                            }


                        },
                        error: function (error) {
                            console.error('저장 실패:', error);
                        }
                    });
                });


                $('.movingBoardColumn').on('dragover', function (e) {
                    e.preventDefault();
                })
            })

        </script>

        <jsp:include page="/WEB-INF/views/template/footer.jsp"/>
