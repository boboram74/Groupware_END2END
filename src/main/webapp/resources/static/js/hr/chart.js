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
                        data: data.join,    // ⚠️ key가 소문자 "join"이어야 함
                        borderColor: "rgba(54, 162, 235, 1)",
                        borderWidth: 2,
                        fill: false
                    }, {
                        label: "퇴사자",
                        data: data.resign,  // ⚠️ key가 소문자 "resign"이어야 함
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


    // 3번 그래프 : 부서별 직원 수 (가로 막대 그래프)
    const ctx3 = document.getElementById("chart3").getContext("2d");
    new Chart(ctx3, {
        type: "bar",
        data: {
            labels: ["인사", "개발", "운영", "경영", "총무"],
            datasets: [{
                label: "부서별 직원 수",
                data: [25, 40, 30, 35, 20],
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
            }
        }
    });

    // 4번 그래프 : 부서별 지각/조퇴/결근 통계 (막대 그래프)
    const ctx4 = document.getElementById("chart4").getContext("2d");
    new Chart(ctx4, {
        type: "bar",
        data: {
            labels: ["인사", "개발", "운영", "경영", "총무"],
            datasets: [{
                label: "지각",
                data: [5, 12, 8, 10, 7],
                backgroundColor: "rgba(255, 99, 132, 0.6)"
            }, {
                label: "조퇴",
                data: [2, 5, 3, 4, 6],
                backgroundColor: "rgba(255, 205, 86, 0.6)"
            }, {
                label: "결근",
                data: [1, 2, 3, 2, 4],
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
            }
        }
    });
});