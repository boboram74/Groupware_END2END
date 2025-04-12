package com.end2end.spring.approval.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ApprovalInsertDTO {
    private String id;
    private String employeeId;
    private int approvalFormId;
    private int departmentId;
    private String title;
    private String content;
    List<String> approverId;

    // 연장근무 신청용
    private int commuteId;
    private String workOffTime;

    // 휴가 신청용
    private String startDate;
    private Double vacationDate;
    private String vacationType;
}
