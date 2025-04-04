<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/hr/chart.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<div class="mainContainer">
    <div class="mainHeader">
        <div class="title">
            <h2><span class="material-icons">insert_chart</span>직원관리 DashBoard</h2>
        </div>
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
</div>
<script src="/js/hr/chart.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
