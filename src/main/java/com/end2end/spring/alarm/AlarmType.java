package com.end2end.spring.alarm;

import lombok.Getter;

@Getter
public enum AlarmType {
    LOGIN("login", "새로운 환경에서 로그인했습니다.", "info"),
    SUBMIT_APPROVAL("description", "내 전자 결재가 승인되었습니다.", "success"),
    REJECT_APPROVAL("description", "내 전자 결재가 반려되었습니다.", "danger"),
    CHECK_APPROVAL("check", "승인이 필요한 전자 결재가 있습니다.", "info"),
    GET_REPLY("reply", "댓글이 달렸습니다.", "info"),
    GET_EMAIL("mail", "새로운 메일이 도착했습니다.", "success"),
    NOTICE_SCHEDULE("schedule", "5분 뒤 일정이 있습니다.", "warning"),
    NOTICE_INSERT("notification", "새로운 공지사항이 있습니다.", "info")
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
