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
public class ExtendedCommuteDTO {
    private int id;
    private String employeeId;
    private Timestamp workOffTime;
    private Timestamp regDate;
}
