package com.end2end.spring.approval.dto;

import lombok.*;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ApprovalFormDTO {
    private int id;
    private int approvalCtId;
    private String name;
    private String form;
    private Timestamp regDate;
    private String prefixes;
}
