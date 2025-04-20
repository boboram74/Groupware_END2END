<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="/WEB-INF/views/template/header.jsp"/>
    <%--    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>--%>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"/>

    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js" defer></script>

    <script src="https://cdn.jsdelivr.net/npm/chart.js" defer></script>
</head>
<body>
<%--<script--%>
<%--        src="https://code.jquery.com/jquery-3.3.1.min.js"--%>
<%--        integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="--%>
<%--        crossorigin="anonymous"--%>
<%--></script>--%>

<script
        src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"
></script>
<%--<script--%>
<%--        src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"--%>
<%--        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"--%>
<%--        crossorigin="anonymous"--%>
<%--></script>--%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<%--<link rel="stylesheet" href="/css/works/worksmain.css">--%>
<link rel="stylesheet" href="/css/color/newColor.css"/>
<style>
    /* ===== 변수 정의 ===== */
    :root {
        --primary-color: #4A90E2;
        --primary-dark: #357ABD;
        --secondary-color: #4BC0C0;
        --error-color: #FF6B6B;
        --success-color: #2ECC71;
        --warning-color: #F39C12;
        --gray-100: #F8F9FA;
        --gray-200: #E9ECEF;
        --gray-300: #DEE2E6;
        --gray-400: #CED4DA;
        --gray-500: #ADB5BD;
        --gray-600: #6C757D;
        --gray-700: #495057;
        --gray-800: #343A40;
        --gray-900: #212529;
        --border-radius: 8px;
        --box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        --transition: all 0.3s ease;
    }

    /* ===== 전체 페이지 스타일 ===== */
    body {
        background-color: var(--gray-100);
        color: var(--gray-800);
        font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, sans-serif;
    }

    /* ===== 페이지 헤더 ===== */
    .pageName {
        display: flex;
        align-items: center;
        gap: 12px;
        font-size: 24px;
        font-weight: 700;
        color: var(--gray-900);
        margin-bottom: 24px;
        padding: 20px 0;
    }

    .pageName svg {
        color: var(--primary-color);
    }

    /* ===== 버튼 스타일 ===== */
    .btnBox {
        margin-bottom: 24px;
    }

    .projectBtn {
        background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
        color: white;
        border: none;
        padding: 12px 24px;
        border-radius: var(--border-radius);
        font-weight: 600;
        font-size: 14px;
        transition: var(--transition);
        box-shadow: var(--box-shadow);
    }

    .projectBtn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(74, 144, 226, 0.3);
    }

    .selectBtn {
        background-color: var(--secondary-color);
        color: white;
        border: none;
        padding: 8px 20px;
        border-radius: var(--border-radius);
        font-weight: 500;
        transition: var(--transition);
    }

    .selectBtn:hover {
        background-color: #3EADAD;
    }

    /* ===== 선택 박스 ===== */
    .selectBox {
        display: flex;
        gap: 12px;
        margin-bottom: 32px;
        align-items: center;
    }

    #projectSelect {
        padding: 8px 16px;
        border: 1px solid var(--gray-300);
        border-radius: var(--border-radius);
        font-size: 14px;
        min-width: 200px;
        background-color: white;
        box-shadow: var(--box-shadow);
    }

    #projectSelect:focus {
        outline: none;
        border-color: var(--primary-color);
        box-shadow: 0 0 0 3px rgba(74, 144, 226, 0.2);
    }

    /* ===== 차트 컨테이너 ===== */
    .boxContents {
        background-color: white;
        border-radius: 12px;
        padding: 24px;
        box-shadow: var(--box-shadow);
        margin-bottom: 32px;
    }

    .boxContents > div {
        padding: 16px;
    }

    canvas {
        background-color: white;
        border-radius: 8px;
    }

    /* ===== 테이블 스타일 ===== */
    .projectList {
        background-color: white;
        border-radius: 12px;
        padding: 24px;
        box-shadow: var(--box-shadow);
    }

    .table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
    }

    .table thead th {
        background-color: var(--gray-100);
        color: var(--gray-700);
        font-weight: 600;
        padding: 16px;
        border-bottom: 2px solid var(--gray-200);
        text-align: left;
        font-size: 14px;
    }

    .table tbody td {
        padding: 16px;
        border-bottom: 1px solid var(--gray-200);
        vertical-align: middle;
        font-size: 14px;
    }

    .table tbody tr {
        transition: var(--transition);
    }

    .table tbody tr:hover {
        background-color: #F7FAFF;
        transform: translateX(4px);
    }

    /* ===== 프로필 이미지 ===== */
    .member-profiles {
        display: flex;
        align-items: center;
    }

    .profile {
        width: 36px;
        height: 36px;
        border-radius: 50%;
        border: 2px solid white;
        margin-right: -10px;
        transition: var(--transition);
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .profile:hover {
        transform: scale(1.1);
        z-index: 2;
    }

    /* ===== 배지 스타일 ===== */
    .detail-badge {
        background-color: var(--error-color);
        color: white;
        padding: 4px 12px;
        border-radius: 16px;
        font-size: 12px;
        font-weight: 600;
        margin-left: 8px;
        animation: pulse 2s infinite;
    }

    @keyframes pulse {
        0% {
            box-shadow: 0 0 0 0 rgba(255, 107, 107, 0.7);
        }
        70% {
            box-shadow: 0 0 0 10px rgba(255, 107, 107, 0);
        }
        100% {
            box-shadow: 0 0 0 0 rgba(255, 107, 107, 0);
        }
    }

    .detail-badgeStatus {
        display: inline-block;
        padding: 6px 12px;
        border-radius: 16px;
        font-size: 12px;
        font-weight: 500;
        text-transform: capitalize;
    }

    .detail-badgeStatus[content="ready"] {
        background-color: #FFE8D6;
        color: #B44D12;
    }

    .detail-badgeStatus[content="ongoing"] {
        background-color: #D4EFDF;
        color: #186A3B;
    }

    .detail-badgeStatus[content="finish"] {
        background-color: #D6E4FF;
        color: #1E429F;
    }

    /* ===== 스위치 버튼 ===== */
    .form-check-input {
        width: 44px;
        height: 22px;
        background-color: var(--gray-300);
        border: none;
        transition: var(--transition);
        cursor: pointer;
    }

    .form-check-input:checked {
        background-color: var(--primary-color);
        border-color: var(--primary-color);
    }

    .form-check-input:focus {
        box-shadow: none;
    }

    /* ===== 수정 버튼 ===== */
    .updateProjectBtn {
        background-color: var(--gray-100);
        color: var(--gray-700);
        border: 1px solid var(--gray-300);
        padding: 6px 16px;
        border-radius: var(--border-radius);
        font-size: 13px;
        font-weight: 500;
        transition: var(--transition);
    }

    .updateProjectBtn:hover {
        background-color: var(--primary-color);
        color: white;
        border-color: var(--primary-color);
    }

    /* ===== 숨김 프로젝트 스타일 ===== */
    .hidden-project.leader {
        opacity: 0.6;
        position: relative;
    }

    .hidden-project.leader::after {
        content: '숨김';
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        background-color: var(--gray-500);
        color: white;
        padding: 2px 8px;
        border-radius: 12px;
        font-size: 11px;
    }

    .hidden-project.staff {
        display: none;
    }

    /* ===== 툴팁 스타일 ===== */
    .tip {
        position: relative;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 20px;
        height: 20px;
        background-color: var(--gray-300);
        border-radius: 50%;
        font-size: 12px;
        cursor: help;
    }

    .tip:before {
        content: '?';
        color: var(--gray-700);
        font-weight: bold;
    }

    .tip p {
        position: absolute;
        top: 100%;
        left: 50%;
        transform: translateX(-50%);
        margin-top: 10px;
        width: 280px;
        padding: 12px;
        background-color: var(--gray-900);
        color: white;
        font-size: 13px;
        line-height: 1.5;
        border-radius: var(--border-radius);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        opacity: 0;
        visibility: hidden;
        transition: var(--transition);
        z-index: 1000;
    }

    .tip p:before {
        content: '';
        position: absolute;
        top: -6px;
        left: 50%;
        transform: translateX(-50%);
        border-width: 6px;
        border-style: solid;
        border-color: transparent transparent var(--gray-900) transparent;
    }

    .tip:hover p {
        opacity: 1;
        visibility: visible;
    }

    /* ===== 모달 스타일 ===== */
    .modal-content {
        border: none;
        border-radius: 12px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    }

    .modal-header {
        border-bottom: 1px solid var(--gray-200);
        padding: 20px 24px;
    }

    .modal-title {
        font-weight: 600;
        color: var(--gray-900);
    }

    .modal-body {
        padding: 24px;
    }

    .modal-footer {
        border-top: 1px solid var(--gray-200);
        padding: 16px 24px;
    }

    /* ===== 폼 요소 스타일 ===== */
    .form-label {
        font-weight: 500;
        color: var(--gray-700);
        margin-bottom: 8px;
    }

    .form-control {
        border: 1px solid var(--gray-300);
        border-radius: var(--border-radius);
        padding: 10px 16px;
        font-size: 14px;
        transition: var(--transition);
    }

    .form-control:focus {
        border-color: var(--primary-color);
        box-shadow: 0 0 0 3px rgba(74, 144, 226, 0.2);
    }

    /* ===== 반응형 디자인 ===== */
    @media (max-width: 768px) {
        .pageName {
            font-size: 20px;
        }

        .selectBox {
            flex-direction: column;
            align-items: stretch;
        }

        #projectSelect {
            width: 100%;
        }

        .boxContents {
            padding: 16px;
        }

        .table thead th,
        .table tbody td {
            padding: 12px;
        }
    }

    /*tbody tr:hover {*/
    /*    background-color: #f0f8ff;*/
    /*}*/

    /*.profile {*/
    /*    width: 35px;*/
    /*    height: 35px;*/
    /*    margin-right: -20px;*/
    /*}*/

    /*.detail-badge {*/
    /*    background-color: var(--md-sys-color-error);*/
    /*    color: var(--md-sys-color-on-error);*/
    /*    padding: 2px 8px;*/
    /*    border-radius: 12px;*/
    /*    font-size: 12px;*/
    /*    min-width: 20px;*/
    /*    text-align: center;*/
    /*    margin-left: 10px;*/
    /*}*/

    /*.hidden-project.leader {*/
    /*    opacity: 0.5;*/
    /*}*/

    /*.hidden-project.staff {*/
    /*    display: none;*/
    /*}*/

    /*.hidden-project {*/
    /*    opacity: 0.4;*/
    /*    transition: opacity 0.3s ease;*/
    /*    color: #7f8c8d;*/
    /*}*/

    /*.employee .hidden-project {*/
    /*    display: none;*/
    /*}*/


    /*.manager .hidden-project {*/
    /*    opacity: 0.3;*/
    /*}*/

    /*.ongoing-status {*/
    /*    background-color: green;*/
    /*    color: white;*/
    /*    padding: 2px 5px;*/
    /*    border-radius: 5px;*/
    /*}*/

    /*.finish-status {*/
    /*    background-color: gray;*/
    /*    color: white;*/
    /*    padding: 2px 5px;*/
    /*    border-radius: 5px;*/
    /*}*/


    /*.tip {*/
    /*    position: absolute;*/
    /*    top: 8px;*/
    /*    left: 55px;*/

    /*    font-size: 14px;*/
    /*    line-height: 26px;*/
    /*    text-align: center;*/

    /*    background-color: #b3dfe6;*/
    /*    border-radius: 50%;*/
    /*    width: 24px;*/
    /*    height: 24px;*/
    /*    cursor: default;*/
    /*}*/

    /*.tip:before {*/
    /*    content: '?';*/
    /*    font-weight: bold;*/
    /*    color: #fff;*/
    /*}*/

    /*.tip:hover p {*/
    /*    visibility: visible;*/
    /*    opacity: 1;*/
    /*}*/

    /*.tip p {*/
    /*    opacity: 0;*/
    /*    visibility: hidden;*/

    /*    color: #fff;*/
    /*    font-size: 13px;*/
    /*    line-height: 1.4;*/
    /*    text-align: left;*/

    /*    background-color: #0064b7;*/
    /*    width: 400px;*/
    /*    padding: 20px;*/
    /*    border-radius: 3px;*/
    /*    box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.2), -1px -1px 3px rgba(0, 0, 0, 0.2);*/

    /*    position: absolute;*/
    /*    right: -370px;*/

    /*    transition: visibility 0s, opacity 0.5s linear;*/
    /*}*/

    /*.tip p:before {*/
    /*    position: absolute;*/
    /*    content: '';*/
    /*    width: 0;*/
    /*    height: 0;*/
    /*    border: 6px solid transparent;*/
    /*    border-bottom-color: #0064b7;*/
    /*    left: 10px;*/
    /*    top: -12px;*/
    /*}*/


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
<c:if test="${isTeamLeader}">
<div class="btnBox">

    <button class="projectBtn" onclick="openProjectModal()"
    >프로젝트 생성
    </button>

</div>
</c:if>

<div class="selectBox">
    <select id="projectSelect">
        <c:forEach var="project" items="${projects}">
            <option value="${project.id}" }>프로젝트이름
                :${project.name}</option>
        </c:forEach>
    </select>
    <button class="selectBtn" onclick="applyProject()">적용하기</button>
</div>

<div class="row boxContents">
    <div class="col-12 col-sm-4 order-sm-12">
        <canvas id="myChart" style="height: 50vh"></canvas>
    </div>


    <script>

        let myChartInstance = null;
        let myChart2Instance = null;
        let myChart3Instance = null;


        $(document).ready(function () {
            $.ajax({
                url: '/project/latestProjectId',
                type: 'GET',
                success: function (latestId) {
                    $("#projectSelect").val(latestId);
                    applyProjectById(latestId);
                },
                error: function () {
                    alert("최신 프로젝트 정보를 가져오지 못했습니다.");
                }
            });
        });

        function applyProject() {
            const selectedId = $("#projectSelect").val();
            applyProjectById(selectedId);
        }

        function applyProjectById(projectId) {

            // 진행률 차트
            $.ajax({
                url: '/work/chartData/' + projectId,
                type: 'GET',
                dataType: 'json',
                success: function (data) {
                    const progress = data.progress;
                    const notProgress = 100 - progress;
                    const ctx = document.getElementById('myChart').getContext('2d');

                    if (myChartInstance) myChartInstance.destroy();
                    myChartInstance = new Chart(ctx, {

                        type: 'doughnut',
                        data: {
                            labels: ['진행률', '미진행률'],
                            datasets: [{
                                data: [progress, notProgress],
                                backgroundColor: ['#4bc0c0', '#edf2f0'],
                                borderColor: ['#4bc0c0', '#4bc0c0'],
                                borderWidth: 1
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            cutout: '60%',
                            rotation: -90,
                            circumference: 180,
                            // rotation: 1 * Math.PI,
                            // circumference: 1 * Math.PI,
                            animation: {
                                duration: 1000
                            },
                            plugins: {
                                legend: {display: true}
                            }
                        }
                    });
                }
            });

            // 상태 차트
            $.ajax({
                url: '/work/statusChartData/' + projectId,
                type: 'GET',
                dataType: 'json',
                success: function (data) {
                    const ctx2 = document.getElementById('myChart2').getContext('2d');
                    if (myChart2Instance) myChart2Instance.destroy();
                    myChart2Instance = new Chart(ctx2, {
                        type: 'pie',
                        data: {
                            labels: ['READY', 'ONGOING', 'FINISH'],
                            datasets: [{
                                data: [data.READY, data.ONGOING, data.FINISH],
                                backgroundColor: ['rgba(255, 99, 132, 0.5)',   // 진행전
                                    'rgba(54, 162, 235, 0.5)',   // 진행중
                                    'rgba(75, 192, 192, 0.5)'    // 완료
                                ],
                                borderColor: [
                                    'rgba(255, 99, 132, 1)',
                                    'rgba(54, 162, 235, 1)',
                                    'rgba(75, 192, 192, 1)'],
                                borderWidth: 1
                            }]
                        },
                        options: {
                            responsive: true,
                            plugins: {legend: {position: 'bottom'}}
                        }
                    });
                }
            });

            // 타입 차트
            $.ajax({
                url: '/work/typeChartData/' + projectId,
                type: 'GET',
                dataType: 'json',
                success: function (data) {
                    const ctx3 = document.getElementById('myChart3').getContext('2d');
                    if (myChart3Instance) myChart3Instance.destroy();
                    myChart3Instance = new Chart(ctx3, {
                        type: 'line',
                        data: {
                            labels: ['DOCUMENT', 'REPORT', 'WBS', 'MEETING_FOLDER', 'SPECIFICATION'],
                            datasets: [{
                                label: '업무 유형별 개수',
                                data: [
                                    data.DOCUMENT,
                                    data.REPORT,
                                    data.WBS,
                                    data.MEETING_FOLDER,
                                    data.SPECIFICATION
                                ],
                                backgroundColor: [
                                    "rgba(255, 99, 132, 0.2)",
                                    "rgba(54, 162, 235, 0.2)",
                                    "rgba(255, 206, 86, 0.2)",
                                    "rgba(75, 192, 192, 0.2)",
                                    "rgba(153, 102, 255, 0.2)",

                                ],
                                borderColor: [
                                    "rgba(255, 99, 132, 1)",
                                    "rgba(54, 162, 235, 1)",
                                    "rgba(255, 206, 86, 1)",
                                    "rgba(75, 192, 192, 1)",
                                    "rgba(153, 102, 255, 1)"],
                                borderWidth: 1
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            scales: {
                                y: {beginAtZero: true}
                            }
                        }
                    });
                }
            });
        }

        //선택하면 적용되는 차트 스트립트코드

        function applyProject() {
            const selectedId = $("#projectSelect").val();

            $.ajax({

                    url: '/work/chartData/' + selectedId,
                    type: 'GET',
                    dataType: 'json',
                    success: function (data) {
                        const chartData = data.progress;

                        const data2 = 100 - chartData;

                        const ctx = document.getElementById('myChart').getContext('2d');

                        if (myChartInstance) {
                            myChartInstance.destroy();
                        }

                        myChartInstance = new Chart(ctx, {
                            type: 'doughnut',
                            data: {
                                labels: ['진행률', '미진행률'],
                                datasets: [{
                                    label: '진행률',
                                    data: [chartData, data2],
                                    backgroundColor: ['rgba(75, 192, 192, 0.2)', '#edf2f0'],
                                    borderColor: ['rgba(75, 192, 192, 1)', 'rgba(75, 192, 192, 1)'],
                                    borderWidth: 1
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                cutout: '60%',
                                rotation: -90,
                                circumference: 180,

                                animation: {
                                    duration: 1000
                                },
                                plugins: {
                                    legend: {display: true}
                                }
                            }

                        });
                    },
                    error: function (xhr, status, error) {
                        console.error('AJAX 오류:', error);
                    }
                }
            )
            ;


            $.ajax({
                url: '/work/statusChartData/' + selectedId,
                type: 'GET',
                dataType: 'json',
                success: function (data) {
                    const chartData = data;
                    const labels = ["READY", "ONGOING", "FINISH"];
                    const values = [chartData.READY, chartData.ONGOING, chartData.FINISH];

                    const ctx2 = document.getElementById('myChart2').getContext('2d');

                    if (myChart2Instance) {
                        myChart2Instance.destroy();
                    }


                    myChart2Instance = new Chart(ctx2, {
                        type: "pie",
                        data: {
                            labels: labels,
                            datasets: [
                                {
                                    label: "업무 상태 비율",
                                    data: values,
                                    // 각각의 상태별 비율이 들어가야됨
                                    backgroundColor: [
                                        'rgba(255, 99, 132, 0.5)',   // 진행전
                                        'rgba(54, 162, 235, 0.5)',   // 진행중
                                        'rgba(75, 192, 192, 0.5)'    // 완료
                                    ],
                                    borderColor: [
                                        'rgba(255, 99, 132, 1)',
                                        'rgba(54, 162, 235, 1)',
                                        'rgba(75, 192, 192, 1)'
                                    ],
                                    borderWidth: 1,
                                },
                            ],
                        },
                        options: {
                            responsive: true,
                            plugins: {
                                legend: {
                                    position: 'bottom'
                                },
                            },
                        },
                    });
                }
            });
            $.ajax({
                url: '/work/typeChartData/' + selectedId,
                type: 'GET',
                dataType: 'json',
                success: function (data) {
                    const labels = ["DOCUMENT", "REPORT", "WBS", "MEETING_FOLDER", "SPECIFICATION"];
                    const values = [
                        data.DOCUMENT,
                        data.REPORT,
                        data.WBS,
                        data.MEETING_FOLDER,
                        data.SPECIFICATION
                    ];

                    if (myChart3Instance) {
                        myChart3Instance.destroy();
                    }

                    const ctx3 = document.getElementById("myChart3").getContext("2d");
                    myChart3Instance = new Chart(ctx3, {
                        type: "line",
                        data: {
                            labels: labels,
                            datasets: [
                                {
                                    label: "업무 유형별 개수",
                                    data: values,
                                    backgroundColor: [
                                        "rgba(255, 99, 132, 0.2)",
                                        "rgba(54, 162, 235, 0.2)",
                                        "rgba(255, 206, 86, 0.2)",
                                        "rgba(75, 192, 192, 0.2)",
                                        "rgba(153, 102, 255, 0.2)",

                                    ],
                                    borderColor: [
                                        "rgba(255, 99, 132, 1)",
                                        "rgba(54, 162, 235, 1)",
                                        "rgba(255, 206, 86, 1)",
                                        "rgba(75, 192, 192, 1)",
                                        "rgba(153, 102, 255, 1)",

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
                }
            });
        }

    </script>
    <div class="col-12 col-sm-4 order-sm-12">
        <canvas id="myChart2" style="height: 50vh"></canvas>
    </div>

    <div class="col-12 col-sm-4 order-sm-12">
        <canvas id="myChart3" style="height: 50vh"></canvas>
    </div>

</div>
<div class="projectList">
    <div class="tableBox">
        <table class="table">
            <thead>
            <tr class="${list.hideYn == 'Y'
            ? (isTeamLeader ? 'hidden-project leader' : 'hidden-project staff')
            : ''}">

                <th>제목</th>
                <th>등록일자</th>
                <th>프로젝트 기간</th>
                <th>참여 인원</th>
                <th>상태</th>
                <c:if test="${isTeamLeader}">
                    <th>수정</th>

                    <th>숨김</th>
                </c:if>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${projects}" var="list">

                <tr id="changeRow-${list.id}"
                    class="${list.hideYn == 'Y'
            ? (isTeamLeader ? 'hidden-project leader' : 'hidden-project staff')
            : ''}">


                    <td onclick="handleProjectClick(${list.id})">${list.name}
                        <c:if test="${list.nearDeadline == 'Y'&& list.status.equals('ongoing')}"><span
                                class="detail-badge">긴급
                    </span></c:if></td>
                    <td onclick="handleProjectClick(${list.id})">${list.regDate}</td>
                    <td onclick="handleProjectClick(${list.id})"> ${list.deadLine}</td>

                    <td>
                        <div class="member-profiles">
                            <!-- 프로필 이미지 리스트 -->
                            <c:if test="${not empty list.profileImg}">
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
                            </c:if>
                        </div>
                    </td>
                    <td>
    <span class="detail-badgeStatus">
            ${list.status}
    </span>
                    </td>
                    <c:if test="${isTeamLeader}">
                        <td>
                            <button class="updateProjectBtn" onclick="openUpdateModal(${list.id})">수정</button>
                        </td>
                    </c:if>
                    <c:if test="${isTeamLeader}">
                        <td>
                            <c:if test="${list.status == 'finish'}">
                                <div class="form-check form-switch">
                                        <%--                                    <input class="form-check-input"--%>
                                        <%--                                           type="checkbox"--%>
                                        <%--                                           id="hideSwitch-${list.id}"--%>
                                        <%--                                           onchange="handleHide(${list.id})"--%>
                                        <%--                                        ${list.hideYn.equals("Y") ? 'checked' : ''}>--%>
                                    <input class="form-check-input hideSwitch"
                                           type="checkbox"
                                           id="hideSwitch-23"
                                        ${list.hideYn == 'Y' ? 'checked' : ''}
                                           data-is-team-leader="${isTeamLeader}"
                                           status="${list.status}"
                                           hideYn="${list.hideYn}"
                                           data-project-id="${list.id}">

                                    <label class="form-check-label" for="hideSwitch-${list.id}"></label>
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
            <c:if test="${employee.role='TEAM_LEADER'}">
                <div class="modal-header">
                    <h5 class="modal-title">프로젝트 생성</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
            </c:if>
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


<div class="modal fade" id="updateModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="updateform" action="/project/update" method="post">
                <div class="modal-body">

                    <input type="hidden" name="projectId" value="${project.id}"/>

                    <h5>프로젝트 title</h5>
                    <div class="mb-3">
                        <input type="text" id="title" name="title" value="${project.name}">
                    </div>
                    <%--projectinsertDTO 가져와야됨--%>
                    <div class="mb-3">
                        <!-- 프로젝트 기간 설정 버튼 -->
                        프로젝트 기간 설정
                        <input type="date" name="deadLine" value="${project.deadLine}"/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">프로젝트 인원</label>
                        <button type="button" class="btn btn-outline-primary" onclick="updateOpenMemberSearch()">
                            인원 수정
                        </button>

                        <div id="updateMembers" name=class="mt-2">

                        </div>

                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                            onclick="closeupdateModal() ">Close
                    </button>
                    <button type="submit" class="btn btn-primary" onclick="updateSuccess()">수정완료</button>
                </div>
            </form>
        </div>
    </div>
</div>


<%--수정 인원변경모달라인--%>
<div class="modal fade" id="updateMemberSearchModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">멤버 검색</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <!-- 멤버이름 검색 -->
                <div class="mb-3">
                    <input type="text" class="form-control" id="updateMemberSearchInput" placeholder="멤버 이름 검색"
                           onkeyup="UpdateSearchMembers()">
                </div>
                <!-- 검색 결과 리스트 -->
                <div id="updateMemberSearchResults" class="mb-3">
                    <p>검색 결과가 표시됩니다.</p>
                </div>
                <!-- 선택된 멤버 리스트 -->
                <div>
                    <h6 class="mt-3">선택된 멤버</h6>
                    <div id="updateSelectedMembersList" class="d-flex flex-wrap">

                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="closeBtn" data-bs-dismiss="modal">닫기</button>
                <button type="button" class=inputMemberBtn" onclick="updateConfirmSelectedMembers()">확인</button>
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
            <input type="datetime-local" id="updateDeadlineDate" class="dateInput">
            <div class="buttonWrapper">
                <button type="button" id="updateCancelDate" class="modalBtn cancelBtn">취소</button>
                <button type="button" id="updateConfirmDate" class="modalBtn confirmBtn">확인</button>
            </div>
        </div>
    </div>
</div>

<%--프로젝트 멤버추가 라인--%>
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
    const departmentName = '${employee.departmentName}';

    function handleProjectClick(projectId) {
        if (departmentName !== '연구팀') {
            alert('연구팀만 입장이 가능합니다.');
            return;
        } else {
            window.location.href = '/project/detail/' + projectId;
        }
    }

    function openProjectModal() {
        $('#projectModal').modal('show');
    }

    function openUpdateModal(projectId) {
        $.ajax({
            url: '/project/update/' + projectId,
            method: 'GET',
            success: function (data) {
                const project = data.project;
                const selectedMembers = data.selectedMembers;

                $('#title').val(project.name);
                $('input[name="deadLine"]').val(project.deadLine);
                $('input[name="projectId"]').val(project.id);

                if (!deadline) {
                    alert("⚠️ 프로젝트 기간을 설정해주세요.");
                    event.preventDefault();
                    return false;
                }

                if (selectedMembers.length > 0) {
                    selectedMembers.forEach(member => {
                        $('#updateSelectedMembersList').append(`
                        <div class="updateSelected-user" data-id="` + member.id + `">
                            <span>` + member.name + `</span>
                            <button class="remove-user" onclick="$(this).parent().remove()">삭제</button>
                            <input type="hidden" name="employeeId" value="` + member.id + `">
                        </div>
                    `);
                    });
                }
            }
        });

        $('#updateModal').modal('show');
    }

    function openMemberSearch() {
        $('#memberSearchModal').modal('show');
    }

    function updateOpenMemberSearch() {
        $('#updateMemberSearchModal').modal('show');
    }

    function updateSuccess() {
        $('#updateform').submit();
    }

    function closeMemberSearch() {
        $('#memberSearchModal').modal('hide');
    }

    function UpdateSearchMembers() {
        $.ajax({
            url: '/project/searchUser',
            type: 'GET',
            data: {
                name: $('#updateMemberSearchInput').val()
            },
            success: function (data) {
                let memberList = '';
                for (let i = 0; i < data.length; i++) {

                    memberList += '<div class="user-item" data-id="' + data[i].id + '" data-name="' + data[i].name + '">' + data[i].name + ' ' + data[i].jobName + ' ' + data[i].departmentName + '</div>'
                }

                $('#updateMemberSearchResults').html(memberList);

                $('#updateMemberSearchResults').off('click', '.user-item').on('click', '.user-item', function () {
                    const userId = $(this).data('id');
                    const userName = $(this).data('name');

                    if ($('#updateSelectedMembersList').find('[data-id="' + userId + '"]').length === 0) {
                        $('#updateSelectedMembersList').append(
                            $('<div>').addClass('selected-user').attr('data-id', userId)
                                .append($('<span>').html(userName))
                                .append($('<button>').addClass("remove-user").html('삭제').click(function () {
                                    $(this).parent().remove();
                                }))
                                .append($('<input>').attr('type', 'hidden').attr('name', 'employeeId').val(userId))
                        );
                    } else {
                        alert("이미 선택한 직원입니다.");
                    }
                });
            }
        });
    }

    function getUpdateSelectedMembers() {
        let selectedMembers = [];
        $('#selectedMembers .selectedUser').each(function () {
            const id = $(this).attr('data-id');
            if (id) {
                selectedMembers.push(id[1]);
            }
        });
        return selectedMembers;
    }

    function searchMembers() {
        $.ajax({
            url: '/project/searchUser/',
            type: 'GET',
            data: {
                name: $('#memberSearchInput').val()
            },
            success: function (data) {
                let memberList = '';
                for (let i = 0; i < data.length; i++) {
                    memberList += '<div class="user-item" data-id="' + data[i].id + '" data-name="' + data[i].name + '">' + data[i].name + ' ' + data[i].jobName + ' ' + data[i].departmentName + '</div>'
                }


                $('#memberSearchResults').html(memberList);

                $('#memberSearchResults .user-item').click(function () {
                    let userId = $(this).data('id');
                    let userName = $(this).data('name');

                    if ($('#selectedMembersList').find(`[data-id="` + userId + `"]`).length === 0) {
                        $('#selectedMembersList').append(
                            $('<div>').addClass('selected-user').attr('data-id', userId)
                                .append($('<span>').html(userName))
                                .append($('<button>').addClass("remove-user").html('삭제').click(function () {
                                        $(this).parent().remove();
                                    })
                                )
                                .append($('<input>').attr('type', 'hidden').attr('name', 'employeeId').val(userId))
                        );
                    } else {

                        alert("이미 선택한 멤버입니다.");
                    }
                });
            }
        })
    }

    $(document).ready(function () {

        $('.hideSwitch').on('change', function () {
            const target = $(this);
            const projectId = target.data('project-id');
            const isChecked = target.prop('checked');
            const row = $(`#changeRow-${projectId}`);
            const isTeamLeader = '${employee.role == "TEAM_LEADER"}';

            if (isChecked) {
                if (isTeamLeader === true || isTeamLeader === "true") {
                    row.css('opacity', '0.5').addClass("hidden-project");
                } else {
                    row.hide();
                }
            } else {
                row.removeClass("hidden-project").css("opacity", "1").show();
            }
            $.ajax({
                url: "/project/hide",
                method: "POST",
                data: {
                    projectId: projectId,
                    hideYn: isChecked ? 'true' : 'false'
                },
                success: function () {
                    if (isChecked) {
                        alert("숨김 처리되었습니다");
                        location.reload();
                    } else {
                        alert("프로젝트 숨김 상태가 해제되었습니다");
                        location.reload();
                    }
                },
                error: function () {
                    alert("숨김 상태 변경 실패");
                    // 실패 시 UI 복원
                    if (isChecked) {
                        row.css("opacity", "1").show();
                        target.prop('checked', false); // 체크 해제

                    } else {
                        if (isTeamLeader === true || isTeamLeader === "true") {
                            row.css('opacity', '0.5');
                            target.prop('checked', true);

                        } else {
                            row.hide();
                            target.prop('checked', true);
                        }
                    }
                }
            })
        })
        ;
    })

    function confirmSelectedMembers() {
        $("#selectedMembers").html($("#selectedMembersList").html());
        document.activeElement.blur();
        $("#memberSearchModal").modal('hide');
    }

    function createProject(e) {
        $('#projectForm').submit();
    }

    function closeupdateModal() {
        $('#updateModal').modal('hide');
    }

    function updateConfirmSelectedMembers() {
        $("#updateMembers").html($("#updateSelectedMembersList").html());
        document.activeElement.blur();
        $("#updateMemberSearchModal").modal('hide');

        function getSelectedMembers() {
            let updateSelectedMembers = [];
            $('#updateSelectedMembers .updateSelectedUser').each(function () {
                const id = $(this).attr('data-id');
                if (id) {
                    updateSelectedMembers.push(id[1]);
                }
            });
            return updateSelectedMembers;
        }
    }

    function addProjectToTable(response) {
        const tableHtml = `
        <tr onClick="location.href='/works/work/${response.id}'">
            <td>${response.name}</td>
            <td>${response.regDate}</td>
            <td>${response.regDate} ~ ${response.deadLine}</td>
            <td><div class="memberProfile"></div></td>
            <td>${response.hideYn == 'N' ? '진행중' : '종료'}</td>
            <button class="updateProjectBtn" onClick="openUpdateProjectModal(${response.id})">수정</button>
            <button class="deleteProjectBtn" onClick="deleteProject(${response.id})">삭제</button>
        </tr>
    `;
        $('.table tbody').append(tableHtml);
    }

</script>


<jsp:include page="/WEB-INF/views/template/footer.jsp"/>