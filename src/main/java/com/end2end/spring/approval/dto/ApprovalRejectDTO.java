package com.end2end.spring.approval.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ApprovalRejectDTO {
    private int id;
    private String approvalId;
    private int approverId;
    private String reason;
    private Timestamp regdate;
}
