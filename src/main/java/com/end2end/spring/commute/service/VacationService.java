package com.end2end.spring.commute.service;

import com.end2end.spring.commute.dto.VacationDTO;
import com.end2end.spring.commute.dto.VacationManagementDTO;

import java.io.IOException;
import java.util.List;

public interface VacationService {
    List<VacationDTO> selectByEmployeeId(String employeeId);
    void insert(VacationDTO dto);
    void insertUsableVacationHired1st() throws IOException;
    void insertUsableVacation() throws IOException;
    double sumTotalVacationDates(String employeeId);
    double sumTotalUsedVacationDates(String employeeId);
    double sumThisMonthUsedVacationDates(String employeeId);
}
