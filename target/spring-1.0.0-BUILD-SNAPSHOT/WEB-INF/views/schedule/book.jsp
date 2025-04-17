<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/template/exam.css"/>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@6.1.17/index.global.min.js'></script>
<style>
    .calender-container {
        color: var(--md-sys-color-surface);
    }

    .detail-modal {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        display: flex;
        justify-content: center;
        align-items: center;
        z-index: 1000;
    }

    /* box, box-content 스타일을 활용하면서 모달 특성에 맞게 일부 수정 */
    .detail-modal .modal-container {
        width: 500px;  /* 모달 너비 조정 */
        margin: 0;     /* box 클래스의 기본 마진 제거 */
    }

    .detail-modal .modal-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }

    .detail-modal .modal-header h2 {
        font-size: 1.5rem;
        font-weight: bold;
        margin: 0;
    }

    .detail-modal .modal-close {
        border: none;
        cursor: pointer;
        padding: 4px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .detail-modal .modal-body {
        max-height: 70vh;
        overflow-y: auto;
    }

    .detail-modal .form-group {
        margin-bottom: 15px;
    }

    .detail-modal .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 500;
        color: var(--md-sys-color-surface);
    }

    .detail-modal .form-group input,
    .detail-modal .form-group textarea {
        width: 100%;
        padding: 8px 12px;
        border: 1px solid #ddd;
        border-radius: 6px;
        font-size: 14px;
    }

    .detail-modal .form-group input,
    .detail-modal .form-group textarea {
        width: 100%;
        padding: 8px 12px;
        border: 1px solid var(--md-sys-color-outline-variant);
        border-radius: 4px;
        background-color: var(--md-sys-color-surface-bright);
        color: var(--md-sys-color-surface);
    }


    .detail-modal .modal-footer {
        margin-top: 24px;
        display: flex;
        justify-content: flex-end;
        gap: 12px;
    }

    .detail-modal .modal-footer button {
        padding: 8px 16px;
        border-radius: 6px;
        font-weight: 500;
        cursor: pointer;
    }

    .detail-modal .modal-footer button:hover {
        opacity: 0.9;
    }


    .color-options {
        display: flex;
        flex-wrap: wrap;
        gap: 12px;
        margin-top: 8px;
    }

    .color-radio {
        position: relative;
        cursor: pointer;
    }

    .color-radio input {
        position: absolute;
        opacity: 0;
        width: 0;
        height: 0;
    }

    .color-circle {
        display: block;
        width: 24px;
        height: 24px;
        border-radius: 50%;
        border: 2px solid transparent;
        transition: all 0.2s ease;
    }

    /* 선택되지 않은 상태의 호버 효과 */
    .color-radio:hover .color-circle {
        transform: scale(1.1);
    }

    /* 선택된 상태 스타일 */
    .color-radio input:checked + .color-circle {
        border-color: var(--md-sys-color-primary);
        transform: scale(1.1);
    }

    /* 선택된 상태의 호버 효과 */
    .color-radio input:checked:hover + .color-circle {
        transform: scale(1.2);
    }

    /* 포커스 상태 스타일 */
    .color-radio input:focus + .color-circle {
        box-shadow: 0 0 0 2px rgba(0, 0, 0, 0.1);
    }

    .employee-selector {
        border: 1px solid var(--md-sys-color-outline);
        border-radius: 4px;
        background-color: var(--md-sys-color-surface-bright);
        margin-top: 8px;
    }

    .selected-employees {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
        min-height: 32px;
        padding: 8px;
        border-bottom: 1px solid var(--md-sys-color-outline);
    }

    .selected-employee-tag {
        display: inline-flex;
        align-items: center;
        background-color: var(--md-sys-color-surface-container);
        padding: 4px 12px;
        border-radius: 16px;
        font-size: 14px;
        gap: 4px;
    }

    .selected-employee-tag .material-icons {
        font-size: 18px;
        cursor: pointer;
    }

    .employee-list {
        max-height: 200px;
        overflow-y: auto;
    }

    .calendar-employee-item {
        padding: 12px;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 12px;
        transition: background-color 0.2s;
    }

    .calendar-employee-item:hover {
        background-color: var(--md-sys-color-surface-container);
    }

    .calendar-employee-item.selected {
        background-color: var(--md-sys-color-surface-container);
    }

    .calendar-employee-item .material-icons {
        color: var(--md-sys-color-outline);
        font-size: 24px;
    }

    .employee-info {
        display: flex;
        flex-direction: column;
        gap: 2px;
    }

    .employee-name {
        font-weight: 500;
        color: var(--md-sys-color-surface);
    }

    .employee-dept {
        font-size: 12px;
        color: var(--md-sys-color-surface-variant);
    }

</style>
<style>
    .form-select {
        width: 100%;
        padding: 8px 12px;
        border: 1px solid var(--md-sys-color-outline-variant);
        border-radius: 4px;
        background-color: var(--md-sys-color-surface-bright);
        color: var(--md-sys-color-surface);
        font-size: 14px;
    }

    .form-input {
        width: 100%;
        padding: 8px 12px;
        border: 1px solid var(--md-sys-color-outline-variant);
        border-radius: 4px;
        background-color: var(--md-sys-color-surface-bright);
        color: var(--md-sys-color-surface);
        font-size: 14px;
    }

    /* date input과 select를 감싸는 컨테이너 */
    .datetime-wrapper {
        display: flex;
        gap: 10px;
        align-items: center;
    }

    /* date input 스타일 */
    .datetime-wrapper input[type="date"] {
        flex: 2;  /* 날짜 입력이 더 넓게 */
        min-width: 150px;
        padding: 8px 12px;
        border: 1px solid var(--md-sys-color-outline-variant);
        border-radius: 4px;
        background-color: var(--md-sys-color-surface-bright);
        color: var(--md-sys-color-surface);
    }

    /* select 스타일 */
    .datetime-wrapper select {
        flex: 1;  /* 시간 선택은 더 좁게 */
        min-width: 100px;
        padding: 8px 12px;
        border: 1px solid var(--md-sys-color-outline-variant);
        border-radius: 4px;
        background-color: var(--md-sys-color-surface-bright);
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
            <button class="primary insert-schedule open-write-schedule">일정 추가</button>
            <button class="primary open-write-calender">캘린더 추가</button>
            <button class="secondary open-list-calendar">캘린더 관리</button>
        </div>
        <div class="calender-container">
            <div id="calendar"></div>
        </div>
    </div>

    <!-- 일정 작성 모달 -->
    <div class="detail-modal" id="scheduleWriteModal" style="display: none;">
        <div class="box modal-container surface-bright">
            <div class="box-title">
                <h2>일정 등록</h2>
            </div>

            <div class="box-content">
                <form id="scheduleWriteForm" action="/schedule/insert" method="post">
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
                        <label>일정 제목</label>
                        <input type="text" name="title" class="form-input" required>
                    </div>

                    <div class="form-group">
                        <label>시작 일시</label>
                        <div class="datetime-wrapper">
                            <input type="date" id="insert-startDate" class="form-input" required>
                            <select required id="insert-startTime">
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
                            <input type="date" id="insert-endDate" class="form-input" required>
                            <select required id="insert-endTime">
                                <c:forEach begin="9" end="18" var="i">
                                    <option value=" ${i < 10 ? "0" + i : i}:00:00">${i < 10 ? "0" + i : i}:00</option>
                                    <option value=" ${i < 10 ? "0" + i : i}:30:00">${i < 10 ? "0" + i : i}:30</option>
                                </c:forEach>
                            </select>
                        </div>
                        <input type="hidden" name="endDate" class="form-input">
                    </div>

                    <div class="form-group">
                        <label>일정 내용</label>
                        <textarea name="content" rows="4" class="form-input"></textarea>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="primary" style="display: none;" id="schedule-update-complete-btn">수정완료</button>
                        <button type="button" class="secondary" style="display: none;" id="schedule-delete-btn">삭제</button>
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
                                <input type="text" id="cal-name" class="form-input" readonly>
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

    <!-- 상세 정보 모달 -->
    <div class="detail-modal" id="eventDetailModal" style="display: none;">
        <div class="modal-container box surface-bright">
            <div class="modal-header box-title">
                <h2>일정 상세 정보</h2>
            </div>
            <div class="box-content">
                <div class="form-group">
                    <label>제목</label>
                    <div id="detail-title"></div>
                </div>
                <div class="form-group">
                    <label>시작일</label>
                    <div id="detail-start"></div>
                </div>
                <div class="form-group">
                    <label>종료일</label>
                    <div id="detail-end"></div>
                </div>
                <div class="form-group">
                    <label>설명</label>
                    <div id="detail-content"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="primary" id="schedule-detail-update">수정</button>
                    <button type="button" class="secondary" id="schedule-detail-close">닫기</button>
                </div>
            </div>
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
        $(document).ready(function() {
            const calendar = new FullCalendar.Calendar(document.getElementById('calendar'), {
                locale: 'ko',
                resources: function (fetchInfo, successCallback, failureCallback) {
                    $.ajax({
                        url: '/book/list/items'
                    }).done(function(data) {
                        console.log(data);

                        const resources = data.map((item) => {
                            return {
                                id: String(item.id),
                                name: item.name,
                                img: item.img,
                                type: item.targetType,
                                location: item.location,
                                capacity: item.capacity,
                            }
                        })
                        successCallback(resources);
                    })
                },
                resourceLabelContent: function(arg) {
                    return {
                        html: "<div class=resource-title><div class='profile-img'></div><span>" + arg.resource.extendedProps.name + "</span></div>"
                    }
                },
                initialView: 'resourceTimelineWeek',
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
                slotDuration: '24:00:00',     // 24시간(하루) 단위로 표시
                duration: { days: 7 },        // 7일 표시
                slotMinTime: '00:00:00',      // 시작 시간
                slotMaxTime: '24:00:00',      // 종료 시간

                // 날짜 헤더 포맷 설정
                views: {
                    resourceTimelineWeek: {
                        type: 'resourceTimeline',
                        duration: { days: 7 },
                        slotDuration: { days: 1 },
                        headerToolbar: {
                            start: 'M/D'
                        }
                    }
                },
            });

            function parseDate(dates) {
                const month = String(dates.getMonth() + 1).padStart(2, '0');
                const date = String(dates.getDate()).padStart(2, '0');
                return dates.getFullYear() + '-' + month + '-' + date;
            }

            function loadEvents(startDate, endDate, successCallback) {
                startDate = parseDate(startDate);
                endDate = parseDate(endDate);

                console.log(startDate, endDate);

                $.ajax({
                    url: '/schedule/list?startDate=' + startDate + '&endDate=' + endDate,
                    type: 'GET',
                    success: function (data) {
                        console.log(data);
                        const events = data.map(function(event) {
                            console.log(event);
                            if (event.eventName === 'period') {
                                return {
                                    id: event.id,
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
                            }
                            return {
                                title: event.title,
                                start: new Date(event.startDate),
                                allDay: event.allDay,
                                display: 'block',
                                color: event.backgroundColor,
                            }
                        })
                        console.log(events);
                        successCallback(events);
                    }, errors: function(xhr, status, error) {
                        console.log(xhr.status);
                        console.log(xhr.responseText);
                        console.log(error);
                    }
                })
            }

            function openDetailModal(id) {
                $.ajax({
                    url: '/schedule/detail/' + id,
                    type: 'GET',
                    success: function (data) {
                        console.log(data);
                        const startDateTime = new Date(data.startDate);
                        const endDateTime = new Date(data.endDate);

                        const startDate = formatDate(startDateTime);
                        const startTime = ' ' + formatTimeToHHMMSS(startDateTime);

                        const endDate = formatDate(endDateTime);
                        const endTime = ' ' + formatTimeToHHMMSS(endDateTime);

                        $('#detail-title').text(data.title);
                        $('#detail-start').text(startDate + startTime);
                        $('#detail-end').text(endDate + endTime);
                        $('#detail-content').text(data.content);

                        $('#eventDetailModal').show();

                        $('#schedule-delete-btn').on('click', function() {
                            location.href = '/schedule/delete/' + data.id;
                        })

                        $('#schedule-detail-update').on('click', function() {

                            $('#scheduleWriteForm input[name=id]').val(data.id);
                            $('#scheduleWriteForm select[name=calendarId]').val(data.calendarId);

                            $('#scheduleWriteForm input[name=title]').val(data.id);
                            $('#insert-startDate').val(startDate);
                            $('#insert-startTime option[value="' + startTime + '"]').prop('selected', true);
                            $('#scheduleWriteForm input[name=startDate]').val(startDate + startTime);

                            $('#insert-endDate').val(endDate);
                            $('#insert-endTime option[value="' + endTime + '"]').prop('selected', true);
                            $('#scheduleWriteForm input[name=endDate]').val(endDate + endTime);

                            $('#scheduleWriteForm textarea[name=content]').val(data.content);

                            $('#schedule-update-complete-btn').show();
                            $('#schedule-delete-btn').show();
                            $('#schedule-input-btn').hide();

                            $('#eventDetailModal').fadeOut(300);
                            $('#scheduleWriteModal').fadeIn(300);
                        })
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

        $('#schedule-update-complete-btn').on('click', function() {
            const formData = new FormData($('#scheduleWriteForm')[0]);

            $.ajax({
                url: '/schedule/update',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function (data) {
                    alert("수정되었습니다.");
                    location.reload();
                },
                errors: function(xhr, status, error) {
                    console.log(xhr.status);
                    console.log(xhr.responseText);
                    console.log(error);
                }
            });
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
            let selectedEmployees = new Map();

            // 사원 선택/해제
            $('.calendar-employee-item').click(function() {
                const $this = $(this);
                const empId = $this.data('id');
                const empName = $this.find('.employee-name').text();
                const empDept = $this.find('.employee-dept').text();

                insertSelectEmployees($this, empId, empName, empDept);
            });

            // 선택된 사원 태그 렌더링
            function renderSelectedEmployees() {
                const $selected = $('.selected-employees');
                $selected.empty();

                selectedEmployees.forEach((emp, id) => {
                    $selected.append(
                        $('<div class="selected-employee-tag">').attr('data-id', id)
                            .append($('<span>').text(emp.name))
                            .append($('<span class="material-icons remove-employee">').text('close'))
                            .append($('<input>').attr('type', 'hidden').attr('name', 'employeeId').val(emp.id))
                    );
                });

                // hidden input 업데이트
                $('#selectedEmployees').val(Array.from(selectedEmployees.keys()));
            }

            // 선택된 사원 제거
            $(document).on('click', '.remove-employee', function(e) {
                e.stopPropagation();
                const empId = $(this).closest('.selected-employee-tag').data('id');
                selectedEmployees.delete(empId);
                $('.calendar-employee-item[data-id="' +  empId + '"]').removeClass('selected');
                renderSelectedEmployees();
            });

            // 모달 열기
            $('.open-write-calender').click(function () {
                $('.calendar-write-form').show();
            });

            // 모달 닫기
            $('.calendar-write-form .modal-close').click(function () {
                $('.calendar-write-form').hide();

                $('.calendar-write-form input[type="text"]').val('');
                $('.calendar-write-form input[type="radio"]').prop('checked', false);


                $('#calendar-update-complete-btn').hide();
                $('#calendar-delete-btn').hide();
                $('#calendar-insert-btn').show();

                selectedEmployees = new Map();
                $('.selected-employees').empty();

                $('.calendar-write-form .box-title>h2').html('캘린더 추가');
            });

            $('#schedule-write-close-btn').on('click', function() {
                $('#schedule input').val();
                $('#schedule textarea').val('');

                $('#schedule-update-complete-btn').hide();
                $('#schedule-delete-btn').hide();
                $('#schedule-input-btn').show();

                $('#scheduleWriteModal').fadeOut(300);
                $('#eventDetailModal').fadeIn(300);
            })

            // 모달 열기
            $('.open-list-calendar').click(function() {
                console.log('open list calendar');
                $('#listCalendarModal').show();
            });

            // 모달 닫기
            $('#listCalendarModal .close-modal').click(function() {
                $('#listCalendarModal').hide();
            });

            // 캘린더 선택 시 정보 표시
            $('#calendar-select').change(function() {
                const selectedId = $(this).val();

                if (!selectedId) {
                    $('#calendar-info').hide();
                    return;
                }

                $.ajax({
                    url: '/calendar/detail/' + selectedId,
                    method: 'GET',
                    error : function(request, status, error) {
                        console.log("code: " + request.status)
                        console.log("message: " + request.responseText)
                        console.log("error: " + error);
                    },
                    success: function(resp) {
                        console.log(resp);
                        const calendar = resp.calendar;
                        const members = resp.members;

                        console.log(calendar);
                        console.log(members);

                        $('#cal-name').val(calendar.title);
                        $('#cal-color').css('background-color', calendar.color);

                        // 공유 멤버 표시
                        const $members = $('#cal-members');
                        $members.empty();
                        members.forEach(member => {
                            $members.append($('<div class="selected-employee-tag">')
                                .append($('<span>').text(member.name + " " + member.departmentName)));
                        });

                        $('#calendar-info').show();

                        $('#editCalendarBtn').click(function() {
                            openUpdateCalendarModal(resp);
                        })
                    }
                });
            });

            function openUpdateCalendarModal(resp) {
                $('#listCalendarModal').hide();

                const calendar = resp.calendar;
                const members = resp.members;

                for (let i = 0; i < members.length; i++) {
                    const member = members[i];
                    insertSelectEmployees(
                        $('#calendarWriteForm .calendar-employee-item[data-item' + member.id +']'),
                        Number(member.id), member.name + " " + member.jobName, member.departmentName);
                }

                $('#calendarWriteForm input[name=id]').val(calendar.id);
                $('#calendarWriteForm input[name=title]').val(calendar.title);
                $('#calendarWriteForm input[value="' + calendar.color + '"]').attr('checked', true);

                $('.calendar-write-form').show();
                $('#calendar-update-complete-btn').show();
                $('#calendar-delete-btn').show();
                $('#calendar-insert-btn').hide();

                $('.calendar-write-form .box-title>h2').html('캘린더 변경');
            }

            $('#calendar-update-complete-btn').on('click', function() {
                const formData = new FormData($('#calendarWriteForm')[0]);

                for (const [key, value] of formData.entries()) {
                    console.log(key, value);
                }

                $.ajax({
                    url: '/calendar/update',
                    type: 'POST',
                    data: formData,
                    contentType: false,
                    processData: false,
                    error : function(request, status, error) {
                        console.log("code: " + request.status)
                        console.log("message: " + request.responseText)
                        console.log("error: " + error);
                    }
                }).done(function() {
                    alert("수정되었습니다.")
                    location.reload();
                })
            })

            $('#calendar-delete-btn').on('click', function() {
                if(confirm("정말 삭제하시겠습니까?")) {
                    location.href = '/calendar/delete/' + $('#calendarWriteForm input[name=id]').val();
                }
            })

            function insertSelectEmployees(target, empId, empName, empDept) {

                if(selectedEmployees.has(empId)) {
                    selectedEmployees.delete(empId);
                    target.removeClass('selected');
                } else {
                    selectedEmployees.set(empId, {
                        id: empId,
                        name: empName,
                        department: empDept
                    });
                    target.addClass('selected');
                }

                console.log(target);
                console.log(selectedEmployees);

                renderSelectedEmployees();
            }


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

                console.log( $('input[name="endDate"]').val())
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