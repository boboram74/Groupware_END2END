package com.end2end.spring.commute.service;

import com.end2end.spring.commute.dto.CommuteDTO;

public interface CommuteService {
    boolean isWorkOn(String employeeId);
    CommuteDTO workOn(String employeeId);
    CommuteDTO workOff(String employeeId);
    CommuteDTO selectByEmployeeIdAndState(CommuteDTO dto);
    void checkLeaveEarly();
    void checkNotCheck();
    void checkLate();
    void checkAbsence();
    void insertAll();
}
