package com.end2end.spring.commute.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
public class CommuteDTO {
    private int id;
    private String employeeId;
    private String state;
    private Timestamp regDate;
}
