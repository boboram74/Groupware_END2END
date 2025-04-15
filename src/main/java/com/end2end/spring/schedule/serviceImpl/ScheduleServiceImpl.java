package com.end2end.spring.schedule.serviceImpl;

import com.end2end.spring.schedule.dto.ScheduleDTO;
import com.end2end.spring.schedule.service.ScheduleService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ScheduleServiceImpl implements ScheduleService {
    @Override
    public List<ScheduleDTO> selectByEmployeeId(String employeeId) {
        return List.of();
    }

    @Override
    public List<ScheduleDTO> selectByEmployeeIdAndCalenderId(String employeeId, int calenderId) {
        return List.of();
    }

    @Override
    public List<ScheduleDTO> search() {
        return List.of();
    }

    @Override
    public ScheduleDTO selectById(int id) {
        return null;
    }

    @Override
    public void insert(ScheduleDTO dto) {

    }

    @Override
    public void update(ScheduleDTO dto) {

    }

    @Override
    public void deleteById(int id) {

    }
}
