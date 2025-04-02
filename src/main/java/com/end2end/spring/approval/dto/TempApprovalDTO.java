package com.end2end.spring.approval.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@Getter
@Setter
public class TempApprovalDTO {
    private int id;
    private String employeeId;
    private int approvalFormId;
    private int departmentId;
    private String title;
    private String content;
    private Timestamp regRate;
}
