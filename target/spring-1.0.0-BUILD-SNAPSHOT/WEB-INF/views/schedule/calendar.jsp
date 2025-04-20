<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/template/exam.css"/>
<link rel="stylesheet" href="/css/schedule/calendar.css"/>

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
            <li class="detail-menu-item active" onclick="location.href='/calendar/list'">
                <span class="material-icons">calendar_month</span>
                <span>일정</span>
            </li>
            <li class="detail-menu-item" onclick="location.href='/book/list'">
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
                <form id="calendarWriteForm" action="/calendar/insert" method="post">
                    <input type="hidden" name="id" value="0">
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
                            <div class="selected-employees"></div>
                            <div class="employee-list">
                                <c:forEach items="${employeeList}" var="item">
                                    <c:if test="${item.id != employee.id}">
                                        <div class="calendar-employee-item" data-id="${item.id}">
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
                        <button type="submit" class="primary" id="calendar-insert-btn">저장</button>
                        <button type="button" class="primary" style="display: none;" id="calendar-update-complete-btn">수정 완료</button>
                        <button type="button" class="secondary" style="display: none;" id="calendar-delete-btn">삭제</button>
                        <button type="button" class="secondary modal-close" id="calendar-write-close">취소</button>
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
                            <input type="date" min="<fmt:formatDate value='<%= new java.util.Date() %>' pattern='yyyy-MM-dd'/>" id="insert-startDate" class="form-input" required>
                            <select required id="insert-startTime">
                                <c:forEach begin="9" end="18" var="i">
                                    <option value=" ${i < 10 ? '0'.concat(i) : i}:00:00">${i < 10 ? '0'.concat(i) : i}:00</option>
                                    <option value=" ${i < 10 ? '0'.concat(i) : i}:30:00">${i < 10 ? '0'.concat(i) : i}:30</option>
                                </c:forEach>
                            </select>
                        </div>
                        <input type="hidden" name="startDate" class="form-input" required>
                    </div>

                    <div class="form-group">
                        <label>종료 일시</label>
                        <div class="datetime-wrapper">
                            <input type="date" min="<fmt:formatDate value='<%= new java.util.Date() %>' pattern='yyyy-MM-dd'/>" id="insert-endDate" class="form-input" required>
                            <select required id="insert-endTime">
                                <c:forEach begin="9" end="18" var="i">
                                    <option value=" ${i < 10 ? "0" + i : i}:00:00">${i < 10 ? "0" + i : i}:00</option>
                                    <option value=" ${i < 10 ? "0" + i : i}:30:00">${i < 10 ? "0" + i : i}:30</option>
                                </c:forEach>
                            </select>
                        </div>
                        <input type="hidden" name="endDate" class="form-input" required>
                    </div>

                    <div class="form-group">
                        <label>일정 내용</label>
                        <textarea name="content" rows="4" class="form-input" required></textarea>
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
                height: 'auto',
                events: function(info, successCallback) {
                    const startDate = info.start;
                    const endDate = info.end;

                    loadEvents(startDate, endDate, successCallback);
                },
                eventClick: function(info) {
                    if (info.event.extendedProps.type === 'schedule') {
                        openDetailModal(info.event.extendedProps.id);
                    }
                },
                eventDisplay: 'block',
                // 헤더 스타일 설정
                viewDidMount: function () {
                    adjustCalendarSize();
                },
                eventTimeFormat: {
                    hour: '2-digit',
                    minute: '2-digit',
                    hour12: false
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

            function parseDate(dates) {
                const parsedMonth = (dates.getMonth() + 1) < 10 ? '0' + (dates.getMonth() + 1) : (dates.getMonth() + 1);
                return dates.getFullYear() + '-' + parsedMonth + '-' + dates.getDate();
            }

            function loadEvents(startDate, endDate, successCallback) {
                startDate = parseDate(startDate);
                endDate = parseDate(endDate);
                $.ajax({
                    url: '/schedule/list?startDate=' + startDate + '&endDate=' + endDate,
                    type: 'GET',
                    success: function (data) {
                        const events = data.map(function(event) {
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
                        successCallback(events);
                    }, errors: function(xhr, status, error) {
                    }
                })
            }

            function openDetailModal(id) {
                $.ajax({
                    url: '/schedule/detail/' + id,
                    type: 'GET',
                    success: function (data) {
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

                if($('#schedule-update-complete-btn').is(':visible')) {
                    $('#eventDetailModal').fadeIn(300);
                }

                $('#schedule-update-complete-btn').hide();
                $('#schedule-delete-btn').hide();
                $('#schedule-input-btn').show();

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

                    },
                    success: function(resp) {
                        const calendar = resp.calendar;
                        const members = resp.members;
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