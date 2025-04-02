package com.end2end.spring.file.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import oracle.sql.TIMESTAMP;

import java.util.Objects;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FileDTO {
    private int id;
    private int messageId;
    private int boardId;
    private String approvalId;
    private int reportId;
    private int mailId;
    private int noticeId;
    private String path;

    public String getPath() {
        if (messageId != 0) {
            return "message";
        } else if (boardId != 0) {
            return "board";
        } else if (reportId != 0) {
            return "report";
        } else if (mailId != 0) {
            return "mail";
        } else if (noticeId != 0) {
            return "notice";
        } else if (approvalId != null) {
            return "approval";
        }

        throw new IllegalArgumentException("잘못된 곳에서 입력되었습니다.");
    }
}