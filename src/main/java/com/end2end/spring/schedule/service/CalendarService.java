package com.end2end.spring.schedule.service;

import com.end2end.spring.schedule.dto.CalendarDTO;

import java.util.List;

public interface CalendarService {
    List<CalendarDTO> selectByEmployeeId(String employeeId);
    List<CalendarDTO> search();
    CalendarDTO selectById(int id);
    void insert(CalendarDTO dto);
    void update(CalendarDTO dto);
    void deleteById(int id);
}
