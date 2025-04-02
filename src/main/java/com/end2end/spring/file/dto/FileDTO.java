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
    private int projectWorkId;
    private int emailId;
    private int noticeId;
}