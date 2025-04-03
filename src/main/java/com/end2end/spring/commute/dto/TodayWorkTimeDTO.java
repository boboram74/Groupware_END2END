package com.end2end.spring.commute.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.time.Duration;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TodayWorkTimeDTO {
    private String employeeId;
    private Timestamp workOnTime;
    private Timestamp workOffTime;

    public Duration todayWorkTime(){
        long dateTime = workOffTime.getTime() - workOnTime.getTime();
        return Duration.between(workOnTime.toInstant(), workOffTime.toInstant());
    }
}
