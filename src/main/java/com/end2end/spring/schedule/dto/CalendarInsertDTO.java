package com.end2end.spring.schedule.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CalendarInsertDTO {
    private int id;
    private String title;
    private String color;
    private List<String> employeeId;
}
