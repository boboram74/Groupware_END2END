package com.end2end.spring.commute.service;

import com.end2end.spring.commute.dto.CommuteDTO;

import java.util.List;

public interface CommuteService {
    List<CommuteDTO> checkLate(String state);
    void insert(CommuteDTO dto);
    void checkLeaveEarly();
    void insertAll();
}
