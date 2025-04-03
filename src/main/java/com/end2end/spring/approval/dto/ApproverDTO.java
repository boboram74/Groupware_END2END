package com.end2end.spring.approval.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ApproverDTO {
    private int id;
    private String approvalId;
    private String employeeId;
    private String submitYn;
    private Timestamp submitDate;
    private int orders;
    private Timestamp regDate;
}
