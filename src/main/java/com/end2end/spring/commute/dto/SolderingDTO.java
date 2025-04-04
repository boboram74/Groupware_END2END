package com.end2end.spring.commute.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@Builder
public class SolderingDTO {
    private int id;
    private String employeeId;
    private String state;
    private LocalDateTime regDate;
}
