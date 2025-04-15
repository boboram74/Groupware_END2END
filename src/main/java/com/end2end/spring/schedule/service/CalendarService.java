package com.end2end.spring.schedule.service;

import com.end2end.spring.schedule.dto.CalendarDTO;
import com.end2end.spring.schedule.dto.CalendarInsertDTO;

import java.util.List;

public interface CalendarService {
    List<CalendarDTO> selectByEmployeeId(String employeeId);
    List<CalendarDTO> search();
    CalendarDTO selectById(int id);
    void insert(CalendarInsertDTO dto);
    void update(CalendarDTO dto);
    void deleteById(int id);
}
