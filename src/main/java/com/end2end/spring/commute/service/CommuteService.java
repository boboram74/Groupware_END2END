package com.end2end.spring.commute.service;

import com.end2end.spring.commute.dto.CommuteDTO;
import com.end2end.spring.commute.dto.SelectPeriodDTO;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

public interface CommuteService {
    boolean isExistByState(String employeeId, String state);
    boolean workOn(String employeeId);
    boolean workOff(String employeeId);
    CommuteDTO selectByStateAndEmployeeId(CommuteDTO dto);
    int countWorkOnThisWeekByEmployeeId(String employeeId);
    int rateWorkOnThisWeekByEmployeeId(String employeeId);
    long sumTotalWorkTimeThisWeekByEmployeeId(String employeeId);
    List<Map<LocalDate, Object>> selectPeriodWorkState(SelectPeriodDTO dto);
}
