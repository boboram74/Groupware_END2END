<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/commute/commute-header.jsp"/>
<style>
    .button-container {
        display: flex;
        justify-content: end;
        gap: 10px;
    }

    .commute-detail-wrapper {
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    /* 첫 번째 컨테이너 스타일 */
    .status-container {
        display: flex;
        gap: 20px;
        background-color: var(--md-sys-color-surface-container);
        padding: 20px;
        border-radius: 8px;
    }

    .commute-btn-box {
        display: flex;
        flex-direction: column;
        gap: 10px;
    }

    .commute-btn {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 12px 24px;
        border-radius: 6px;
        border: none;
        cursor: pointer;
    }

    .work-time-box {
        display: flex;
        gap: 24px;
        padding: 20px;
        background-color: white;
        border-radius: 8px;
    }

    .vacation-status-box {
        padding: 20px;
        background-color: white;
        border-radius: 8px;
    }

    /* 두 번째 컨테이너 스타일 */
    .weekly-status-container {
        background-color: var(--md-sys-color-surface-container);
        padding: 20px;
        border-radius: 8px;
    }

    .status-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }

    .work-summary {
        display: flex;
        gap: 24px;
        margin-bottom: 20px;
    }

    /* 세 번째 컨테이너 스타일 */
    .weekly-calendar-container {
        background-color: var(--md-sys-color-surface-container);
        padding: 20px;
        border-radius: 8px;
        min-height: 400px; /* 캘린더를 위한 임시 높이 */
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
        <div class="commute-btn-box">
            <button class="commute-btn check-in">
                <span class="material-icons">login</span>
                출근하기
            </button>
            <button class="commute-btn check-out" disabled>
                <span class="material-icons">logout</span>
                퇴근하기
            </button>
        </div>

        <!-- 2. 근무시간 현황 박스 -->
        <div class="work-time-box">
            <div class="time-item">
                <h4>출근 시간</h4>
                <p class="check-in-time">08:50</p>
            </div>
            <div class="time-item">
                <h4>퇴근 시간</h4>
                <p class="check-out-time">미등록</p>
            </div>
            <div class="time-item">
                <h4>오늘 근무시간</h4>
                <p class="total-work-time">5시간 20분</p>
            </div>
        </div>

        <!-- 3. 휴가 현황 박스 -->
        <div class="vacation-status-box">
            <h4>휴가 현황</h4>
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

    <!-- 두 번째 컨테이너: 주간 근무 현황 -->
    <div class="weekly-status-container">
        <div class="status-header">
            <h3>이번 주 근무 현황</h3>
            <span class="period">2024.03.18 - 2024.03.22</span>
        </div>
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
    <div class="weekly-calendar-container">
        <div class="calendar-header">
            <h3>이번 주 근무 상세</h3>
        </div>
        <div class="calendar-content">
            <!-- 캘린더가 들어갈 자리 -->
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/views/commute/commute-footer.jsp"/>