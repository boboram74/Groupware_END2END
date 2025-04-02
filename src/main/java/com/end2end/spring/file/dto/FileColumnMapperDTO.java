package com.end2end.spring.file.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Objects;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FileColumnMapperDTO {
    private String column;
    private Object id;
    private String path;
    private int filesId;

    public static FileColumnMapperDTO of(FileDTO dto) {
        if (dto.getMessageId() != 0) {
            return new FileColumnMapperDTO("messageId", dto.getMessageId(), "message", 0);
        } else if (dto.getBoardId() != 0) {
            return new FileColumnMapperDTO("boardId", dto.getBoardId(), "board", 0);
        } else if (dto.getReportId() != 0) {
            return new FileColumnMapperDTO("reportId", dto.getReportId(), "report", 0);
        } else if (dto.getMailId() != 0) {
            return new FileColumnMapperDTO("mailId", dto.getMailId(), "mail", 0);
        } else if (dto.getNoticeId() != 0) {
            return new FileColumnMapperDTO("noticeId", dto.getNoticeId(), "notice", 0);
        } else if (Objects.nonNull(dto.getApprovalId())) {
            return new FileColumnMapperDTO("approvalId", dto.getApprovalId(), "approval", 0);
        }

        throw new IllegalArgumentException("잘못된 곳에서 입력되었습니다.");
    }
}
