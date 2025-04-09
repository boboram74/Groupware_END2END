package com.end2end.spring.approval.dto;

import java.sql.Timestamp;

public class ApprovalRejectDTO {
    private int id;
    private String approvalId;
    private int approverId;
    private String reason;
    private Timestamp regdate;
}
