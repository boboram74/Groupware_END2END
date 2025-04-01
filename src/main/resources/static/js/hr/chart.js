// 전체 직원 수 (도넛 차트)
const ctx4 = document.getElementById("totalEmployeesChart").getContext("2d");
const totalEmployeesChart = new Chart(ctx4, {
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


// 막대 그래프 (직원 수 증가)
const ctx1 = document.getElementById("barChart").getContext("2d");
const barChart = new Chart(ctx1, {
    type: "bar",
    data: {
        labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
        datasets: [{
            label: "직원 수 증가",
            data: [10, 15, 30, 20, 25, 50, 45, 55, 60, 70, 75, 80],
            backgroundColor: "rgba(54, 162, 235, 0.6)"
        }]
    },
    options: {
        responsive: true,
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});

// 선 그래프 (직원 수 변화)
const ctx2 = document.getElementById("lineChart").getContext("2d");
const lineChart = new Chart(ctx2, {
    type: "line",
    data: {
        labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
        datasets: [{
            label: "직원 수 변화",
            data: [500, 520, 510, 530, 550, 560, 580, 590, 600, 610, 620, 630],
            borderColor: "rgba(75, 192, 192, 1)",
            borderWidth: 2,
            fill: false
        }]
    },
    options: {
        responsive: true
    }
});

// 가로 막대 그래프 (부서별 직원 수)
const ctx3 = document.getElementById("horizontalBarChart").getContext("2d");
const horizontalBarChart = new Chart(ctx3, {
    type: "bar",
    data: {
        labels: ["May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
        datasets: [{
            label: "부서별 직원 수",
            data: [5000, 7000, 8000, 6000, 9000, 7500, 8200, 9100],
            backgroundColor: "rgba(153, 102, 255, 0.6)"
        }]
    },
    options: {
        responsive: true,
        indexAxis: "y",
        scales: {
            x: {
                beginAtZero: true
            }
        }
    }
});
