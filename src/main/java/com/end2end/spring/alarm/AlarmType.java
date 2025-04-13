package com.end2end.spring.alarm;

import lombok.Getter;

@Getter
public enum AlarmType {
    LOGIN("login", "새로운 환경에서 로그인했습니다."),
    SUBMIT_APPROVAL("submit", "내 전자 결재가 승인되었습니다."),
    REJECT_APPROVAL("reject", "내 전자 결재가 반려되었습니다."),
    CHECK_APPROVAL("check", "승인이 필요한 전자 결재가 있습니다."),
    GET_REPLY("reply", "댓글이 달렸습니다."),
    GET_EMAIL("mail", "새로운 메일이 도착했습니다."), GET_MESSAGE("chat", ""),
    NOTICE_SCHEDULE("schedule", "5분 뒤 일정이 있습니다.")
    ;

    private final String icons;
    private final String description;

    AlarmType(String icons, String description) {
        this.icons = icons;
        this.description = description;
    }
}
