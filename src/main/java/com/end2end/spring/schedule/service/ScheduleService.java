package com.end2end.spring.schedule.service;

import com.end2end.spring.schedule.dto.ScheduleDTO;
import com.end2end.spring.util.EventDTO;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

public interface ScheduleService {
    List<EventDTO> selectByEmployeeId(String employeeId, LocalDate startDate, LocalDate endDate) throws IOException;
    List<EventDTO> selectByCalenderId(int calenderId);
    List<ScheduleDTO> search();
    int countTodayScheduleByEmployeeId(String employeeId);
    ScheduleDTO selectById(int id);
    void insert(ScheduleDTO dto);
    void update(ScheduleDTO dto);
    void deleteById(int id);
}
