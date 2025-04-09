package com.end2end.spring.commute.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class VacationDTO {
    private int id;
    private String employeeId;
    private String approvalId;
    private Timestamp startDate;
    private Timestamp endDate;
    private double vacationDate;
    private String reason;
    private String type;
    private Timestamp regDate;
}
