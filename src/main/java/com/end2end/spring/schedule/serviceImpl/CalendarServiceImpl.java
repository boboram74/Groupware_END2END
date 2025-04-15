package com.end2end.spring.schedule.serviceImpl;

import com.end2end.spring.alarm.AlarmService;
import com.end2end.spring.schedule.dao.CalendarDAO;
import com.end2end.spring.schedule.dao.CalendarUserDAO;
import com.end2end.spring.schedule.dto.CalendarDTO;
import com.end2end.spring.schedule.dto.CalendarInsertDTO;
import com.end2end.spring.schedule.dto.CalendarUserDTO;
import com.end2end.spring.schedule.service.CalendarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class CalendarServiceImpl implements CalendarService {
    @Autowired private CalendarDAO calendarDAO;
    @Autowired private CalendarUserDAO  calendarUserDAO;
    @Autowired private AlarmService alarmService;

    @Override
    public List<CalendarDTO> selectByEmployeeId(String employeeId) {
        return calendarDAO.selectByEmployeeId(employeeId);
    }

    @Override
    public List<CalendarDTO> search() {
        // TODO: 검색 결과에 따른 모든 일정을 출력
        return null;
    }

    @Override
    public Map<String, Object> selectById(int id) {
        Map<String, Object> map = new HashMap<>();
        map.put("calendar", calendarDAO.selectById(id));
        map.put("members", calendarUserDAO.selectByCalendarId(id));

        return map;
    }

    @Transactional
    @Override
    public void insert(CalendarInsertDTO dto) {
        CalendarDTO calendarDTO = CalendarDTO.builder()
                .title(dto.getTitle())
                .color(dto.getColor())
                .build();
        calendarDAO.insert(calendarDTO);

        List<CalendarUserDTO> calendarUserDTOList =
                dto.getEmployeeId().stream()
                        .map(employeeId -> CalendarUserDTO.builder()
                                .calendarId(calendarDTO.getId())
                                .employeeId(employeeId)
                                .build())
                        .collect(Collectors.toList());
        calendarUserDAO.insertAll(calendarUserDTOList);

        alarmService.sendCalendarCreateAlarm(calendarDTO.getId());
    }

    @Override
    public void update(CalendarDTO dto) {
        calendarDAO.update(dto);
    }

    @Override
    public void deleteById(int id) {
        calendarDAO.deleteById(id);
    }
}
