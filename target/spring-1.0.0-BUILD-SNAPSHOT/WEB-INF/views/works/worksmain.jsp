<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="/WEB-INF/views/template/header.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"/>

    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>

</head>
<body>
<script
        src="https://code.jquery.com/jquery-3.3.1.min.js"
        integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
        crossorigin="anonymous"
></script>

<script
        src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"
></script>
<script
        src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"
></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet" href="/css/worksmain.css">

<style>
    tbody tr:hover {
        background-color: #f0f8ff;
    }

    .profile {
        width: 35px;
        height: 35px;
        margin-right: -20px;
    }
</style>

<div class="pageName">
    <svg
            xmlns="http://www.w3.org/2000/svg"
            width="35"
            height="35"
            fill="currentColor"
            class="bi bi-bar-chart-fill"
            viewBox="0 0 16 16"
    >
        <path
                d="M1 11a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1zm5-4a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v7a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1zm5-5a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1h-2a1 1 0 0 1-1-1z"
        />
    </svg
    >
    업무 통계
</div>
<div class="btnBox">

    <button class="projectBtn" onclick="openProjectModal()"
    >프로젝트 생성
    </button>

</div>

<div class="selectBox">
    <select>
        <c:forEach var="project" items="${projectList}">
            <option value="${project.projectId}">${project.projectName}</option>
        </c:forEach>
    </select>
    <button class="selectBtn">적용하기</button>
</div>

<div class="row boxContents">
    <div class="col-12 col-sm-4 order-sm-12">
        <canvas id="myChart1" style="height: 50vh"></canvas>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>
        const ctx1 = document.getElementById("myChart1").getContext('2d');

        new Chart(ctx1, {
            type: "bar",
            data: {
                labels: ["", "Blue", "Yellow", "Green", "Purple", "Orange"],
                //주제입력
                datasets: [
                    {
                        label: '진행률 (%)',
                        data: [12, 19, 3, 5, 2, 3],
                        borderWidth: 1,
                    },
                ],
            },
            options: {
                responsive: true,
                maintainAspectRatio: false, //div 크기에 따라 조절가능하게 만듦
                scales: {
                    y: {
                        beginAtZero: true,
                    },
                },
            },
        });

        let finishedData = ${chartData};

        // Chart.js를 사용하여 진행률 차트 그리기
        var ctx = document.getElementById('myChart').getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['진행률'],
                datasets: [{
                    label: '진행률',
                    data: [ChartData],
                    backgroundColor: ['rgba(75, 192, 192, 0.2)'],
                    borderColor: ['rgba(75, 192, 192, 1)'],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false, // div 크기에 맞게 조정
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 100 // 최대값을 100으로 설정 (100%)
                    }
                }
            }
        });
    </script>
    <div class="col-12 col-sm-4 order-sm-12">
        <canvas id="myChart2" style="height: 50vh"></canvas>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>
        const ctx2 = document.getElementById("myChart2");

        new Chart(ctx2, {
            type: "pie",
            data: {
                labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
                datasets: [
                    {
                        label: "# of Votes",
                        data: [12, 19, 3, 5, 2, 3],
                        borderWidth: 1,
                    },
                ],
            },
            options: {
                responsive: true,
                maintainAspectRatio: false, //div 크기에 따라 조절가능하게 만듦
                scales: {
                    y: {
                        beginAtZero: true,
                    },
                },
            },
        });
    </script>
    <div class="col-12 col-sm-4 order-sm-12">
        <canvas id="myChart3" style="height: 50vh"></canvas>
    </div>
    <script>
        // 여기부터 도넛그래프
        var ctx3 = document.getElementById("myChart3").getContext("2d");
        var myChart = new Chart(ctx3, {
            type: "line",
            data: {
                labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
                datasets: [
                    {
                        label: "# of Votes",
                        data: [12, 19, 3, 5, 2, 3],
                        backgroundColor: [
                            "rgba(255, 99, 132, 0.2)",
                            "rgba(54, 162, 235, 0.2)",
                            "rgba(255, 206, 86, 0.2)",
                            "rgba(75, 192, 192, 0.2)",
                            "rgba(153, 102, 255, 0.2)",
                            "rgba(255, 159, 64, 0.2)",
                        ],
                        borderColor: [
                            "rgba(255, 99, 132, 1)",
                            "rgba(54, 162, 235, 1)",
                            "rgba(255, 206, 86, 1)",
                            "rgba(75, 192, 192, 1)",
                            "rgba(153, 102, 255, 1)",
                            "rgba(255, 159, 64, 1)",
                        ],
                        borderWidth: 1,
                    },
                ],
            },
            options: {
                responsive: true,
                maintainAspectRatio: false, //div 크기에 따라 조절가능하게 만듦
                scales: {
                    yAxes: [
                        {
                            ticks: {
                                beginAtZero: true,
                            },
                        },
                    ],
                },
            },
        });
    </script>
</div>
<div class="projectList">
    <div class="tableBox">
        <table class="table">
            <thead>
            <tr>
                <th>제목</th>
                <th>등록일자</th>
                <th>프로젝트 기간</th>
                <th>참여 인원</th>
                <th>상태</th>
                <c:if test="${employee.role!=('TEAM_LEADER')}}">
                    <th>수정</th>
                </c:if>
                <th>숨김</th>

            </tr>
            </thead>
            <tbody>
            <c:forEach items="${projects}" var="list">

                <tr id="changeRow-${list.id}" onclick="location.href='/project/detail/${list.id}'">

                    <td>${list.name}</td>
                    <td>${list.regDate}</td>
                    <td> ${list.deadLine}</td>
                    <td>
                        <div class="member-profiles">
                            <!-- 프로필 이미지 리스트 -->
                            <c:forEach items="${list.profileImg}" var="img">
                                <c:choose>
                                    <c:when test="${img == null}">
                                        <img class="profile" src="/image/defaultImg.jpg">
                                    </c:when>
                                    <c:otherwise>
                                        <img class="profile" src="${img}">
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                    </td>

                    <c:if test="${projectFinish}">
                        <td>${list.status}</td>
                    </c:if>
                    <c:if test="${employee.role!='TEAM_LEADER'}">
                        <td>

                            <button class="updateProjectBtn" onclick="updateProject(${list.id})">수정</button>

                        </td>
                        <td><c:if test="${list.status!=('FINISH')}">
                            <%-- 상태가 피니쉬면 숨김버튼을 볼수있고 check하면 hideYn에서 Y 값을줘야됨<td>${list.hideYn}</td>--%>
                            <div class="form-check form-switch">

                                <input class="form-check-input" type="checkbox" id="hidetarget-${list.id}"
                                       onchange="handleHide(${list.id})">

                                <label class="form-check-label" for="hidetarget-${list.id}"></label>

                            </div>
                        </c:if>
                        </td>
                    </c:if>

                </tr>


            </c:forEach>

            </tbody>
        </table>
    </div>
</div>

<%--프로젝트 생성모달 --%>
<div class="modal fade" id="projectModal" tabindex="-1">
    <div class="modal-dialog">

        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">프로젝트 생성</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form id="projectForm" action="/project/insert" method="post" enctype="multipart/form-data">
                <div class="modal-body">

                    <div class="mb-3">
                        <label class="form-label">프로젝트 제목</label>
                        <input type="text" class="form-control" name="title" required>
                    </div>

                    <div class="mb-3">
                        <!-- 프로젝트 기간 설정 버튼 -->
                        프로젝트 기간 설정
                        <input type="date" name="deadLine"/>
                    </div>
                    <%--                <div class="mb-3">--%>
                    <%--                    <label class="form-label">프로젝트 진행에 필요한 works</label>--%>
                    <%--                 <input type="number" value="6" min="6" step="1"/>--%>

                    <%--                </div>--%>
                    <div class="mb-3">
                        <label class="form-label">프로젝트 인원</label>
                        <button type="button" class="btn btn-outline-primary" onclick="openMemberSearch()">
                            인원 추가
                        </button>
                        <div id="selectedMembers" class="mt-2">
                            <div class="selectedUser" data-id="">
                                <div>선택된 멤버가 없습니다</div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary" onclick="createProject()">생성하기</button>
                </div>

            </form>

        </div>

    </div>
</div>


<%--프로젝트수정모달--%>
<div class="modal fade" id="updateModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="/project/update" method="post">
                <div class="modal-body">
                    <input tpye="hidden" name="id" value="1"/>
                    <input type="hidden" name="projectId" value="${project.id}"/>
                    <h5>프로젝트 title</h5>
                    <div class="mb-3">
                        <input type="text" id="title" value="${project.name}">
                    </div>
<%--projectinsertDTO 가져와야됨--%>
                    <div class="mb-3">
                        <!-- 프로젝트 기간 설정 버튼 -->
                        프로젝트 기간 설정
                        <input type="date" name="deadLine" value="${project.deadLine}"/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">프로젝트 인원</label>
                        <button type="button" class="btn btn-outline-primary" onclick="openMemberSearch()">
                            인원 추가
                        </button>
                        <div id="updateMembers" class="mt-2">
                            <div class="selectedUser" val>
                                <div>선택된 멤버가 없습니다</div>
                            </div>
                        </div>
                    </div>

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


<%--프로젝트 추가 및 수정에서 인원변경모달라인--%>
<div class="modal fade" id="memberSearchModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">멤버 검색</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <!-- 멤버이름 검색 -->
                <div class="mb-3">
                    <input type="text" class="form-control" id="memberSearchInput" placeholder="멤버 이름 검색"
                           onkeyup="searchMembers()">
                </div>
                <!-- 검색 결과 리스트 -->
                <div id="memberSearchResults" class="mb-3">
                    <p>검색 결과가 표시됩니다.</p>
                </div>
                <!-- 선택된 멤버 리스트 -->
                <div>
                    <h6 class="mt-3">선택된 멤버</h6>
                    <div id="selectedMembersList" class="d-flex flex-wrap">

                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="closeBtn" data-bs-dismiss="modal">닫기</button>
                <button type="button" class=inputMemberBtn" onclick="confirmSelectedMembers()">확인</button>
            </div>
        </div>
    </div>
</div>
<%--프로젝트 기간 선택--%>
<div class="modal" id="deadlineModal">
    <div class="modalContent">
        <span class="close">&times;</span>
        <h3>마감일자 선택</h3>
        <div class="dateSelectWrapper">
            <input type="datetime-local" id="deadlineDate" class="dateInput">
            <div class="buttonWrapper">
                <button type="button" id="cancelDate" class="modalBtn cancelBtn">취소</button>
                <button type="button" id="confirmDate" class="modalBtn confirmBtn">확인</button>
            </div>
        </div>
    </div>
</div>
<script>

    $('form').submit(function (e) {
        e.preventDefault();

        const formData = new FormData(this);
        for(const [key, value] of formData.entries()) {
            console.log(key, value);
        }
        $.ajax({
            url: '/work/update',
            data: formData,
            type: 'POST',
            processData: false,
            contentType: false,
            error: function (xhr, status, error) {
                console.error('Error:', error);
                console.error('Status:', status);
                console.error('Response:', xhr.responseText);
            }
        }).done(function(response) {
            console.log(response);
            location.reload();
        })
    })


    function openProjectModal() {
        $('#projectModal').modal('show');
    }

    function updateProject(${list.id}){
        $('#updateModal').modal('show');
        // $('#updateProjectId').val(id);
    }

    function openMemberSearch() {
        $('#memberSearchModal').modal('show');
    }

    function closeMemberSearch() {
        $('#memberSearchModal').modal('hide');
    }


    function searchMembers() {
        console.log($('#memberSearchInput').val());
        $.ajax({
            url: '/project/searchUser/',
            type: 'GET',
            data: {
                name: $('#memberSearchInput').val()
            },
            success: function (data) {
                console.log(data);

                let memberList = '';
                for (let i = 0; i < data.length; i++) {

                    memberList += '<div class="user-item" data-id="' + data[i].id + '" data-name="' + data[i].name + '">' + data[i].name + ' ' + data[i].jobName + ' ' + data[i].departmentName + '</div>'

                }
                $('#memberSearchResults').html(memberList);

                // 사용자 선택 시 selectedMembersList에 추가하는 이벤트 처리
                $('#memberSearchResults .user-item').click(function () {
                    var userId = $(this).data('id');
                    var userName = $(this).data('name');

                    // 이미 선택된 사용자인지 확인
                    if ($('#selectedMembersList').find(`[data-id="${userId}"]`).length === 0) {

                        console.log('추가한 새로운 멤버:', userId, userName);

                        // selectedMembersList에 사용자 추가
                        $('#selectedMembersList').append(
                            $('<div>').addClass('selected-user').attr('data-id', userId)
                                .append($('<span>').html(userName))
                                .append($('<button>').addClass("remove-user").html('삭제').click(function () {
                                        $(this).parent().remove();
                                    })
                                )
                                .append($('<input>').attr('type', 'hidden').attr('name', 'employeeId').val(userId))
                        );
                    }
                });

            }
        })
    }


    function handleHide(projectId) {

        const row = $(`changeRow-${projectId}`);
        const checkbox = $(`#hidetarget-${projectId}`);

        if (checkbox.prop('checked')) {
            //속성의 현재 상태 제어를 위해 prop씀
            row.css('opacity', '0.3');
            // 숨김처리하면 팀리더만 투명하게 보임
            // 서버에 hideYn = 'Y' 전송하는 AJAX 추가 가능
        } else {
            row.css('opacity', '1');
            //서버에 hideYn = 'N' 전송 가능
        }
    }


    function confirmSelectedMembers() {

        $("#selectedMembers").html("");
        console.log($("#selectedMembersList").html());
        $("#selectedMembers").html($("#selectedMembersList").html());
        document.activeElement.blur();
        $("#memberSearchModal").modal('hide');

    }

    // 프로젝트 생성 함수
    function createProject(e) {
        console.log('#projectForm');
        $('#projectForm').submit();

    }

    // 선택한 멤버 수집 함수
    function getSelectedMembers() {
        let selectedMembers = [];

        $('#selectedMembers .selectedUser').each(function () {

            const id = $(this).attr('data-id');
            console.log(id);

            if (id) {
                console.log(id);
                selectedMembers.push(id[1]);
            }
        });
        console.log(selectedMembers);

        if (selectedMembers.length === 0) {
            console.warn("선택된 멤버가 없습니다. 선택자를 확인하세요.");
        }
        return selectedMembers;
    }

    function addProjectToTable(response) {
        const tableHtml = `
        <tr onClick="location.href='/works/work/${response.id}'">
            <td>${response.name}</td>
            <td>${response.regDate}</td>
            <td>${response.regDate} ~ ${response.deadLine}</td>
            <td><div class="memberProfile"></div></td>
            <td>${response.hideYn == 'N' ? '진행중' : '종료'}</td>

                <button class="updateProjectBtn" onClick=" openUpdateProjectModal(${response.id})">수정</button>

                <button class="deleteProjectBtn" onClick="deleteProject(${response.id})">삭제</button>
        </tr>
    `;
        $('.table tbody').append(tableHtml);

    }

    //
    // const stateScore = {
    //     'TODO': 0,
    //     'ONGOING': 0.5,
    //     'FINISH': 1
    // };
    //
    // const progressSum = works.reduce((sum, task) => sum + stateScore[task.state], 0);
    // const progress = Math.round((progressSum / works.length) * 100);
    //
    // const ctx = document.getElementById('progressChart');
    // const myChart = new Chart(ctx, {
    //     type: 'doughnut',
    //     data: {
    //         labels: ['진행도'],
    //         datasets: [{
    //             label: '프로젝트 진행도',
    //             data: [progress, 100 - progress],
    //             backgroundColor: ['#4CAF50', '#e0e0e0'],
    //             borderWidth: 1
    //         }]
    //     },
    // });


</script>


<jsp:include page="/WEB-INF/views/template/footer.jsp"/>