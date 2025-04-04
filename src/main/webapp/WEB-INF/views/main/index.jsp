<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/template/header.jsp" />
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            width:350,
            height: 400,
            aspectRatio: 1,
            expandRows: true
        });
        calendar.render();
    });
</script>
<style>
    .boxContents {
        display: grid;
        grid-template-columns: 2fr 5.5fr 2.5fr; /* 3:5:2 비율 설정 */
        max-width: 1850px; /* 최대 너비 설정 */
        margin: 50px auto 0;
        gap: 30px;
        padding: 35px;
    }
    /* 좌측 영역 */
    .leftContents {
        display: grid;
        grid-template-rows: repeat(24, 1fr);
        gap: 20px;
    }

    /* commuteBox 수정 - grid-row 값을 4에서 3으로 변경 */
    .commuteBox {
        grid-row: span 3;  /* 4에서 3으로 변경하여 높이 25% 감소 */
        background: white;
        border-radius: 10px;
        display: flex;
        flex-direction: column;
        overflow: hidden;
    }


    .calenderBox {
        grid-row: span 8;
        background-color: white;
        border-radius: 10px;
    }

    /* 중앙 영역 */
    .centerContents {
        display: grid;
        grid-template-rows: repeat(24, 1fr);
        gap: 20px;
    }

    .boardBox {
        grid-row: span 8;
        background-color: white;
        border-radius: 10px;
    }

    .v {
        grid-row: span 4;
        background-color: white;
        border-radius: 10px;
    }

    /* 우측 영역 */
    .rightContents {
        display: grid;
        grid-template-rows: repeat(24, 1fr);
        gap: 20px;
    }

    .btnBox {
        grid-row: span 2;
        display: grid;
        grid-template-columns: 1fr 1fr;
        grid-template-rows: 1fr 1fr;
        gap: 10px;
        padding: 0;
    }

    .btnBox button {
        width: 100%;
        height: 100%;
        border: 1px solid rgba(0, 0, 0, 0.1);
        border-radius: 6px;
        background: white;
        color: navy;
        font-size: 25px;
        font-weight: 600;
        padding: 30px 20px; /* 패딩 증가로 버튼 크기 키움 */
        word-break: keep-all;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 8px;
        margin: 0;
        transition: all 0.2s ease-in-out;
        line-height: 1.2; /* 줄 간격 조정 */
    }

    .btnBox button:hover {
        background: #003465;
        color: white;
        transform: translateY(-1px);
    }

    .birthBox {
        grid-row: span 9;
        background-color: white;
        border-radius: 10px;
    }

    /* imgBox 수정 */
    .imgBox {
        width: 140px;
        height: 140px;
        border-radius: 50%;
        overflow: hidden;
        margin-bottom: 20px;
        background-image: url("/image/defaultImg.jpg");
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        border: 1px solid #eee; /* 테두리 추가 */
    }

    /* logbox 수정 */
    .logbox {
        grid-row: span 5;
        background-color: white;
        border-radius: 10px;
        padding: 10px; /* 상하좌우 패딩 축소 */
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
    }

    /* information 수정 */
    .information {
        width: 90%;
        height: 98px;
        display: flex;
        flex-direction: column;
        gap: 12px;
        padding: 15px;
        background: #f8f9fa;
        border-radius: 8px;
        box-sizing: border-box; /* padding이 width에 포함되도록 설정 */
    }

    .info-item {
        display: flex;
        align-items: center;
        font-size: 14px;
        justify-content: center;
        font-wieght: 600;
    }

    /* 이름 스타일 */
    .info-item.name {
        font-size: 20px;
        font-weight: 600;
        color: #333;
    }

    /* 부서 스타일 */
    .info-item.department {
        font-size: 14px;
        color: #666;
    }

    .info-summary {
        margin-top: 10px;
        padding-top: 10px;
        border-top: 1px solid #eee;
        width: 100%; /* information 전체 너비만큼 확장 */
        box-sizing: border-box; /* padding이 width에 포함되도록 설정 */
    }

    .summary-item {
        display: flex;
        align-items: center;
        justify-content: space-between; /* 양끝 정렬 */
        padding: 5px 0;
        font-size: 22px;
        color: #666;
        margin-left: 20px;
        margin-right: 20px;
    }

    .summary-item .material-icons {
        font-size: 22px;
        color: #003465;
    }

    .summary-left {
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .summary-count {
        color: #003465; /* 배경 제거하고 텍스트 색상만 변경 */
        font-weight: 600;
        font-size: 22px;
    }

    .boxTitle {
        padding: 15px;
        font-size: 20px;
        font-weight: 600;
        border-bottom: 1px solid #eee;
    }

    .currentDate {
        font-size: 18px;
        font-weight: 500;
        margin-bottom: 10px;
        color: #666;
    }

    .currentTime {
        font-size: 35px;
        font-weight: 600;
        color: #333;
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
        background: white;
        color: navy;
        cursor: pointer;
        transition: all 0.2s ease-in-out;
    }

    .commuteButtons button:hover {
        background: #003465;
        color: white;
        transform: translateY(-1px);
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

    .startWork {
        background-color: #4CAF50;
        color: white;
    }

    .endWork {
        background-color: #f44336;
        color: white;
    }

    .commuteButtons button:hover {
        opacity: 0.9;
        transform: translateY(-2px);
    }

    .commuteButtons button:active {
        transform: translateY(0);
    }

    #calendar {
        max-width: 350px;
        max-height: 400px;
    }

    .material-icons {
        font-size: 20px;
    }

    .btn-text {
        font-size: 14px;
    }

    /* 반응형을 위한 미디어 쿼리 추가 */
    @media screen and (max-width: 1740px) { /* 1700px + 좌우 패딩 고려 */
        .boxContents {
            padding: 20px;
        }
    }

    @media screen and (max-width: 1024px) {
        .leftContents,
        .rightContents {
            width: 250px;
        }
    }

    @media screen and (max-width: 768px) {
        .leftContents,
        .rightContents {
            width: 200px;
        }
    }
</style>

    <div class="leftContents">
        <div class="logbox">
            <div class="imgBox" style="background-image: url(${employee.profileImg})"></div>
            <div class="information">
                <div class="info-item name">
                    ${employee.name} ${employee.jobName}
                </div>
                <div class="info-item department">
                    ${employee.departmentName}
                </div>
            </div>
            <div class="info-summary">
                <div class="summary-item">
                    <div class="summary-left">
                        <span class="material-icons">mail</span>
                        <span class="summary-text">새 메일</span>
                    </div>
                    <span class="summary-count">5</span>
                </div>
                <div class="summary-item">
                    <div class="summary-left">
                        <span class="material-icons">event</span>
                        <span class="summary-text">오늘 일정</span>
                    </div>
                    <span class="summary-count">3</span>
                </div>
            </div>
        </div>
        <div class="commuteBox">
            <div class="boxTitle">출퇴근 관리</div>
            <div class="timeDisplay">
                <div class="currentDate"></div>
                <div class="currentTime"></div>
            </div>
            <div class="commuteButtons">
                <button class="startWork">출근하기</button>
                <button class="endWork">퇴근하기</button>
            </div>
        </div>
        <div class="calenderBox" id='calendar'>캘린더</div>
    </div>

    <div class="centerContents">
        <div class="boardBox">게시판 목록
            <div class="boardlist">
                <h3>최근 게시물 들어올 자리 !</h3>
                <table>
                    <thead>
                    <tr id="title"></tr>
                    </thead>
                    <tbody id="latestboard"></tbody>
                </table>
            </div>
        </div>
        <div class="v">나의 결재 대기 문서함</div>
    </div>

    <div class="rightContents">
        <div class="btnBox">
            <button type="button">
                <span class="material-icons">article</span>
                <span class="btn-text">게시글 작성</span>
            </button>
            <button type="button">
                <span class="material-icons">mail</span>
                <span class="btn-text">메일 작성</span>
            </button>
            <button type="button">
                <span class="material-icons">edit_note</span>
                <span class="btn-text">결재 작성</span>
            </button>
            <button type="button">
                <span class="material-icons">work</span>
                <span class="btn-text">보고서 작성</span>
            </button>
        </div>
        <div class="birthBox">생일</div>
    </div>
<script>
    $(document).ready(function() {
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

        // 1초마다 업데이트
        setInterval(updateDateTime, 1000);

        // 출퇴근 버튼 클릭 이벤트 (필요한 경우)
        $('.startWork').click(function() {
            // 출근 버튼 클릭 시 동작
            console.log('출근');
        });

        $('.endWork').click(function() {
            // 퇴근 버튼 클릭 시 동작
            console.log('퇴근');
        });
    });
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp" />