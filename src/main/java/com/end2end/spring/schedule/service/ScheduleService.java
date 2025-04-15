package com.end2end.spring.schedule.service;

import com.end2end.spring.schedule.dto.ScheduleDTO;

import java.util.List;

public interface ScheduleService {
    List<ScheduleDTO> selectByEmployeeId(String employeeId);
    List<ScheduleDTO> selectByEmployeeIdAndCalenderId(String employeeId, int calenderId);
    List<ScheduleDTO> search();
    ScheduleDTO selectById(int id);
    void insert(ScheduleDTO dto);
    void update(ScheduleDTO dto);
    void deleteById(int id);
}
