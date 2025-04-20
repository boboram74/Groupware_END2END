<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/template/exam.css"/>
<link rel="stylesheet" href="/css/schedule/book.css"/>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@6.1.17/index.global.min.js'></script>

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
            <li class="detail-menu-item" onClick="location.href='/calendar/list'">
                <span class="material-icons">calendar_month</span>
                <span>일정</span>
            </li>
            <li class="detail-menu-item active" onClick="location.href='/book/list'">
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
        <div class="button-container">
            <button class="primary insert-schedule open-write-schedule">예약 하기</button>
            <button class="secondary open-list-calendar">사용 완료</button>
        </div>
        <div class="calender-container">
            <div id="calendar"></div>
        </div>
    </div>

    <!-- 일정 작성 모달 -->
    <div class="detail-modal" id="scheduleWriteModal" style="display: none;">
        <div class="box modal-container surface-bright">
            <div class="box-title">
                <h2>예약 등록</h2>
            </div>

            <div class="box-content">
                <form id="scheduleWriteForm" action="/book/insert" method="post">
                    <input type="hidden" name="id" value="0">
                    <div class="form-group">
                        <label>캘린더 선택</label>
                        <select name="calendarId" class="form-select" required>
                            <option value="">캘린더를 선택하세요</option>
                            <c:forEach items="${calendarList}" var="calendar">
                                <option value="${calendar.id}">${calendar.title}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>예약 종류</label>
                        <select name="targetType" class="form-select" required onChange="updateTarget()">
                            <option value="">선택하십시오.</option>
                            <option value="meetingRoomId">회의실</option>
                            <option value="furnitureId">비품</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>예약 상세</label>
                        <select name="targetId" class="form-select" id="sub-select">
                            <option value="" disabled selected>먼저 분류를 선택해주세요</option>
                            <c:forEach items="${bookTargetList}" var="item">
                                <option value="${item.id}" data-type="${item.targetType}" style="display: none;">
                                        ${item.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>시작 일시</label>
                        <div class="datetime-wrapper">
                            <input type="date" min="<fmt:formatDate value='<%= new java.util.Date() %>' pattern='yyyy-MM-dd'/>"  id="insert-startDate" class="form-input" required>
                            <select required id="insert-startTime">
                                <option value="">선택하십시오</option>
                                <c:forEach begin="9" end="18" var="i">
                                    <option value=" ${i < 10 ? '0'.concat(i) : i}:00:00">${i < 10 ? '0'.concat(i) : i}:00</option>
                                    <option value=" ${i < 10 ? '0'.concat(i) : i}:30:00">${i < 10 ? '0'.concat(i) : i}:30</option>
                                </c:forEach>
                            </select>
                        </div>
                        <input type="hidden" name="startDate" class="form-input">
                    </div>

                    <div class="form-group">
                        <label>종료 일시</label>
                        <div class="datetime-wrapper">
                            <input type="date" min="<fmt:formatDate value='<%= new java.util.Date() %>' pattern='yyyy-MM-dd'/>"  id="insert-endDate" class="form-input" required>
                            <select required id="insert-endTime">
                                <option value="">선택하십시오</option>
                                <c:forEach begin="9" end="18" var="i">
                                    <option value=" ${i < 10 ? "0" + i : i}:00:00">${i < 10 ? "0" + i : i}:00</option>
                                    <option value=" ${i < 10 ? "0" + i : i}:30:00">${i < 10 ? "0" + i : i}:30</option>
                                </c:forEach>
                            </select>
                        </div>
                        <input type="hidden" name="endDate" class="form-input">
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="primary" id="schedule-input-btn">저장</button>
                        <button type="button" class="secondary" id="schedule-write-close-btn">취소</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- 캘린더 목록 모달 -->
    <div class="detail-modal" id="listCalendarModal" style="display: none;">
        <div class="box modal-container surface-bright">
            <div class="box-title">
                <h2>캘린더 관리</h2>
            </div>
            <div class="box-content">
                <div class="form-group">
                    <label>캘린더 선택</label>
                    <select id="calendar-select" class="form-select">
                        <option value="" selected disabled>캘린더를 선택하세요</option>
                        <c:forEach items="${calendarList}" var="calendar">
                            <option value="${calendar.id}">${calendar.title}</option>
                        </c:forEach>
                    </select>
                </div>
                <div id="calendar-info">
                    <div class="form-group">
                        <label>캘린더 정보</label>
                        <div class="info-container">
                            <div class="form-group">
                                <label>이름</label>
                                <input type="text" id="cal-name" class="form-input">
                            </div>
                            <div class="form-group">
                                <label>색상</label>
                                <div id="cal-color" class="color-circle" style="width: 24px; height: 24px; border-radius: 50%;"></div>
                            </div>
                            <div class="form-group">
                                <label>공유 멤버</label>
                                <div class="selected-employees" id="cal-members"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="primary" id="editCalendarBtn">수정</button>
                    <button type="button" class="secondary close-modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function updateTarget() {
            const mainSelect = $('select[name=targetType]');
            const subSelect = $('select[name=targetId]');
            const mainValue = mainSelect.val();
            subSelect.find('option').each(function() {
                $(this).hide();
            });
            subSelect.find('option').hide();


            if (mainValue) {
                subSelect.find('option[data-type="' + mainValue + '"]').show();
                subSelect.prop('disabled', false);
            } else {
                subSelect.prop('disabled', true);
            }
        }

        function calculateAvailableDimensions() {
            const $container = $('.calenda-container');
            const totalHeight = $container.height();
            const totalWidth = $container.width();
            const padding = 40;

            return {
                height: totalHeight - padding,
                width: totalWidth - padding
            };
        }

        $(document).ready(function() {
            const calendar = new FullCalendar.Calendar(document.getElementById('calendar'), {
                locale: 'ko',
                resources: function (fetchInfo, successCallback, failureCallback) {
                    $.ajax({
                        url: '/book/list/items'
                    }).done(function(data) {
                        const resources = data.map((item) => {
                            return {
                                id: item.name,
                                name: item.name,
                                img: item.img,
                                targetId: String(item.id),
                                type: item.targetType,
                                location: item.location,
                                capacity: item.capacity,
                            }
                        })
                        successCallback(resources);
                    })
                },
                resourceLabelContent: function(arg) {
                    const div = $('<div class="resource-title">');
                    const profileImg = $('<div class="profile-img">')
                        .attr('style', 'background-image: url(' + arg.resource.extendedProps.img + ')');
                    const nameSpan = $('<span>').text(arg.resource.extendedProps.name);

                    div.append(profileImg)
                        .append(nameSpan);

                    return { domNodes: [div[0]] }
                },
                initialView: 'resourceTimeline',
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: ''
                },
                events: function(info, successCallback) {
                    const startDate = info.start;
                    const endDate = info.end;
                    loadEvents(startDate, endDate, successCallback);
                },
                slotDuration: '00:30:00', // 30분 단위로 시간 표시
                slotMinTime: '09:00:00', // 시작 시간
                slotMaxTime: '18:00:00', // 종료 시간
                allDaySlot: false, // 종일 슬롯 숨기기
                nowIndicator: true, // 현재 시간 표시
                scrollTime: '09:00:00', // 초기 스크롤 위치
                businessHours: { // 업무 시간 강조
                    startTime: '09:00',
                    endTime: '18:00'
                },
                slotLabelInterval: '01:00', // 시간 레이블 간격
                // 주말 숨기기
                hiddenDays: [0, 6], // 일요일(0), 토요일(6)
                // 시간 포맷
                views: {
                    timeGridWeek: {
                        titleFormat: { year: 'numeric', month: 'long', day: '2-digit' }
                    }
                },
                slotMinWidth: '100%', // 슬롯 최소 너비
                expandRows: true, // 행 확장

                // 이벤트 렌더링 커스터마이징
                eventDidMount: function(info) {
                    info.el.style.width = '100%';
                    info.el.style.margin = '0';
                    info.el.style.left = '0';
                },
                eventClassNames: ['full-width-event']
            });

            function parseDate(dates) {
                const month = String(dates.getMonth() + 1).padStart(2, '0');
                const date = String(dates.getDate()).padStart(2, '0');
                return dates.getFullYear() + '-' + month + '-' + date;
            }

            function loadEvents(startDate, endDate, successCallback) {
                startDate = parseDate(startDate);
                endDate = parseDate(endDate);
                $.ajax({
                    url: '/book/list/period?startDate=' + startDate + '&endDate=' + endDate,
                    type: 'GET',
                    success: function (data) {
                        const events = data.map(function(event) {
                            return {
                                resourceId: event.eventName,
                                title: event.title,
                                start: new Date(event.startDate),
                                end: new Date(event.endDate),
                                allDay: false,
                                display: 'block',
                                color: event.backgroundColor,
                                extendedProps: {
                                    id: event.id,
                                    type: 'schedule'
                                }
                            }
                        })
                        successCallback(events);
                    }, errors: function(xhr, status, error) {
                    }
                })
            }

            calendar.render();
        });

        function formatDate(date) {
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            return year + '-' + month + '-' + day;
        }

        function formatTimeToHHMMSS(date) {
            const hours = String(date.getHours()).padStart(2, '0');
            const minutes = String(date.getMinutes()).padStart(2, '0');
            const seconds = String(date.getSeconds()).padStart(2, '0');
            return hours + ':' + minutes + ':' + seconds;
        }

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

        $('#insert-startDate').on('change', function() {
            const date = $(this).val();
            const targetType = $('select[name=targetType]').val();
            const targetId = $('select[name=targetId]').val();
            $.ajax({
                url: '/book/detail/date?date=' + date + '&targetType=' + targetType + '&targetId=' + targetId,
                type: 'GET',
                success: function (data) {
                    const dataStartDate = new Date(data.startDate);
                    const dataEndDate = new Date(data.endDate);
                    $('#insert-startTime').find('option')
                        .prop('disabled', false).removeClass('reserved')
                        .each(function() {
                        const startDateTime = new Date(date + $(this).val());
                            if (startDateTime > dataStartDate && startDateTime < dataEndDate) {
                                $(this).prop('disabled', true).addClass('reserved');
                            }
                    })
                }
            })
        })

        $('#insert-endDate').on('change', function() {
            const date = $(this).val();
            const targetType = $('select[name=targetType]').val();
            const targetId = $('select[name=targetId]').val();
            $.ajax({
                url: '/book/detail/date?date=' + date + '&targetType=' + targetType + '&targetId=' + targetId,
                type: 'GET',
                success: function (data) {
                    const dataStartDate = new Date(data.startDate);
                    const dataEndDate = new Date(data.endDate);
                    $('#insert-endTime').find('option')
                        .prop('disabled', false).removeClass('reserved')
                        .each(function() {
                            const startDateTime = new Date(date + $(this).val());
                            if (startDateTime > dataStartDate && startDateTime < dataEndDate) {
                                $(this).prop('disabled', true).addClass('reserved');
                            }
                        })
                }
            })
        })
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
    <script>
        $(document).ready(function() {
            $('#schedule-write-close-btn').on('click', function() {
                $('#scheduleWriteModal').fadeOut(300);
            })

            // 모달 열기
            $('.open-list-calendar').click(function() {
                $('#listCalendarModal').show();
            });

            // 모달 닫기
            $('#listCalendarModal .close-modal').click(function() {
                $('#listCalendarModal').hide();
            });

            $('#calendar-delete-btn').on('click', function() {
                if(confirm("정말 삭제하시겠습니까?")) {
                    location.href = '/calendar/delete/' + $('#calendarWriteForm input[name=id]').val();
                }
            })

            $(document).on('click', '.open-write-schedule', function() {
                $('#scheduleWriteModal').fadeIn(300);
            });

            // 모달 닫기
            $('.modal-close, .close-modal').click(function() {
                $('#scheduleWriteModal').fadeOut(300);
            });

            // 모달 외부 클릭 시 닫기
            $(window).click(function(e) {
                if ($(e.target).is('.detail-modal')) {
                    $('#scheduleWriteModal').fadeOut(300);
                }
            });

            $('#schedule-detail-close').on('click', function() {
                $('#eventDetailModal').fadeOut(300);
            })
        });
    </script>
    <script>
        // 종료 일시
        $('#insert-endDate, #insert-endTime').on('change', function() {
            const date = $('#insert-endDate').val();
            const time = $('#insert-endTime').val();

            if (date && time) {
                $('input[name="endDate"]').val(date + time);
            }
        });

        // 시작 일시
        $('#insert-startDate, #insert-startTime').on('change', function() {
            const date = $('#insert-startDate').val();
            const time = $('#insert-startTime').val();

            if (date && time) {
                $('input[name="startDate"]').val(date + time);
            }
        });
    </script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>