<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/hr/chart.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div class="mainContainer">
    <div class="mainHeader">
        <div class="title">
            <h2><span class="material-icons">mail</span>직원관리 DashBoard</h2>
        </div>
        <div class="mainBody">
            <div class="chartUp">
                <div class="chartLeft">
                    <canvas id="totalEmployeesChart"></canvas>
                </div>
                <div class="chartRight">
                    <canvas id="employeeChangeChart"></canvas>
                </div>
            </div>
            <div class="chartDown">
                <div class="chartLeft">
                    <canvas id="departmentChart"></canvas>
                </div>
                <div class="chartRight">
                    <canvas id="attendanceChart"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="/js/hr/chart.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
