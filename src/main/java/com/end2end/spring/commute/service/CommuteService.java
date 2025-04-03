package com.end2end.spring.commute.service;

import com.end2end.spring.commute.dto.CommuteDTO;

import java.util.List;

public interface CommuteService {
    void workOn(String employeeId);
    void workOff(String employeeId);
    void checkLeaveEarly();
    void checkNotCheck();
    void checkLate();
    void checkAbsence();
    void insertAll();
}
