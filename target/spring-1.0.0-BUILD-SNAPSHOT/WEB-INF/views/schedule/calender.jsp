<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/template/exam.css"/>
<style>
    .calender-container {
        color: var(--md-sys-color-surface);
    }
</style>
<div class="mainHeader surface-bright">
    <div class="detail-menu-header">
        <div class="detail-menu-title">
            <span class="material-icons">event_available</span>
            <span>일정/예약</span>
        </div>
        <button class="detail-menu-toggle-btn">
            <span class="material-icons">menu</span>
        </button>
    </div>
    <div class="detail-menu-modal">
        <ul class="detail-menu-list">
            <li class="detail-menu-item active">
                <span class="material-icons">calendar_month</span>
                <span>일정</span>
            </li>
            <li class="detail-menu-item">
                <span class="material-icons">event_available</span>
                <span>예약</span>
            </li>
        </ul>
        <button class="detail-modal-close">
            <span class="material-icons">close</span>
        </button>
    </div>
</div>

<div class="mainContainer">
    <div class="mainBody">
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
        <div class="button-container">
            <button class="primary">일정 추가</button>
            <button class="secondary">캘린더 관리</button>
        </div>
        <div class="calender-container">
            <div id="calendar"></div>
        </div>
    </div>
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

        $(function() {
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
    <script>
        $(document).ready(function() {
            $('.detail-menu-item').on('click', function() {
                $('.detail-menu-item').removeClass('active');
                $(this).addClass('active');
                // 클릭 이벤트 처리 로직
            });

            const $menuBtn = $('.detail-menu-toggle-btn');
            const $detailMenuModal = $('.detail-menu-modal');
            const $closeBtn = $('.detail-modal-close');

            // 메뉴 버튼 클릭 시 모달 열기
            $menuBtn.on('click', function() {
                $detailMenuModal.addClass('active');
                $('body').css('overflow', 'hidden');
            });

            // 닫기 버튼 클릭 시 모달 닫기
            $closeBtn.on('click', function() {
                $detailMenuModal.removeClass('active');
                $('body').css('overflow', '');
            });

            // 모달 외부 클릭 시 닫기
            $(window).on('click', function(e) {
                if ($(e.target).is($detailMenuModal)) {
                    $detailMenuModal.removeClass('active');
                    $('body').css('overflow', '');
                }
            });
        });
    </script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>