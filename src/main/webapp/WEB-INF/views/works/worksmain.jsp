<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="/WEB-INF/views/template/header.jsp" />
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
                /></svg
            >업무 통계
        </div>
        <div class="btnBox">

            <button class="projectBtn" onclick="openProjectModal()"
            >프로젝트 생성</button>

        </div>

        <div class="selectBox">
            <select>
                <option>선택하십시오</option>
                <option>주제1</option>
                <option>주제2</option>
            </select>
            <button class="selectBtn">적용하기</button>
        </div>

        <div class="row boxContents">
            <div class="col-12 col-sm-4 order-sm-12">
                <canvas id="myChart1" style="height: 50vh"></canvas>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

            <script>
                const ctx1 = document.getElementById("myChart1");

                new Chart(ctx1, {
                    type: "bar",
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
                    <c:if test="${isTeamLeader}">
                        <th>관리</th>
                    </c:if>

                </tr>
                </thead>
                <tbody>
                <c:forEach items="${projects}" var="list">
                    <tr onclick="location.href='/works/project/${list.id}'">
                        <td>${list.name}</td>
                        <td>${list.regDate}</td>
                        <td>${list.regDate} ~ ${list.deadLine}</td>
                        <td>
                            <div class="member-profiles">
                                <!-- 프로필 이미지 리스트 -->
                            </div>
                        </td>
                        <td>${list.hideYn == 'N' ? '진행중' : '종료'}</td>
                        <c:if test="${isTeamLeader}">
                            <td>
                                <button class="updateProjectBtn" onclick="updateProject(${list.id})">수정</button>
                                <button  onclick="deleteProject(${list.id})">삭제</button>
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
                        <input type="date" name="deadLine" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label">프로젝트 인원</label>
                        <button type="button" class="btn btn-outline-primary" onclick="openMemberSearch()">
                            인원 추가
                        </button>
                        <div id="selectedMembers" class="mt-2" >
                            <div class="selectedUser" data-id="">
                           <div >선택된 멤버가 없습니다</div>
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
<div class="modal fade" id="updateProjectModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">프로젝트 수정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="updateProjectForm">
                    <!-- 수정할 데이터를 담는 입력 필드 -->
                    <div class="mb-3">
                        <label class="form-label">프로젝트 제목</label>
                        <input type="text" class="form-control" name="name" id="updateProjectName" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">프로젝트 기간</label>
                        <input type="text" class="form-control" id="updateProjectPeriod">
                        <input type="hidden" name="regDate" id="updateRegDate">
                        <input type="hidden" name="deadLine" id="updateDeadLine">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">프로젝트 인원</label>
                        <button type="button" class="btn btn-outline-primary" onclick="openMemberSearch()">
                            인원 추가
                        </button>
                        <div id="updateSelectedMembers" class="mt-2"></div>
                    </div>
                    <input type="hidden" name="id" id="updateProjectId"> <!-- 프로젝트 ID 숨김 필드 -->
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="updateProject()">수정하기</button>
            </div>
        </div>
    </div>
</div>


<%--프로젝트 수정에서 인원변경모달라인--%>
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
                    <input type="text" class="form-control" id="memberSearchInput" placeholder="멤버 이름 검색" onkeyup="searchMembers()">
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
    // function  updateProject(id) {
    //     location.href = '/project/update/' + id;
    // }

    function deleteProject(id) {
        if(confirm("정말 프로젝트를 삭제 하시겠습니까?"))
        location.href = '/project/delete/' + id;
    }
    function openProjectModal() {
        $('#projectModal').modal('show');
    }

    function openUpdateProjectModal(id) {
        $('#updateProjectModal').modal('show');
        $('#updateProjectId').val(id);
    }
    function openMemberSearch() {
        $('#memberSearchModal').modal('show');
    }
    function closeMemberSearch() {
        $('#memberSearchModal').modal('hide');}


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
            for(let i = 0; i < data.length; i++){
                console.log(data[i]);
                memberList += '<div class="user-item" data-id="' + data[i].id + '" data-name="' + data[i].name + '">' + data[i].name + ' ' + data[i].jobName + ' ' + data[i].departmentName + '</div>'
                console.log(memberList);
            }
            console.log($('#memberSearchResults'));
            console.log($('#memberSearchResults').html());
            $('#memberSearchResults').html(memberList);

            // 사용자 선택 시 selectedMembersList에 추가하는 이벤트 처리
            $('#memberSearchResults .user-item').click(function() {
                var userId = $(this).data('id');
                var userName = $(this).data('name');
                console.log(userId, userName);
                // 이미 선택된 사용자인지 확인
                if ($('#selectedMembersList').find(`[data-id="${userId}"]`).length === 0) {

                    console.log('추가한 새로운 멤버:', userId, userName);

                    // selectedMembersList에 사용자 추가
                    $('#selectedMembersList').append(
                        $('<div>').addClass('selected-user').attr('data-id', userId)
                            .append($('<span>').html(userName))
                            .append($('<button>').addClass("remove-user").html('삭제').click(function() {
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

            $('#selectedMembers .selectedUser').each(function() {

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

</script>


<jsp:include page="/WEB-INF/views/template/footer.jsp" />