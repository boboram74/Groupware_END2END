package com.end2end.spring.schedule.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ScheduleInsertDTO {
    private int calendarId;
    private String title;
    private String content;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
}
