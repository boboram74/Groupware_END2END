<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/commute/commute-header.jsp"/>
<style>
    /* 기본 버튼 스타일 */
    .button-container button {
        padding: 8px 16px;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.2s ease;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .button-container .primary:hover {
        /*
        background-color: var(--md-sys-color-on-primary);
        color: var(--md-sys-color-primary);
        */
        opacity: 0.9;


    }

    .button-container .secondary:hover {
        opacity: 0.9;
    }
</style>
<style>
    .commute-detail-wrapper {
        display: grid;
        grid-template-rows: repeat(11, 1fr);
        gap: 20px;
    }

    /* 첫 번째 컨테이너 스타일 */
    .status-container {
        grid-row: span 3;
        display: grid;
        grid-template-columns: 2fr 3fr 5fr;
        gap: 20px;
        border-radius: 8px;
    }

    .box {
        display: flex;
        flex-direction: column;
        height: 100%; /* 전체 높이 사용 */
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

    .work-time-box {
        border-radius: 8px;
    }

    .time-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 0; /* gap 제거하고 border로 대체 */
        position: relative; /* border 위치 지정을 위해 */
    }

    /* 구분선 추가 */
    .time-grid::after {
        content: '';
        position: absolute;
        left: 50%;
        top: 10%; /* 위아래 여백 */
        height: 80%; /* 구분선 높이 */
        width: 1px;
        background-color: var(--md-sys-color-outline-variant);
    }

    .time-column {
        display: flex;
        flex-direction: column;
        gap: 20px;
        padding-right: 20px; /* 구분선과의 간격 */
    }

    .time-item {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .time-item h4 {
        font-size: 14px;
        color: var(--md-sys-color-on-surface-variant);
        margin: 0;
    }

    .time-display {
        display: flex;
        gap: 8px;
        align-items: center;
        justify-content: center;
    }

    .time-unit {
        display: inline-flex;
        flex-direction: column;
        align-items: center;
        font-size: 24px;
        font-weight: 600;
        min-width: 50px;
        padding: 4px;
        background: var(--md-sys-color-surface-container-high);
        border-radius: 4px;
    }

    .time-unit small {
        font-size: 12px;
        font-weight: normal;
        color: var(--md-sys-color-secondary);
    }

    .total-time-column {
        display: flex;
        flex-direction: column;
        align-items: flex-start; /* 왼쪽 정렬로 변경 */
        padding-left: 20px; /* 구분선과의 간격 */
        height: 100%; /* 전체 높이 사용 */
    }

    .time-item.total {
        width: 100%;
        height: 100%; /* 전체 높이 사용 */
        display: flex;
        flex-direction: column;
    }

    .time-item.total .time-display {
        flex: 1; /* 남은 공간 모두 차지 */
        justify-content: center; /* 수평 가운데 정렬 */
        align-items: center; /* 수직 가운데 정렬 */
        margin-top: 0; /* 기존 마진 제거 */
    }

    .time-item.total h4 {
        text-align: left;
        margin-bottom: 8px;
    }

    /* 모든 time-item의 h4 스타일 통일 */
    .time-item h4 {
        font-size: 14px;
        color: var(--md-sys-color-on-surface-variant);
        margin: 0 0 8px;
    }

    .vacation-status-box {
        border-radius: 8px;
    }

    .vacation-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 20px;
        position: relative;
        height: 100%; /* box-content의 전체 높이 사용 */
        flex: 1; /* 남은 공간 모두 사용 */
    }

    .vacation-grid::after,
    .vacation-grid::before {
        content: '';
        position: absolute;
        top: 10%;
        height: 80%;
        width: 1px;
        background-color: var(--md-sys-color-outline-variant);
    }

    .vacation-grid::before {
        left: 33%;
    }

    .vacation-grid::after {
        left: 66%;
    }

    .vacation-item {
        display: flex;
        flex-direction: column;
        gap: 8px;
        padding: 15px 10px;
    }

    .vacation-item h4 {
        font-size: 14px;
        color: var(--md-sys-color-on-surface-variant);
        margin: 0;
        text-align: center;
        padding-top: 20px; /* 상단 여백 추가 */
    }

    .vacation-display {
        flex: 1; /* 남은 공간 모두 사용 */
        display: flex;
        gap: 8px;
        align-items: center;
        justify-content: center;
    }

    .vacation-unit {
        display: inline-flex;
        flex-direction: column;
        align-items: center;
        font-size: 32px; /* 크기 증가 */
        font-weight: 600;
        min-width: 80px; /* 너비 증가 */
        min-height: 60px; /* 높이 지정 */
        padding: 8px 12px; /* 패딩 증가 */
        background: var(--md-sys-color-surface-container-high);
        border-radius: 4px;
        justify-content: center; /* 세로 중앙 정렬 */
    }

    .vacation-unit small {
        font-size: 14px; /* 단위 텍스트 크기 증가 */
        font-weight: normal;
        color: var(--md-sys-color-secondary);
    }

    /* 두 번째 컨테이너 스타일 */
    .weekly-status-box {
        grid-row: span 3;
        border-radius: 8px;
    }

    .weekly-status-grid {
        display: grid;
        grid-template-columns: repeat(7, 1fr);
        gap: 20px;
        position: relative;
        height: 100%;
        flex: 1;
    }

    /* 구분선 */
    .weekly-status-grid > div:not(:last-child)::after {
        content: '';
        position: absolute;
        top: 10%;
        height: 80%;
        width: 1px;
        background-color: var(--md-sys-color-outline-variant);
        right: 0;
    }

    .status-item {
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: 0 10px;
        height: 100%;
        position: relative;
    }

    .status-item h4 {
        font-size: 14px;
        color: var(--md-sys-color-on-surface-variant);
        margin: 0;
        text-align: center;
        padding-top: 20px;
    }

    .status-display {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .status-unit {
        display: inline-flex;
        flex-direction: column;
        align-items: center;
        font-size: 32px;
        font-weight: 600;
        min-width: 80px;
        min-height: 60px;
        padding: 8px 12px;
        background: var(--md-sys-color-surface-container-high);
        border-radius: 4px;
        justify-content: center;
    }

    .status-unit small {
        font-size: 14px;
        font-weight: normal;
        color: var(--md-sys-color-secondary);
        margin-top: 4px;
    }

    /* 반응형을 위한 미디어 쿼리 */
    @media (max-width: 1200px) {
        .weekly-status-grid {
            grid-template-columns: repeat(4, 1fr); /* 4열로 변경 */
            grid-template-rows: auto auto; /* 2행으로 변경 */
        }

        /* 구분선 재조정 */
        .weekly-status-grid > div:not(:last-child)::after {
            content: '';
            right: 0;
        }

        .weekly-status-grid > div:nth-child(4)::after {
            display: none; /* 4번째 아이템 뒤의 구분선 제거 */
        }
    }

    @media (max-width: 768px) {
        .weekly-status-grid {
            grid-template-columns: repeat(2, 1fr); /* 2열로 변경 */
            grid-template-rows: auto auto auto auto; /* 4행으로 변경 */
        }

        .status-unit {
            font-size: 28px;
            min-width: 70px;
        }
    }

    /* 세 번째 컨테이너 스타일 */
    .weekly-calendar-container {
        grid-row: span 5;
        border-radius: 8px;
        height: 500px;
        min-height: 400px; /* 캘린더를 위한 임시 높이 */
    }

    #calendar {
        max-width: 100%;
        margin: 0 auto;
        padding: 20px;
    }

    .fc-view {
        border: none !important;
    }

    .fc-daygrid-day {
        border: none !important;
        height: 60px !important;
    }

    .custom-date {
        text-align: center;
        padding: 5px;
    }

    .day-name {
        font-size: 14px;
        color: #666;
    }

    .day-number {
        font-size: 20px;
        font-weight: bold;
        margin-top: 5px;
    }

    /* 주말 색상 */
    .fc-day-sat .day-name { color: blue; }
    .fc-day-sun .day-name { color: red; }


</style>
<style>
    .commuteBox {
        border-radius: 8px;
    }

    .currentDate {
        font-size: 18px;
        font-weight: 500;
        margin-bottom: 10px;
        color: var(--md-sys-color-secondary);
    }

    .currentTime {
        font-size: 35px;
        font-weight: 600;
    }

    .commuteButtons {
        display: flex;
        justify-content: center; /* 가운데 정렬 추가 */
        gap: 10px;
        padding: 10px;
    }

    /* 출퇴근 버튼 스타일 수정 */
    .commuteButtons button {
        width: 120px; /* 버튼 너비 고정 */
        padding: 12px;
        font-size: 18px;
        font-weight: 500;
        border: 1px solid rgba(0, 0, 0, 0.1);
        border-radius: 6px;
        cursor: pointer;
        transition: all 0.2s ease-in-out;
    }

    /* timeDisplay 여백 조정 */
    .timeDisplay {
        flex: 1;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        padding: 10px;  /* 패딩 살짝 줄임 */
    }

    .commuteButtons button:hover:not(.disabled) {
        opacity: 0.9;
    }

    .startWork.disabled {
        opacity: 0.5;
        pointer-events: none; /* 호버 효과 완전히 제거 */
    }

    .endWork.disabled {
        opacity: 0.5;
        pointer-events: none; /* 호버 효과 완전히 제거 */
    }
</style>
<div class="button-container">
    <button class="extended-button primary">연장근무 신청</button>
    <button class="vacation-button primary">휴가 신청</button>
    <button class="vacation-list-button secondary">휴가 조회</button>

</div>
<div class="commute-detail-wrapper">
    <!-- 첫 번째 컨테이너: 출퇴근 현황 -->
    <div class="status-container">
        <!-- 1. 출퇴근 버튼 박스 -->
        <div class="commuteBox box surface-bright">
            <div class="box-title">출퇴근 관리</div>
            <div class="box-content">
                <div class="timeDisplay">
                    <div class="currentDate"></div>
                    <div class="currentTime"></div>
                </div>
                <div class="commuteButtons">
                    <button class="startWork primary ${isWorkOn ? 'disabled' : ''}"
                    ${isWorkOn ? 'disabled' : ''}>출근하기</button>
                    <button class="endWork primary ${isWorkOff ? 'disabled' : ''}"
                    ${isWorkOff ? 'disabled' : ''}>퇴근하기</button>
                </div>
            </div>
        </div>
        <!-- 2. 근무시간 현황 박스 -->
        <div class="box work-time-box surface-bright">
            <div class="box-title">근무 시간</div>
            <div class="box-content">
                <div class="time-grid">
                    <div class="time-column">
                        <div class="time-item">
                            <h4>출근 시간</h4>
                            <div class="time-display work-on-time">
                                <span class="time-unit hours">
                                    <c:choose>
                                        <c:when test="${workOnTime == null}">
                                            --
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatDate value="${workOnTime}" pattern="HH"/>
                                        </c:otherwise>
                                    </c:choose>
                                    <small>HH</small></span>
                                <span class="time-unit min">
                                    <c:choose>
                                        <c:when test="${workOnTime == null}">
                                            --
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatDate value="${workOnTime}" pattern="mm"/>
                                        </c:otherwise>
                                    </c:choose>
                                    <small>MM</small></span>
                                <span class="time-unit sec">
                                    <c:choose>
                                        <c:when test="${workOnTime == null}">
                                            --
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatDate value="${workOnTime}" pattern="ss"/>
                                        </c:otherwise>
                                    </c:choose>
                                    <small>SS</small></span>
                            </div>
                        </div>
                        <div class="time-item">
                            <h4>퇴근 시간</h4>
                            <div class="time-display work-off-time">
                                <span class="time-unit hour">
                                    <c:choose>
                                        <c:when test="${workOffTime == null}">
                                            --
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatDate value="${workOffTime}" pattern="HH"/>
                                        </c:otherwise>
                                    </c:choose>
                                    <small>HH</small></span>
                                <span class="time-unit min">
                                    <c:choose>
                                        <c:when test="${workOffTime == null}">
                                            --
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatDate value="${workOffTime}" pattern="mm"/>
                                        </c:otherwise>
                                    </c:choose>
                                    <small>MM</small></span>
                                <span class="time-unit sec">
                                    <c:choose>
                                        <c:when test="${workOffTime == null}">
                                            --
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatDate value="${workOffTime}" pattern="ss"/>
                                        </c:otherwise>
                                    </c:choose>
                                    <small>SS</small></span>
                            </div>
                        </div>
                    </div>
                    <div class="total-time-column">
                        <div class="time-item total">
                            <h4>오늘 근무시간</h4>
                            <div class="time-display">
                                <span class="time-unit hour">00<small>HH</small></span>
                                <span class="time-unit min">00<small>MM</small></span>
                                <span class="time-unit sec">00<small>SS</small></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 3. 휴가 현황 박스 -->
        <div class="box vacation-status-box surface-bright">
            <div class="box-title">휴가 현황</div>
            <div class="box-content">
                <div class="vacation-grid">
                    <div class="vacation-item">
                        <h4>총 휴가일</h4>
                        <div class="vacation-display">
                            <span class="vacation-unit">${totalVacationDates}<small>일</small></span>
                        </div>
                    </div>
                    <div class="vacation-item">
                        <h4>총 사용일</h4>
                        <div class="vacation-display">
                            <span class="vacation-unit">${totalUsedVacationDates}<small>일</small></span>
                        </div>
                    </div>
                    <div class="vacation-item">
                        <h4>이번달 사용일</h4>
                        <div class="vacation-display">
                            <span class="vacation-unit">${thisMonthUsedVacationDates}<small>일</small></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 두 번째 컨테이너: 주간 근무 현황 -->
    <div class="box weekly-status-box surface-bright">
        <div class="box-title">주간 근무 현황</div>
        <div class="box-content">
            <div class="weekly-status-grid">
                <div class="status-item">
                    <h4>출근</h4>
                    <div class="status-display">
                        <span class="status-unit">${workOnCount}<small>일</small></span>
                    </div>
                </div>
                <div class="status-item">
                    <h4>지각</h4>
                    <div class="status-display">
                        <span class="status-unit">${lateCount}<small>회</small></span>
                    </div>
                </div>
                <div class="status-item">
                    <h4>조퇴</h4>
                    <div class="status-display">
                        <span class="status-unit">${leaveEarlyCount}<small>회</small></span>
                    </div>
                </div>
                <div class="status-item">
                    <h4>결근</h4>
                    <div class="status-display">
                        <span class="status-unit">${absenceCount}<small>일</small></span>
                    </div>
                </div>
                <div class="status-item">
                    <h4>연장근무</h4>
                    <div class="status-display">
                        <span class="status-unit">0<small>일</small></span>
                    </div>
                </div>
                <div class="status-item">
                    <h4>이번주 근무시간</h4>
                    <div class="status-display weekly-total">
                        <span class="time-unit hour">00<small>HH</small></span>
                        <span class="time-unit min">00<small>MM</small></span>
                        <span class="time-unit sec">00<small>SS</small></span>
                    </div>
                </div>
                <div class="status-item">
                    <h4>출석률</h4>
                    <div class="status-display">
                        <span class="status-unit">${workOnRate}<small>%</small></span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 세 번째 컨테이너: 주간 캘린더 -->
    <div class="box weekly-calendar-container surface-bright">
        <div class="box-title">이번 주 근무 상세</div>
        <div class="calendar-content" id="calendar">
            <!-- 캘린더가 들어갈 자리 -->
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
        let workOnTime = ${workOnTime != null ? workOnTime.getTime() : "null"};
        let workOffTime = ${workOffTime != null ? workOffTime.getTime() : "null"};
        let totalWorkTimeThisWeek = ${totalWorkTimeThisWeek};

        function formatDuration(ms) {
            const millisec = Math.abs(ms);

            const hours = (Math.floor(millisec / (60 * 60 * 1000)) >= 10)
                ? Math.floor(millisec / (60 * 60 * 1000)) : '0' + Math.floor(millisec / (60 * 60 * 1000));
            const minutes = (Math.floor((millisec % (60 * 60 * 1000)) / (60 * 1000)) >= 10)
                ? Math.floor((millisec % (60 * 60 * 1000)) / (60 * 1000)) : '0' + Math.floor((millisec % (60 * 60 * 1000)) / (60 * 1000));
            const seconds = (Math.floor((millisec % (60 * 1000)) / 1000) >= 10) ?
                Math.floor((millisec % (60 * 1000)) / 1000) : '0' + Math.floor((millisec % (60 * 1000)) / 1000);

            return {
                hours,
                minutes,
                seconds
            };
        }

        function setTimeDisplay(className, time) {
            $(className + ' .hour').html(time.hours + '<small>HH</small>');
            $(className + ' .min').html(time.minutes + '<small>mm</small>');
            $(className + ' .sec').html(time.seconds + '<small>ss</small>');
        }

        let workTime = 0;
        function getWorkTime() {
            if (workOnTime != null && workOffTime != null) {
                workTime = workOffTime - workOnTime;
            } else if (workOnTime != null) {
                workTime = Date.now() - workOnTime;
            }
            return workTime;
        }

        function getTotalWorkTimeThisWeek(workTime) {
            if (workOffTime == null) {
                return totalWorkTimeThisWeek + workTime;
            }

            return totalWorkTimeThisWeek;
        }

        workTime = getWorkTime();
        setTimeDisplay('.total', formatDuration(getWorkTime()));
        setTimeDisplay('.weekly-total', formatDuration(getTotalWorkTimeThisWeek(workTime)));
        setInterval(function () {
            workTime = getWorkTime();
            const displayTotalWorkTimeThisWeek = getTotalWorkTimeThisWeek(workTime);
            setTimeDisplay('.total', formatDuration(workTime));
            setTimeDisplay('.weekly-total', formatDuration(displayTotalWorkTimeThisWeek));
        }, 1000);


        // 날짜와 시간 표시 함수
        function updateDateTime() {
            const now = new Date();

            // 날짜 포맷팅
            const dateOptions = {
                year: 'numeric',
                month: 'long',
                day: 'numeric',
                weekday: 'long'
            };
            const dateStr = now.toLocaleDateString('ko-KR', dateOptions);

            // 시간 포맷팅
            const timeOptions = {
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit',
                hour12: false
            };
            const timeStr = now.toLocaleTimeString('ko-KR', timeOptions);

            // jQuery로 HTML 업데이트
            $('.currentDate').text(dateStr);
            $('.currentTime').text(timeStr);
        }

        // 초기 실행
        updateDateTime();
        setInterval(updateDateTime, 1000);

        // 출퇴근 버튼 클릭 이벤트 (필요한 경우)
        $('.startWork').click(function () {
            $.ajax({
                url: '/commute/workOn'
            }).done(function (data) {
                if (data) {
                    alert("출근하셨습니다.");
                    location.reload();
                }
            })
        });

        $('.endWork').click(function () {
            if(confirm("퇴근하시겠습니까?")) {
                $.ajax({
                    url: '/commute/workOff'
                }).done(function (data) {
                    if (data) {
                        alert("퇴근했습니다.");
                        location.reload();
                    }
                })
            }
        });
    });

    $(function() {
        function calculateAvailableDimensions() {
            const $container = $('#calendar').closest('.box');
            const totalHeight = $container.height();
            const totalWidth = $container.width();
            const titleHeight = $('.box-title').outerHeight(true);
            const padding = 40; // 상하/좌우 padding 20px * 2

            return {
                height: totalHeight - titleHeight - padding,
                width: totalWidth - padding
            };
        }


        const calendar = new FullCalendar.Calendar($('#calendar')[0], {
            initialView: 'dayGridWeek'
            ,  // 일주일 보기로 초기 설정
            headerToolbar: {
                left: 'prev today',
                center: 'title',
                right: 'next'  // 주간 보기만 표시
            },
            locale: 'ko',
            height: calculateAvailableDimensions().height,
            width: calculateAvailableDimensions().width,
            dayHeaders: true,  // 요일 표시
            dayHeaderFormat: {weekday: 'short', month: 'numeric', day: 'numeric'}, // 날짜 포맷
            weekNumbers: false,  // 주차 숨기기
            // 캘린더가 처음 마운트되고 이벤트를 로드할 때
            events: function(info, successCallback) {
                const startDate = parseDate(info.start);
                const endDate = parseDate(info.end);
                loadEvents(startDate, endDate, successCallback);
            },
            viewDidMount: function() {
                adjustCalendarSize();
            },
            eventDisplay: 'block',
            displayEventTime: false,
            eventTimeFormat: {
                hour: '2-digit',
                minute: '2-digit',
                hour12: false
            },
            // 날짜 범위 변경 시 호출
            datesSet: function(info) {
                console.log('보여지는 날짜 범위:', {
                    start: info.start,
                    end: info.end
                });
            }

        });

        function parseDate(dates) {
            return dates.getFullYear() + '-' + (dates.getMonth() + 1) + '-' + dates.getDate();
        }

        function toStringDate(date) {
            try {
                // LocalDate 객체인 경우
                if (date && typeof date === 'object' && 'year' in date && 'month' in date && 'day' in date) {
                    const year = date.year;
                    const month = String(date.month).padStart(2, '0');
                    const day = String(date.day).padStart(2, '0');

                    return year + '-' + month + '-' + day;
                }

                throw new Error('유효하지 않은 LocalDate 형식');

            } catch(e) {
                return null;
            }
        }

        function loadEvents(startDate, endDate, successCallback) {
            $.ajax({
                url: '/commute/select/period?startDate=' + startDate + '&endDate=' + endDate,
                type: 'GET'
            }).done(function(data) {
                calendar.removeAllEvents();
                const events = data.map(function(event) {
                    console.log(event);
                    return {
                        title: event.title,
                        start: new Date(event.startDate),
                        allDay: event.allDay,
                        display: event.display,
                    }
                })
                successCallback(events);
            })
        }

        function adjustCalendarSize() {
            const dimensions = calculateAvailableDimensions();

            // 캘린더 컨테이너에 크기 적용
            $('#calendar').css({
                'width': dimensions.width + 'px',
                'max-width': '100%'
            });

            // FullCalendar 내부 요소 조정
            $('.fc').css({
                'width': '100%',
                'font-size': dimensions.width < 500 ? '0.8em' : '1em' // 작은 화면에서 폰트 크기 조정
            });
        }

        calendar.render();

        let resizeTimer;
        $(window).resize(function() {
            clearTimeout(resizeTimer);
            resizeTimer = setTimeout(function() {
                const dimensions = calculateAvailableDimensions();
                calendar.setOption('height', dimensions.height);
                adjustCalendarSize();
            }, 100);
        });
    });
</script>
<jsp:include page="/WEB-INF/views/commute/commute-footer.jsp"/>