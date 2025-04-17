package com.end2end.spring.approval.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CheckImportantDTO {
    private String approvalId;
    private String employeeId;
    private String leaderCheckYn;
}
