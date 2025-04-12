package com.end2end.spring.commute.service;

import com.end2end.spring.commute.dto.CommuteDTO;
import com.end2end.spring.commute.dto.ExtendedCommuteDTO;
import com.end2end.spring.commute.dto.SelectPeriodDTO;
import com.end2end.spring.util.EventDTO;

import java.io.IOException;
import java.util.List;

public interface CommuteService {
    boolean isExistByState(String employeeId, String state);
    boolean workOn(String employeeId) throws IOException;
    boolean workOff(String employeeId) throws IOException;
    CommuteDTO selectByStateAndEmployeeId(CommuteDTO dto);
    int countWorkOnThisWeekByEmployeeId(String employeeId);
    int rateWorkOnThisWeekByEmployeeId(String employeeId);
    long sumTotalWorkTimeThisWeekByEmployeeId(String employeeId);
    List<EventDTO> selectPeriodWorkState(SelectPeriodDTO dto) throws IOException;
    void update(ExtendedCommuteDTO dto);
}
