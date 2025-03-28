package com.end2end.spring.file.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import oracle.sql.TIMESTAMP;

@Data
@AllArgsConstructor
public class FileDTO {
    private int id;
    private String originFileName;
    private String systemFileName;
    private String path;
    private String fileSize;
    private TIMESTAMP regDate;
    private int messageId;
    private int boardId;
    private String approvalId;
    private int reportId;
    private int mailId;
    private int noticeId;
}
