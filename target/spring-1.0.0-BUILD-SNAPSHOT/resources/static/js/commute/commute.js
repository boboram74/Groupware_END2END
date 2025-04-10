$(document).ready(function() {
    let workOnTime = ${workOnTime != null ? workOnTime.getTime() : "null"};
    let workOffTime = ${workOffTime != null ? workOffTime.getTime() : "null"};
    let totalWorkTimeThisWeek = ${totalWorkTimeThisWeek};

    function formatDuration(ms) {
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
        $(className + ' .hour').html(time.hours + '<small>HH</small>');
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

    function getTotalWorkTimeThisWeek(workTime) {
        if (workOffTime == null) {
            return totalWorkTimeThisWeek + workTime;
        }

        return totalWorkTimeThisWeek;
    }

    workTime = getWorkTime();
    setTimeDisplay('.total', formatDuration(getWorkTime()));
    setTimeDisplay('.weekly-total', formatDuration(getTotalWorkTimeThisWeek(workTime)));
    setInterval(function () {
        workTime = getWorkTime();
        const displayTotalWorkTimeThisWeek = getTotalWorkTimeThisWeek(workTime);
        setTimeDisplay('.total', formatDuration(workTime));
        setTimeDisplay('.weekly-total', formatDuration(displayTotalWorkTimeThisWeek));
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
});

$(function() {
    function calculateAvailableDimensions() {
        const $container = $('#calendar').closest('.box');
        const totalHeight = $container.height();
        const totalWidth = $container.width();
        const titleHeight = $('.box-title').outerHeight(true);
        const padding = 40; // 상하/좌우 padding 20px * 2

        return {
            height: totalHeight - titleHeight - padding,
            width: totalWidth - padding
        };
    }


    const calendar = new FullCalendar.Calendar($('#calendar')[0], {
        initialView: 'dayGridWeek'
        ,  // 일주일 보기로 초기 설정
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth dayGridWeek'// 주간 보기만 표시
        },
        locale: 'ko',
        height: calculateAvailableDimensions().height,
        width: calculateAvailableDimensions().width,
        dayHeaders: true,  // 요일 표시
        dayHeaderFormat: {weekday: 'short', month: 'numeric', day: 'numeric'}, // 날짜 포맷
        weekNumbers: false,  // 주차 숨기기
        // 캘린더가 처음 마운트되고 이벤트를 로드할 때
        events: function(info, successCallback) {
            const startDate = info.start;
            const endDate = info.end;
            loadEvents(startDate, endDate, successCallback);
        },
        viewDidMount: function() {
            adjustCalendarSize();
        },
        eventDisplay: 'block',
        displayEventTime: false,
        eventTimeFormat: {
            hour: '2-digit',
            minute: '2-digit',
            hour12: false
        },
        // 날짜 범위 변경 시 호출
        datesSet: function(info) {
            console.log('보여지는 날짜 범위:', {
                start: info.start,
                end: info.end
            });
        },
        eventClassNames: 'simple-dot-event'
    });

    function parseDate(dates) {
        return dates.getFullYear() + '-' + (dates.getMonth() + 1) + '-' + dates.getDate();
    }

    function loadEvents(startDate, endDate, successCallback) {
        const startDateStr = parseDate(startDate);
        const endDateStr = parseDate(endDate);
        $.ajax({
            url: '/commute/select/period?startDate=' + startDateStr + '&endDate=' + endDateStr,
            type: 'GET'
        }).done(function(data) {
            calendar.removeAllEvents();
            const events = data.map(function(event) {
                console.log(event);
                if (event.eventName === 'period') {
                    return {
                        title: event.title,
                        start: new Date(event.startDate),
                        end: new Date(event.endDate),
                        allDay: true,
                        display: 'block',
                    }
                }
                return {
                    title: event.title,
                    start: new Date(event.startDate),
                    allDay: event.allDay,
                    display: 'block',
                }
            })
            console.log(events);
            successCallback(events);
        })
    }

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

    calendar.render();

    let resizeTimer;
    $(window).resize(function() {
        clearTimeout(resizeTimer);
        resizeTimer = setTimeout(function() {
            const dimensions = calculateAvailableDimensions();
            calendar.setOption('height', dimensions.height);
            adjustCalendarSize();
        }, 100);
    });
});