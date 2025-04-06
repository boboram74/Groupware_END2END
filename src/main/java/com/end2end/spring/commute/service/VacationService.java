package com.end2end.spring.commute.service;

import com.end2end.spring.commute.dto.VacationDTO;
import com.end2end.spring.commute.dto.VacationManagementDTO;

public interface VacationService {
    void insert(VacationDTO dto);
    void insertUsableVacation(VacationManagementDTO dto);
}
