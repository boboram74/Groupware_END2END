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
        display: flex;
        width: 100%;
        height: calc(100vh - 50px);
        margin-top: 50px;
        gap: 20px;
        padding: 20px;
    }

    /* 좌측 영역 */
    .leftContents {
        width: 300px;
        display: grid;
        grid-template-rows: repeat(24, 1fr);
        gap: 20px;
    }

    .loginlist {
        grid-row: span 4;
        background-color: white;
        border-radius: 10px;
    }

    .calenderBox {
        grid-row: span 8;
        background-color: white;
        border-radius: 10px;
    }

    /* 중앙 영역 */
    .centerContents {
        flex: 1;
        display: grid;
        grid-template-rows: repeat(24, 1fr);
        gap: 20px;
    }

    .boardBox {
        grid-row: span 11;
        background-color: white;
        border-radius: 10px;
    }

    .v {
        grid-row: span 9;
        background-color: white;
        border-radius: 10px;
    }

    /* 우측 영역 */
    .rightContents {
        width: 300px;
        display: grid;
        grid-template-rows: repeat(24, 1fr);
        gap: 20px;
    }

    .btnBox {
        grid-row: span 4;
        display: grid;
        grid-template-columns: 1fr 1fr;
        grid-template-rows: 1fr 1fr;
        gap: 10px;
        padding: 15px;
        background: white;
        border-radius: 10px;
    }

    .btnBox button {
        width: 100%;
        height: 100%;
        border: 1px solid rgba(0, 0, 0, 0.1);
        border-radius: 6px;
        background: white;
        color: navy;
        font-size: 14px;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 8px;
        margin: 0;
        transition: all 0.2s ease-in-out;
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
        grid-row: span 7;
        background-color: white;
        border-radius: 10px;
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
        </div>
        <div class="loginlist">최근 로그인 내역</div>
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

<jsp:include page="/WEB-INF/views/template/footer.jsp" />