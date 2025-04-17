package com.end2end.spring.schedule.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BookInsertDTO {
    private int id;
    private String employeeId;
    private int targetId;
    private String targetType;
    private String startDate;
    private String endDate;
}
