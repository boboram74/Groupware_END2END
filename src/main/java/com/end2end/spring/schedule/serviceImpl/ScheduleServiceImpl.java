package com.end2end.spring.schedule.serviceImpl;

import com.end2end.spring.alarm.AlarmService;
import com.end2end.spring.schedule.dao.ScheduleDAO;
import com.end2end.spring.schedule.dto.ScheduleDTO;
import com.end2end.spring.schedule.service.ScheduleService;
import com.end2end.spring.util.EventDTO;
import com.end2end.spring.util.HolidayUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ScheduleServiceImpl implements ScheduleService {
    @Autowired ScheduleDAO scheduleDAO;
    @Autowired AlarmService alarmService;

    @Override
    public List<EventDTO> selectByEmployeeId(String employeeId, LocalDate startDate, LocalDate endDate) throws IOException {
        List<ScheduleDTO> scheduleDTOList = scheduleDAO.selectByEmployeeId(employeeId);

        List<EventDTO> eventList = scheduleDTOList.stream()
                .map(scheduleDTO ->
                        EventDTO.convertFromSchedule(scheduleDTO, startDate, endDate))
                .collect(Collectors.toList());

        List<EventDTO> holidayList = HolidayUtil.getPeriodHolidayList(startDate, endDate).stream()
                .map(EventDTO::convertFromHoliday)
                .collect(Collectors.toList());
        eventList.addAll(holidayList);

        return eventList;
    }

    @Override
    public List<EventDTO> selectByCalenderId(int calenderId) {
        return List.of();
    }

    @Override
    public List<ScheduleDTO> search() {
        return List.of();
    }

    @Override
    public int countTodayScheduleByEmployeeId(String employeeId) {
        return scheduleDAO.countTodayScheduleByEmployeeId(employeeId);
    }

    @Override
    public ScheduleDTO selectById(int id) {
        return scheduleDAO.selectById(id);
    }

    @Override
    public void insert(ScheduleDTO dto) {
        scheduleDAO.insert(dto);
        alarmService.sendScheduleAlarm(dto.getCalendarId());
    }

    @Override
    public void update(ScheduleDTO dto) {
        scheduleDAO.update(dto);
        alarmService.sendScheduleUpdateAlarm(dto.getCalendarId());
    }

    @Override
    public void deleteById(int id) {
        alarmService.sendScheduleDeleteAlarm(id);
        scheduleDAO.deleteById(id);
    }
}
