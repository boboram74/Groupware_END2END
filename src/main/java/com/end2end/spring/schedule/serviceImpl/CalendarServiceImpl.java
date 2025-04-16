package com.end2end.spring.schedule.serviceImpl;

import com.end2end.spring.alarm.AlarmService;
import com.end2end.spring.alarm.AlarmType;
import com.end2end.spring.employee.dao.EmployeeDAO;
import com.end2end.spring.employee.dto.EmployeeDTO;
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
    @Autowired private EmployeeDAO employeeDAO;

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

        List<CalendarUserDTO> calendarDTOList = calendarUserDAO.selectByCalendarId(id);
        List<EmployeeDTO> members = employeeDAO.selectByIdIn(
                calendarDTOList.stream()
                        .map(CalendarUserDTO::getEmployeeId)
                        .collect(Collectors.toList()));
        map.put("members", members);

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
    public void update(CalendarInsertDTO dto) {
        CalendarDTO calendarDTO = CalendarDTO.builder()
                .id(dto.getId())
                .title(dto.getTitle())
                .color(dto.getColor())
                .build();
        calendarDAO.update(calendarDTO);

        List<CalendarUserDTO> calendarUserDTOList =
                calendarUserDAO.selectByCalendarId(dto.getId());

        for(CalendarUserDTO calendarUserDTO : calendarUserDTOList) {
            boolean isExist = false;
            for(String employeeId : dto.getEmployeeId()) {
                if(employeeId.equals(calendarUserDTO.getEmployeeId())) {
                    isExist = true;
                    alarmService.sendCalendarUpdateStateAlarm(
                            AlarmType.CALENDAR_UPDATE, employeeId);
                    break;
                }
            }

            if(!isExist) {
                calendarUserDAO.deleteById(calendarUserDTO.getId());
                alarmService.sendCalendarUpdateStateAlarm(
                        AlarmType.CALENDAR_DELETE, calendarUserDTO.getEmployeeId());
            }
        }

        for(String employeeId : dto.getEmployeeId()) {
            boolean isExist = false;
            for(CalendarUserDTO calendarUserDTO : calendarUserDTOList) {
                if(employeeId.equals(calendarUserDTO.getEmployeeId())) {
                    isExist = true;
                    break;
                }
            }

            if(!isExist) {
                CalendarUserDTO calendarUserDTO = CalendarUserDTO.builder()
                        .calendarId(dto.getId())
                        .employeeId(employeeId)
                        .build();
                calendarUserDAO.insert(calendarUserDTO);
                alarmService.sendCalendarUpdateStateAlarm(
                        AlarmType.CALENDAR_CREATE, employeeId);
            }
        }
    }

    @Override
    public void deleteById(int id) {
        calendarDAO.deleteById(id);
    }
}
