package com.end2end.spring.schedule.service;

import com.end2end.spring.schedule.dto.CalendarDTO;
import com.end2end.spring.schedule.dto.CalendarInsertDTO;

import java.util.List;
import java.util.Map;

public interface CalendarService {
    List<CalendarDTO> selectByEmployeeId(String employeeId);
    List<CalendarDTO> search();
    Map<String, Object> selectById(int id);
    void insert(CalendarInsertDTO dto);
    void update(CalendarDTO dto);
    void deleteById(int id);
}
