package com.end2end.spring.alarm;

import lombok.Getter;

@Getter
public enum AlarmType {
    LOGIN("login", "새로운 환경에서 로그인했습니다.", "primary"),
    VACATION_APPROVE("event_available", "휴가 신청이 승인되었습니다.", "success"),
    SUBMIT_APPROVAL("description", "내 전자 결재가 승인되었습니다.", "success"),
    REJECT_APPROVAL("description", "내 전자 결재가 반려되었습니다.", "danger"),
    CHECK_APPROVAL("check_circle", "승인이 필요한 전자 결재가 있습니다.", "warning"),
    GET_REPLY("add_comment", "댓글이 달렸습니다.", "info"),
    GET_EMAIL("mail", "새로운 메일이 도착했습니다.", "primary"),
    NOTICE_SCHEDULE("schedule", "5분 뒤 일정이 있습니다.", "warning"),
    NOTICE_INSERT("notification", "새로운 공지사항이 있습니다.", "info"),
    PROJECT_CREATE("add_circle", "새로운 프로젝트가 생성되었습니다.", "primary"),
    PROJECT_UPDATE("update", "프로젝트에 변경 사항이 생겼습니다.", "primary"),
    PROJECT_DEADLINE("schedule", "프로젝트의 마감 기한이 곧입니다.", "danger"),
    PROJECT_WORK_CREATE("note_add", "프로젝트 작업이 추가되었습니다.", "primary"),
    PROJECT_WORK_UPDATE("edit_document", "프로젝트 작업에 변경점이 생겼습니다.", "warning"),
    PROJECT_WORK_ONGOING("flag_2", "진행중으로 변경된 프로젝트 작업이 있습니다.", "primary"),
    PROJECT_WORK_FINISH("flag_2", "종료된 프로젝트 작업이 있습니다.", "success"),
    PROJECT_WORK_DEADLINE("schedule", "마감일이 얼마 남지 않은 프로젝트 작업이 있습니다.", "danger"),
    CALENDAR_CREATE("calendar_month", "새로운 달력이 생성되었습니다.", "primary"),
    CALENDAR_UPDATE("edit_calendar", "달력이 변경되었습니다.", "info"),
    CALENDAR_DELETE("event_busy", "달력이 삭제되었습니다.", "danger"),
    SCHEDULE_CREATE("event", "새로운 일정이 생성되었습니다.", "success"),
    SCHEDULE_UPDATE("update", "일정이 업데이트 되었습니다.", "warning"),
    SCHEDULE_DELETE("event_busy", "일정이 삭제되었습니다.", "danger"),
    PROJECT_COMPLETE("task", "프로젝트의 모든 작업이 종료되었습니다.", "success")
    ;

    private final String icons;
    private final String description;
    private final String type;

    AlarmType(String icons, String description, String type) {
        this.icons = icons;
        this.description = description;
        this.type = type;
    }
}
