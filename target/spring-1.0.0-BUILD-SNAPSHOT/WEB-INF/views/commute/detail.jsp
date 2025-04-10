<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/commute/commute-header.jsp"/>
<link rel="stylesheet" href="/css/commute/detail.css" />
<style>
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

    /* CSS에 추가 */
    .simple-dot-event {
        border: none !important;
    }

    .simple-dot-event::before {
        content: '';
        display: inline-block;
        width: 8px;
        height: 8px;
        background-color: var(--md-sys-color-primary);
        border-radius: 50%;
        margin-right: 4px;
        vertical-align: middle;
    }

    /* 시간 표시 숨기기 */
    .fc-event-time {
        display: none !important;
    }

    .fc-h-event.simple-dot-event {
        padding: 0 !important;
        color: var(--md-sys-color-primary) !important;
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
        <div class="calendar-content" id="calendar"></div>
    </div>
</div>

<style>
    /* 모달 기본 스타일 */
    .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 1000;
    }

    .modal-content {
        position: relative;
        margin: 5% auto;
        width: 80%;
        max-width: 800px;
        border-radius: 12px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .modal-header {
        padding: 20px;
        border-bottom: 1px solid var(--md-sys-color-outline);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .modal-header h2 {
        margin: 0;
        font-size: 1.5rem;
        color: var(--md-sys-color-on-surface);
    }

    .close {
        font-size: 28px;
        font-weight: bold;
        color: var(--md-sys-color-on-surface-variant);
        cursor: pointer;
    }

    .close:hover {
        color: var(--md-sys-color-on-surface);
    }

    .vacation-stat-box h3 {
        margin: 0 0 10px 0;
        font-size: 1rem;
        color: var(--md-sys-color-on-surface-variant);
    }

    /* 휴가 내역 테이블 스타일 */
    .vacation-history {
        padding: 20px;
        border-radius: 8px;
    }

    .vacation-history h3 {
        margin: 0 0 20px 0;
        font-size: 1.2rem;
    }

    .vacation-table {
        width: 100%;
        border-collapse: collapse;
    }

    .vacation-table th,
    .vacation-table td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid var(--md-sys-color-outline-variant);
    }

    .vacation-table th {
        background-color: var(--md-sys-color-surface-container-high);
        color: var(--md-sys-color-on-surface);
        font-weight: 600;
    }

    .vacation-table tr:last-child td {
        border-bottom: none;
    }

    /* 반응형 스타일 */
    @media (max-width: 768px) {
        .vacation-stats {
            grid-template-columns: 1fr;
            gap: 10px;
        }

        .modal-content {
            width: 95%;
            margin: 10% auto;
        }

        .vacation-table {
            display: block;
            overflow-x: auto;
        }
    }
</style>

<script>
    // 모달 관련 JavaScript
    const modal = document.getElementById('vacationModal');
    const closeBtn = document.getElementsByClassName('close')[0];
    const vacationListBtn = document.getElementById('vacation-list-button');

    $('.vacation-list-button').on('click', function() {
        $('#vacationModal').show();
    })

    // X 버튼으로 모달 닫기
    closeBtn.onclick = function() {
        modal.style.display = "none";
    }

    // 모달 외부 클릭시 닫기
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>

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
                const startDate = info.start;
                const endDate = info.end;
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
            },
            eventClassNames: 'simple-dot-event'
        });

        function parseDate(dates) {
            return dates.getFullYear() + '-' + (dates.getMonth() + 1) + '-' + dates.getDate();
        }

        function loadEvents(startDate, endDate, successCallback) {
            const startDateStr = parseDate(startDate);
            const endDateStr = parseDate(endDate);
            $.ajax({
                url: '/commute/select/period?startDate=' + startDateStr + '&endDate=' + endDateStr,
                type: 'GET'
            }).done(function(data) {
                calendar.removeAllEvents();
                const events = data.map(function(event) {
                    console.log(event);
                    if (event.eventName === 'period') {
                        return {
                            title: event.title,
                            start: new Date(event.startDate),
                            end: new Date(event.endDate),
                            allDay: true,
                            display: 'block',
                        }
                    }
                    return {
                        title: event.title,
                        start: new Date(event.startDate),
                        allDay: event.allDay,
                        display: 'block',
                    }
                })
                console.log(events);
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