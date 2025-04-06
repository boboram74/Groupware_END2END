<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/commute/commute-header.jsp"/>
<style>
    .button-container {
        display: flex;
        justify-content: end;
        gap: 10px;
    }

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

    .box-title {
        padding: 15px;
        font-size: 20px;
        font-weight: 600;
        border-bottom: 1px solid var(--md-sys-color-outline);
    }

    .box-content {
        padding: 20px;
    }

    .work-time-box {
        gap: 24px;
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

    /* 두 번째 컨테이너 스타일 */
    .weekly-status-container {
        grid-row: span 3;
        border-radius: 8px;
    }

    .work-summary {
        display: flex;
        gap: 24px;
        margin-bottom: 20px;
    }

    /* 세 번째 컨테이너 스타일 */
    .weekly-calendar-container {
        grid-row: span 5;
        border-radius: 8px;
        min-height: 400px; /* 캘린더를 위한 임시 높이 */
    }
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
</style>
<div class="button-container">
    <button class="extended-button">연장근무 신청</button>
    <button class="vacation-button">휴가 신청</button>
</div>
<div class="commute-detail-wrapper">
    <!-- 첫 번째 컨테이너: 출퇴근 현황 -->
    <div class="status-container">
        <!-- 1. 출퇴근 버튼 박스 -->
        <div class="commuteBox box surface-bright">
            <div class="box-title">출퇴근 관리</div>
            <div class="timeDisplay">
                <div class="currentDate"></div>
                <div class="currentTime"></div>
            </div>
            <div class="commuteButtons">
                <button class="startWork primary ${isWorkOn ? 'disabled' : ''}"
                ${isWorkOn ? 'disabled' : ''}>출근하기</button>
                <button class="endWork primary">퇴근하기</button>
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
                <div class="vacation-info">
                    <div class="vacation-item">
                        <span>총 휴가</span>
                        <strong>15일</strong>
                    </div>
                    <div class="vacation-item">
                        <span>사용</span>
                        <strong>5일</strong>
                    </div>
                    <div class="vacation-item">
                        <span>잔여</span>
                        <strong>10일</strong>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 두 번째 컨테이너: 주간 근무 현황 -->
    <div class="weekly-status-container surface-bright">
        <div class="box-title">이번 주 근무 현황</div>
        <div class="status-content">
            <div class="work-summary">
                <div class="summary-item">
                    <span class="material-icons">schedule</span>
                    <div class="summary-text">
                        <span>근무시간</span>
                        <strong>40시간 20분</strong>
                    </div>
                </div>
                <div class="summary-item">
                    <span class="material-icons">event_busy</span>
                    <div class="summary-text">
                        <span>휴가사용</span>
                        <strong>1일</strong>
                    </div>
                </div>
            </div>

            <div class="work-records">
                <!-- 근무 기록 목록 -->
            </div>
        </div>
    </div>

    <!-- 세 번째 컨테이너: 주간 캘린더 -->
    <div class="weekly-calendar-container surface-bright">
        <div class="box-title">이번 주 근무 상세</div>
        <div class="calendar-content">
            <!-- 캘린더가 들어갈 자리 -->
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
        let workOnTime = ${workOnTime != null ? workOnTime.getTime() : "null"};
        let workOffTime = ${workOffTime != null ? workOffTime.getTime() : "null"};

        function formatDuration(ms) {
            // 음수 처리
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
            $(className + ' .hours').html(time.hours + '<small>HH</small>');
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

        workTime = getWorkTime();
        setTimeDisplay('.total', formatDuration(workTime));
        setInterval(function () {
            workTime = getWorkTime();
            setTimeDisplay('.total', formatDuration(workTime));
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
                    $(this).attr('disabled', true);
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
                        $(this).attr('disabled', true);
                        workOffTime = new Date(data.regDate).getTime();
                        setTimeDisplay('.work-off-time', formatDuration(workOffTime));
                    }
                })
            }
        });
    });
</script>
<jsp:include page="/WEB-INF/views/commute/commute-footer.jsp"/>