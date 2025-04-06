package com.end2end.spring.commute.service;

import com.end2end.spring.commute.dto.SolderingDTO;

public interface SolderingService {
    int countTisWeekByStateAndEmployeeId(SolderingDTO dto);
}
