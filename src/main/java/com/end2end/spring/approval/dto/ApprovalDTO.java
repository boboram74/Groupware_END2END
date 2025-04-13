package com.end2end.spring.approval.dto;

import lombok.*;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ApprovalDTO {
    private String id;
    private String employeeId;
    private int approvalFormId;
    private int departmentId;
    private String title;
    private String content;
    private String state;
    private Timestamp regDate;
    private String prefixes;
}
