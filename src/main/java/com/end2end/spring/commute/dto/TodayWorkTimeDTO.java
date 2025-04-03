package com.end2end.spring.commute.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TodayWorkTimeDTO {
    private String employeeId;
    private Timestamp workOnTime;
    private Timestamp workOffTime;

    public long todayWorkTime(){
        return workOffTime.getTime() - workOnTime.getTime();
    }
}
