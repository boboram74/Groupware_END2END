package com.end2end.spring.schedule.service;

import com.end2end.spring.schedule.dto.CalenderDTO;

import java.util.List;

public interface CalenderService {
    List<CalenderDTO> selectByEmployeeId(String employeeId);
    List<CalenderDTO> search();
    CalenderDTO selectById(int id);
    void insert(CalenderDTO dto);
    void update(CalenderDTO dto);
    void deleteById(int id);
}
