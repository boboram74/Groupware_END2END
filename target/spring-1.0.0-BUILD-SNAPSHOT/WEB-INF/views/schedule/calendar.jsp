<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/template/exam.css"/>
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

    .employee-item {
        padding: 12px;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 12px;
        transition: background-color 0.2s;
    }

    .employee-item:hover {
        background-color: var(--md-sys-color-surface-container);
    }

    .employee-item.selected {
        background-color: var(--md-sys-color-surface-container);
    }

    .employee-item .material-icons {
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
        color: var(--md-sys-color-on-surface);
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
            <button class="primary insert-schedule open-write-schedule">일정 추가</button>
            <button class="primary open-write-calender">캘린더 추가</button>
            <button class="secondary open-list-calendar">캘린더 관리</button>
        </div>
        <div class="calender-container">
            <div id="calendar"></div>
        </div>
    </div>
    <!-- 캘린더 추가 모달 -->
    <div class="detail-modal calendar-write-form" style="display: none;">
        <div class="modal-container box surface-bright">
            <div class="modal-header box-title">
                <h2>캘린더 추가</h2>
            </div>
            <div class="modal-body box-content">
                <form id="calendarWriteForm" action="/schedule/calendar/insert" method="post">
                    <div class="form-group">
                        <label for="calendarName">캘린더 이름</label>
                        <input type="text" id="calendarName" name="title" required>
                    </div>
                    <div class="form-group">
                        <label>캘린더 색상</label>
                        <div class="color-options">
                            <label class="color-radio">
                                <input type="radio" name="color" value="#4285f4" checked>
                                <span class="color-circle" style="background-color: #4285f4"></span>
                            </label>
                            <label class="color-radio">
                                <input type="radio" name="color" value="#ea4335">
                                <span class="color-circle" style="background-color: #ea4335"></span>
                            </label>
                            <label class="color-radio">
                                <input type="radio" name="color" value="#fbbc04">
                                <span class="color-circle" style="background-color: #fbbc04"></span>
                            </label>
                            <label class="color-radio">
                                <input type="radio" name="color" value="#34a853">
                                <span class="color-circle" style="background-color: #34a853"></span>
                            </label>
                            <label class="color-radio">
                                <input type="radio" name="color" value="#ff7597">
                                <span class="color-circle" style="background-color: #ff7597"></span>
                            </label>
                            <label class="color-radio">
                                <input type="radio" name="color" value="#9b27af">
                                <span class="color-circle" style="background-color: #9b27af"></span>
                            </label>
                            <label class="color-radio">
                                <input type="radio" name="color" value="#795548">
                                <span class="color-circle" style="background-color: #795548"></span>
                            </label>
                            <label class="color-radio">
                                <input type="radio" name="color" value="#607d8b">
                                <span class="color-circle" style="background-color: #607d8b"></span>
                            </label>
                            <label class="color-radio">
                                <input type="radio" name="color" value="#00bcd4">
                                <span class="color-circle" style="background-color: #00bcd4"></span>
                            </label>
                            <label class="color-radio">
                                <input type="radio" name="color" value="#ff5722">
                                <span class="color-circle" style="background-color: #ff5722"></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>공유 사원</label>
                        <div class="employee-selector">
                            <div class="selected-employees">
                                <!-- 선택된 사원들이 여기에 태그처럼 표시됩니다 -->
                            </div>
                            <div class="employee-list">
                                <c:forEach items="${employeeList}" var="item">
                                    <c:if test="${item.id != employee.id}">
                                        <div class="employee-item" data-id="${item.id}">
                                            <div class="profile-img" style="background-image: url('${item.profileImg}');">
                                            </div>
                                            <div class="employee-info">
                                                <span class="employee-name">${item.name} ${item.jobName}</span>
                                                <span class="employee-dept">${item.departmentName}</span>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                        <input type="hidden" name="selectedEmployees" id="selectedEmployees">
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="primary" style="display: block;" id="calendar-insert-btn">저장</button>
                        <button type="button" class="primary" style="display: none;" id="calendar-update-complete-btn">수정 완료</button>
                        <button type="button" class="secondary" style="display: none;" id="calendar-delete-btn">삭제</button>
                        <button type="button" class="secondary modal-close">취소</button>
                    </div>
                </form>
            </div>
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
                        <button type="submit" class="btn primary">저장</button>
                        <button type="button" class="btn secondary close-modal">취소</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- 캘린더 목록 모달 -->
    <div class="detail-modal" id="listCalendarModal" style="display: none;">
        <div class="box modal-container surface-bright">
            <div class="box-title modal-header">
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
    <script>
        $(document).ready(function() {
            // 모달 열기
            $('.open-write-calender').click(function () {
                $('.calendar-write-form').show();
            });

            // 모달 닫기
            $('.calendar-write-form .modal-close').click(function () {
                $('.calendar-write-form').hide();
            });
        })
    </script>
    <script>
        $(document).ready(function() {
            let selectedEmployees = new Map();

            // 사원 선택/해제
            $('.employee-item').click(function() {
                const $this = $(this);
                const empId = $this.data('id');
                const empName = $this.find('.employee-name').text();
                const empDept = $this.find('.employee-dept').text();

                if(selectedEmployees.has(empId)) {
                    selectedEmployees.delete(empId);
                    $this.removeClass('selected');
                } else {
                    selectedEmployees.set(empId, {
                        id: empId,
                        name: empName,
                        department: empDept
                    });
                    $this.addClass('selected');
                }

                renderSelectedEmployees();
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
                $('.employee-item[data-id="' +  empId + '"]').removeClass('selected');
                renderSelectedEmployees();
            });

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
        });

        $(document).ready(function() {
            // 모달 열기
            $('.open-list-calendar').click(function() {
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

                $('#calendarWriteForm input[name=title]').val(calendar.title);
                $('#calendarWriteForm input[value="' + calendar.color + '"]').attr('checked', true);

                $('.calendar-write-form').show();
                $('#calendar-update-complete-btn').show();
                $('#calendar-delete-btn').show();
                $('#calender-insert-btn').style('display', 'none');
            }
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