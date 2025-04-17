package com.end2end.spring.schedule.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BookDTO {
    private int id;
    private String employeeId;

    private int targetId;
    private String targetType;
    private String targetName;

    private Timestamp startDate;
    private Timestamp endDate;
    private Timestamp regDate;
}
