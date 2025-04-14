package com.end2end.spring.main.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class LoginHistoryDTO {
    private int id;
    private String employeeId;
    private String accessIp;
    private String state;
    private Timestamp regDate;
}
