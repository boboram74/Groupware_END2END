package com.end2end.spring.commute.service;

import com.end2end.spring.commute.dto.CommuteDTO;

public interface CommuteService {
    boolean isExistByState(String employeeId, String state);
    boolean workOn(String employeeId);
    boolean workOff(String employeeId);
    CommuteDTO selectByStateAndEmployeeId(CommuteDTO dto);
    int countWorkOnThisWeekByEmployeeId(String employeeId);
}
