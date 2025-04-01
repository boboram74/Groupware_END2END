<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/hr/chart.css">

<div>
    <div class="hrContainer">
        <div class="hrHeader">
            <h2>직원 관리 DashBoard</h2>
        </div>
        <div class="hrBody">
        <div class="chartUp">
            <div class="chartLeft">
                <canvas id="totalEmployeesChart"></canvas>
            </div>
            <div class="chartRight">
                <canvas id="barChart"></canvas>
            </div>
        </div>
        <div class="chartDown">
            <div class="chartLeft">
                <canvas id="lineChart"></canvas>
            </div>
            <div class="chartRight">
                <canvas id="horizontalBarChart"></canvas>
            </div>
        </div>
        </div>
    </div>
</div>

<script src="/js/hr/chart.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>

