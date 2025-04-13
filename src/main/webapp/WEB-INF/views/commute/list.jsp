<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/commute/commute-header.jsp"/>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@6.1.17/index.global.min.js'></script>

<style>
    .box {
        display: flex;
        flex-direction: column;
        height: 100%; /* 전체 높이 사용 */
        border-radius: 8px;
    }

    .box-title {
        padding: 15px;
        font-size: 20px;
        font-weight: 600;
        border-bottom: 1px solid var(--md-sys-color-outline);
        flex-shrink: 0; /* 크기 고정 */
    }

    .box-content {
        flex: 1; /* 남은 공간 모두 사용 */
        padding: 20px;
        display: flex; /* flex 컨테이너로 설정 */
        flex-direction: column; /* 세로 방향 정렬 */
    }

    .commute-list-wrapper {
        display: grid;
        gap: 20px;
    }

    .department-info-box {
        height: 300px;
    }

    .group-schedule-list-box {
        flex: 1;
    }

    .resource-title {
        display: flex;
        gap: 10px;
        align-content: center;
    }

    .resource-title span {
        text-align: center;
    }
</style>    
<div class="commute-list-wrapper">
    <div class="box department-info-box surface-bright">
        <div class="box-title">
            ${employee.departmentName}
        </div>
        <div class="box-content department-info-content"></div>
    </div>
    <div class="box group-schedule-list-box surface-bright">
        <div class="box-title">
            부서 근무 현황
        </div>
        <div class="box-content" id="calender"></div>
    </div>
</div>
<script>
    $(document).ready(function() {
        const calender = new FullCalendar.Calendar(document.getElementById('calender'), {
            locale: 'ko',
            resources: function (fetchInfo, successCallback, failureCallback) {
                $.ajax({
                    url: '/employee/department/${employee.departmentId}'
                }).done(function(data) {
                    console.log(data);

                    const resources = data.map((employee) => {
                        return {
                            id: String(employee.id),
                            name: employee.name,
                            profileImg: employee.profileImg
                        }
                    })
                    successCallback(resources);
                })
            },
            resourceLabelContent: function(arg) {
                console.log(arg.resource.extendedProps.profileImg);
                return {
                    html: "<div class=resource-title><div class='profile-img' style='background-image: url('"
                        + arg.resource.extendedProps.profileImg + "');'></div><span>" + arg.resource.extendedProps.name + "</span></div>"
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
            eventClick: function (info) {
                window.location.href = "/commute/detail?id=" + info.event.id;
            }
        });

        function parseDate(dates) {
            return dates.getFullYear() + '-' + (dates.getMonth() + 1) + '-' + dates.getDate();
        }

        function loadEvents(startDate, endDate, successCallback) {
            const startDateStr = parseDate(startDate);
            const endDateStr = parseDate(endDate);
            $.ajax({
                url: '/commute/select/period/list?startDate=' + startDateStr + '&endDate=' + endDateStr,
                type: 'GET',
                error : function(request, status, error) {
                    console.log("code: " + request.status)
                    console.log("message: " + request.responseText)
                    console.log("error: " + error);
                }
            }).done(function(data) {
                calender.removeAllEvents();
                console.log(data);

                const events = Object.entries(data).map(([key, value]) => {
                    console.log(key);
                    return value.map((event) => {
                        if (event.eventName === 'period') {
                            return {
                                resourcesId: String(key),
                                title: event.title,
                                start: new Date(event.startDate),
                                end: new Date(event.endDate),
                                allDay: true,
                                display: 'block',
                            }
                        }
                        return {
                            resourcesId: String(key),
                            title: event.title,
                            start: new Date(event.startDate),
                            allDay: event.allDay,
                            display: 'block',
                        }
                    })
                })

                console.log(events);
                successCallback(events);
            })
        }

        calender.render();
    })
</script>
<jsp:include page="/WEB-INF/views/commute/commute-footer.jsp"/>