package com.end2end.spring.schedule.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ScheduleInsertDTO {
    private int id;
    private int calendarId;
    private String title;
    private String content;
    private String startDate;
    private String endDate;
}
