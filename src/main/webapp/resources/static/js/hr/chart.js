document.addEventListener("DOMContentLoaded", function () {

    // 1번 그래프 : 전체 직원 수 (도넛 차트)
    $.ajax({
        url: "/hr/chart/employeeAll",
        method: "GET",
        error : function(request, status, error) {
            console.log("code: " + request.status)
            console.log("message: " + request.responseText)
            console.log("error: " + error);
        },
        success: function (data) {

            const labels = data.map(item => item.LABEL);
            const counts = data.map(item => item.COUNT);

            const ctx1 = document.getElementById("chart1").getContext("2d");
            new Chart(ctx1, {
                type: "doughnut",
                data: {
                    labels: labels,
                    datasets: [{
                        label: "직원 수",
                        data: counts,
                        backgroundColor: [
                            "rgba(75, 192, 192, 0.6)",
                            "rgba(219,99,99,0.6)",
                            "rgba(255, 205, 86, 0.6)",
                            "rgba(153, 102, 255, 0.6)",
                            "rgba(200,122,212,0.6)",
                            "rgba(121,172,229,0.6)"
                        ]
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: "right"
                        }
                    }
                }
            });
        }
    });

    // 2번 그래프 : 직원 변동 현황 (선 그래프: 입사 및 퇴사)
    $.ajax({
        url: "/hr/chart/monthly",
        method: "GET",
        error : function(request, status, error) {
            console.log("code: " + request.status)
            console.log("message: " + request.responseText)
            console.log("error: " + error);
        },
        success: function (data) {

            const ctx2 = document.getElementById("chart2").getContext("2d");

            new Chart(ctx2, {
                type: "line",
                data: {
                    labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                    datasets: [{
                        label: "입사자",
                        data: data.join,
                        borderColor: "rgba(54, 162, 235, 1)",
                        borderWidth: 2,
                        fill: false
                    }, {
                        label: "퇴사자",
                        data: data.resign,
                        borderColor: "rgba(255, 99, 132, 1)",
                        borderWidth: 2,
                        fill: false
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });
        }
    });

    // 3번 그래프 : 부서별 연차 사용 현황 (가로 막대 그래프)
    $.ajax({
        url: "/hr/chart/vacation",
        method: "GET",
        error : function(request, status, error) {
            console.log("code: " + request.status)
            console.log("message: " + request.responseText)
            console.log("error: " + error);
        },
        success: function (data) {
            const labels = data.map(item => item.LABEL);
            const used = data.map(item => item.USED);
            const remain = data.map(item => item.REMAIN);

            const ctx3 = document.getElementById("chart3").getContext("2d");

            new Chart(ctx3, {
                type: "bar",
                data: {
                    labels: labels,
                    datasets: [{
                        label: "사용한 연차",
                        data: used,
                        backgroundColor: "rgba(75, 192, 192, 0.6)"
                    }, {
                        label: "남은 연차",
                        data: remain,
                        backgroundColor: "rgba(153, 102, 255, 0.6)"
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    indexAxis: "y",
                    scales: {
                        x: {
                            beginAtZero: true
                        }
                    },
                    plugins: {
                        legend: {
                            position: "top"
                        },
                        title: {
                            display: true,
                            text: "부서별 연차 사용 현황"
                        }
                    }
                }
            });
        }
    });

    // 4번 그래프 : 부서별 지각/조퇴/결근 통계 (막대 그래프)
    $.ajax({
        url: "/hr/chart/attendance",
        method: "GET",
        error : function(request, status, error) {
            console.log("code: " + request.status)
            console.log("message: " + request.responseText)
            console.log("error: " + error);
        },
        success: function (data) {
            const labels = data.map(item => item.LABEL);
            const late = data.map(item => item.LATE);
            const early = data.map(item => item.EARLY);
            const absent = data.map(item => item.ABSENT);

            const ctx4 = document.getElementById("chart4").getContext("2d");
            new Chart(ctx4, {
                type: "bar",
                data: {
                    labels: labels,
                    datasets: [{
                        label: "지각",
                        data: late,
                        backgroundColor: "rgba(255, 99, 132, 0.6)"
                    }, {
                        label: "조퇴",
                        data: early,
                        backgroundColor: "rgba(255, 205, 86, 0.6)"
                    }, {
                        label: "결근",
                        data: absent,
                        backgroundColor: "rgba(54, 162, 235, 0.6)"
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    },
                    plugins: {
                        title: {
                            display: true,
                            text: "부서별 지각/조퇴/결근 통계"
                        }
                    }
                }
            });
        },
        error: function (err) {
            console.error("지각/조퇴/결근 차트 로딩 실패", err);
        }
    });
});