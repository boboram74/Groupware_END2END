package com.end2end.spring.schedule.serviceImpl;

import com.end2end.spring.alarm.AlarmService;
import com.end2end.spring.schedule.dao.ScheduleDAO;
import com.end2end.spring.schedule.dto.ScheduleDTO;
import com.end2end.spring.schedule.service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ScheduleServiceImpl implements ScheduleService {
    @Autowired ScheduleDAO scheduleDAO;
    @Autowired AlarmService alarmService;

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
        scheduleDAO.insert(dto);
        alarmService.sendScheduleAlarm(dto.getCalendarId());
    }

    @Override
    public void update(ScheduleDTO dto) {

    }

    @Override
    public void deleteById(int id) {

    }
}
