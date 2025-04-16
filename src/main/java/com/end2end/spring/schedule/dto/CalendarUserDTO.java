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
public class CalendarUserDTO {
    private int id;
    private int calendarId;
    private String employeeId;
    private Timestamp regDate;
}
