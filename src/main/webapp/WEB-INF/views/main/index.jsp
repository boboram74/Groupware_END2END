<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/template/header.jsp" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="/css/main/index.css" />
<style>
    /* 엑스트라 라지 사이즈 (1200px) */
    @media screen and (max-width: 1200px) {
        .rightContents {
            display: none;
        }

        .boxContents {
            display: grid;
            grid-template-columns: 1fr 2fr; /* 1:2 비율로 설정 */
            gap: 20px;
        }

        .leftContents {
            width: 100%;
        }

        .centerContents {
            width: 100%;
        }
    }

    @media screen and (max-width: 992px) {
        .boxContents {
            display: flex;
            flex-direction: column;
            gap: 20px;
            padding: 20px;
            padding-bottom: 80px; /* 하단 패딩 추가 */
        }

        .leftContents,
        .centerContents {
            width: 100%;
        }

        /* leftContents와 centerContents의 그리드 해제 */
        .leftContents,
        .centerContents {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        /* 각 박스들의 높이 조정 */
        .logbox,
        .commuteBox,
        .calendarBox,
        .boardBox,
        .approvalBox {
            grid-row: unset; /* 그리드 속성 해제 */
            min-height: 300px; /* 최소 높이 설정 */
        }
    }
</style>
<script>
    function calculateAvailableDimensions() {
        const $container = $('.calendarBox');
        const totalHeight = $container.height();
        const totalWidth = $container.width();
        const titleHeight = $('.boxTitle').outerHeight(true);
        const padding = 40; // 상하/좌우 padding 20px * 2

        console.log(totalHeight - titleHeight - padding);
        console.log(totalWidth - padding);
        return {
            height: totalHeight - titleHeight - padding,
            width: totalWidth - padding
        };
    }

    document.addEventListener('DOMContentLoaded', function() {
        const calendarEl = document.getElementById('calendar');
        const calendar = new FullCalendar.Calendar(calendarEl, {
            locale: 'ko',
            headerToolbar: {
                left: 'title',
                right: 'prev,next',
            },
            initialView: 'dayGridMonth',
            initialDate: new Date(),
            width: '100%',
            height: 'auto',
            events: function(info, successCallback) {
                const view = info.view;
                const visibleStart = info.start;
                const visibleEnd = info.end;

                console.log(visibleStart);
                console.log(visibleEnd);
              //  loadEvents(startDate, endDate, successCallback);
            },
            eventDisplay: 'block',
            // 헤더 스타일 설정
            viewDidMount: function () {
                adjustCalendarSize();
            }
        });

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

        function loadEvents(startDate, endDate, successCallback) {
            const currentYear = startDate.getFullYear();
            const currentMonth = (startDate.getMonth() > 10) ?
                startDate.getMonth() + 1 : '0' + (startDate.getMonth() + 1);
            console.log(currentMonth, currentYear);

            $.ajax({
                url: '/holiday?year=' + currentYear + '&month=' + currentMonth,
                type: 'GET',
                dataType: 'application/json',
                success: function (data) {
                    console.log(data);
                    // successCallback(data);
                }, errors: function(xhr, status, error) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(error);
                }
            })
        }

        calendar.render();
    });

    // 창 크기 변경 시 자동 조절
    let resizeTimer;
    $(window).resize(function() {
        clearTimeout(resizeTimer);
        resizeTimer = setTimeout(function() {
            const dimensions = calculateAvailableDimensions();
            // calendar.setOption('height', dimensions.height);
            // adjustCalendarSize();
        }, 100);
    });
</script>
    <div class="leftContents">
        <div class="logbox surface-bright">
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
        <div class="commuteBox surface-bright">
            <div class="boxTitle">출퇴근 관리</div>
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
        <div class="calendarBox surface-bright">
            <div class="boxTitle">일정</div>
            <div id="calendar"></div>
        </div>
    </div>

    <div class="centerContents">

        <div class="boardBox surface-bright">
            <div class="boxTitle">게시글 목록</div>
            <div class="board-container">
                <!-- 게시판 타입 버튼 -->
                <div class="board-type-buttons">
                    <button class="board-type-btn active">공지 게시판</button>
                    <button class="board-type-btn">전사 게시판</button>
                    <button class="board-type-btn">그룹 게시판</button>
                </div>

                <div class="category-list-container">
                    <div class="category-list">
                        <button class="category-btn active">전체</button>
                        <button class="category-btn">인사</button>
                        <button class="category-btn">회계</button>
                        <button class="category-btn">영업</button>
                        <button class="category-btn">마케팅</button>
                        <button class="category-btn">개발</button>
                        <button class="category-btn">기타</button>
                    </div>

                    <a href="/board/list" class="more-btn">
                        더보기 <span class="material-icons" style="font-size: 16px; vertical-align: middle;">chevron_right</span>
                    </a>
                </div>

                <!-- 게시글 테이블 -->
                <div class="board-table-container">
                    <table class="board-table">
                        <thead>
                        <tr>
                            <th width="8%">번호</th>
                            <th width="52%">제목</th>
                            <th width="20%">글쓴이</th>
                            <th width="20%">등록일자</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach begin="1" end="8" var="i">
                            <tr>
                                <td>${11 - i}</td> <!-- 10부터 1까지 역순으로 표시 -->
                                <td class="title">샘플 게시글 제목입니다 ${11 - i}</td>
                                <td class="writer-info">
                                    <div class="profile-img" style="background-image: url('https://picsum.photos/seed/${i}/200')"></div>
                                    <span>작성자${i}</span>
                                </td>
                                <td>2024-03-19</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="approvalBox surface-bright">
            <div class="boxTitle">나의 결재 대기 문서함</div>
            <div class="board-container">
                <div class="board-table-container">
                    <table class="board-table">
                        <thead>
                        <tr>
                            <th width="10%">기안 번호</th>
                            <th width="50%">제목</th>
                            <th width="20%">기안자</th>
                            <th width="20%">등록 일자</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach begin="1" end="7" var="i">
                            <tr>
                                <td>문서-${5 - i}</td>
                                <td class="title">결재 문서 제목입니다 ${5 - i}</td>
                                <td class="writer-info">
                                    <div class="profile-img" style="background-image: url('https://picsum.photos/seed/${i}/200')"></div>
                                    <span>기안자${i}</span>
                                </td>
                                <td>2024-03-19</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="rightContents">
        <div class="btnBox">
            <button type="button" class="surface-bright" onclick="location.href='/board/write'">
                <span class="material-icons">article</span>
                <span class="btn-text">게시글 작성</span>
            </button>
            <button type="button" class="surface-bright" onclick="location.href='/mail/write'">
                <span class="material-icons">mail</span>
                <span class="btn-text">메일 작성</span>
            </button>
            <button type="button" class="surface-bright" onClick="location.href='/approval/list'">
                <span class="material-icons">edit_note</span>
                <span class="btn-text">결재 작성</span>
            </button>
            <button type="button" class="surface-bright" onclick="location.href='/project/main'">
                <span class="material-icons">work</span>
                <span class="btn-text">보고서 작성</span>
            </button>
        </div>

        <div class="birthBox surface-bright">
            <div class="boxTitle">이달의 생일</div>
            <div class="birth-list">
                <c:forEach items="${birthdayList}" var="item">
                    <div class="birth-item">
                        <div class="birth-profile">
                            <div class="profile-img" style="background-image: url(${item.profileImg})"></div>
                            <div class="birth-info">
                                <div class="birth-name">${item.name} ${item.jobName}</div>
                                <div class="birth-dept">${item.departmentName}</div>
                            </div>
                        </div>
                        <div class="birth-date">
                            <fmt:formatDate value="${item.birthday}" pattern="MM월 dd일"/>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
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

        $('.board-type-btn').click(function() {
            // 모든 버튼에서 active 클래스 제거
            $('.board-type-btn').removeClass('active');
            // 클릭된 버튼에만 active 클래스 추가
            $(this).addClass('active');
        });

        $('.category-btn').click(function() {
            // 모든 버튼에서 active 클래스 제거
            $('.category-btn').removeClass('active');
            // 클릭된 버튼에만 active 클래스 추가
            $(this).addClass('active');
        });
    });
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp" />