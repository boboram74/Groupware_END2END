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
public class ScheduleDTO {
    private int id;
    private int calendarId;
    private int bookId;
    private String title;
    private String content;
    private String color;
    private Timestamp startDate;
    private Timestamp endDate;
    private Timestamp regDate;
}
