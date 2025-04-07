document.addEventListener("DOMContentLoaded", function () {
    // 전체 직원 수 (도넛 차트)
    const ctx1 = document.getElementById("chart1").getContext("2d");
    new Chart(ctx1, {
        type: "doughnut",
        data: {
            labels: ["정규직", "계약직", "인턴", "프리랜서"],
            datasets: [{
                label: "직원 수",
                data: [500, 120, 50, 30],
                backgroundColor: [
                    "rgba(75, 192, 192, 0.6)",
                    "rgba(255, 159, 64, 0.6)",
                    "rgba(255, 205, 86, 0.6)",
                    "rgba(153, 102, 255, 0.6)"
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

    // 직원 변동 현황 (선 그래프: 입사 및 퇴사)
    const ctx2 = document.getElementById("chart2").getContext("2d");
    new Chart(ctx2, {
        type: "line",
        data: {
            labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
            datasets: [{
                label: "입사자",
                data: [10, 15, 20, 25, 30, 35, 40, 38, 42, 45, 50, 55],
                borderColor: "rgba(54, 162, 235, 1)",
                borderWidth: 2,
                fill: false
            }, {
                label: "퇴사자",
                data: [5, 8, 10, 12, 15, 18, 20, 17, 15, 13, 10, 8],
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

    // 부서별 직원 수 (가로 막대 그래프)
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

    // 부서별 지각/조퇴/결근 통계 (막대 그래프)
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