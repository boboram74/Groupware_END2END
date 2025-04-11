<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/commute/commute-header.jsp"/>
<script src='https://cdn.jsdelivr.net/npm/@fullcalendar/list/main.js'></script>
<link href='https://cdn.jsdelivr.net/npm/@fullcalendar/list/main.css' rel='stylesheet' />
<style>
    .box {
        display: flex;
        flex-direction: column;
        height: 100%; /* 전체 높이 사용 */
        border-radius: 8px;
    }

    .box-title {
        padding: 15px;
        font-size: 20px;
        font-weight: 600;
        border-bottom: 1px solid var(--md-sys-color-outline);
        flex-shrink: 0; /* 크기 고정 */
    }

    .box-content {
        flex: 1; /* 남은 공간 모두 사용 */
        padding: 20px;
        display: flex; /* flex 컨테이너로 설정 */
        flex-direction: column; /* 세로 방향 정렬 */
    }

    .commute-list-wrapper {
        display: grid;
        gap: 20px;
        flex: 1;
    }

    .department-info-box {
        height: 300px;
    }

    .group-schedule-list-box {
        flex: 1;
    }
</style>
<div class="search">
    <div>
        <select id="searchOption">
            <option>선택</option>
            <option>선택</option>
            <option>선택</option>
        </select>
    </div>
    <div class="searchInput">
        <input id="input" type="text" name="keyword" placeholder="검색어 입력">
    </div>
    <div>
        <button id="searchBtn"><span class="material-icons">search</span> 검색</button>
    </div>
</div>
<div class="commute-list-wrapper">
    <div class="box department-info-box surface-bright">
        <div class="box-title">
            ${employee.departmentName}
        </div>
        <div class="box-content department-info-content"></div>
    </div>
    <div class="box group-schedule-list-box surface-bright">
        <div class="box-title">
            부서 근무 현황
        </div>
        <div class="box-content" id="calender"></div>
    </div>
</div>
<script>
    $(document).ready(function() {
        const employeeList = [[${employeeList}]]

        const calender = new FullCalendar.Calendar(document.getElementById('calender'), {
            resources: [],
            initialView: 'resourceTimelineWeek',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'listWeek'
            },
            events: [
                {}
            ],
            eventClick: function (info) {
                window.location.href = "/commute/detail?id=" + info.event.id;
            }
        });
        calender.render();
    })
</script>
<jsp:include page="/WEB-INF/views/commute/commute-footer.jsp"/>