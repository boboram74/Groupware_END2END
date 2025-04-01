package com.end2end.spring.file.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import oracle.sql.TIMESTAMP;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FileDTO {
    private int id;
    private String originFileName;
    private String systemFileName;
    private String path;
    private long fileSize;
    private TIMESTAMP regDate;
    private int messageId;
    private int boardId;
    private String approvalId;
    private int reportId;
    private int mailId;
    private int noticeId;
}