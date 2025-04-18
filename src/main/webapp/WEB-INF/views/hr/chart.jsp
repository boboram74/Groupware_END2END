<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/template/exam.css" />
<link rel="stylesheet" href="/css/hr/chart.css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div class="mainHeader surface-bright">
    <div class="detail-menu-header">
        <div class="detail-menu-title">
            <span class="material-icons">people</span>
            <span>인사 관리</span>
        </div>
        <button class="detail-menu-toggle-btn">
            <span class="material-icons">menu</span>
        </button>
    </div>
    <div class="detail-menu-modal">
        <ul class="detail-menu-list">
            <li class="detail-menu-item">
                <a href="/hr/list">
                    <span class="material-icons">badge</span>
                    <span>직원 관리</span>
                </a>
            </li>
            <li class="detail-menu-item active">
                <a href="/hr/chart">
                    <span class="material-icons">insert_chart</span>
                    <span>직원 통계</span>
                </a>
            </li>
        </ul>
        <button class="detail-modal-close">
            <span class="material-icons">close</span>
        </button>
    </div>
</div>

<div class="mainContainer">
        <div class="mainBody">
            <div class="chartRow">
                <div class="chart1">
                    <canvas id="chart1"></canvas>
                </div>
                <div class="chart2">
                    <canvas id="chart2"></canvas>
                </div>
            </div>

            <div class="chartRow">
                <div class="chart3">
                    <canvas id="chart3"></canvas>
                </div>
                <div class="chart4">
                    <canvas id="chart4"></canvas>
                </div>
            </div>

        </div>
</div>
<script src="/js/hr/chart.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>