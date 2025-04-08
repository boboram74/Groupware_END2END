package com.end2end.spring.commute.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CommuteStateDTO {
    private String employeeId;
    private LocalDate dates;
    private Timestamp regDate;
    private String state;
}
