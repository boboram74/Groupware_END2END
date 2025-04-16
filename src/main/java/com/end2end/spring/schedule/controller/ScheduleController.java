package com.end2end.spring.schedule.controller;

import com.end2end.spring.schedule.dto.ScheduleDTO;
import com.end2end.spring.schedule.dto.ScheduleInsertDTO;
import com.end2end.spring.schedule.service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.Timestamp;
import java.util.List;

@RequestMapping("/schedule")
@Controller
public class ScheduleController {
    @Autowired ScheduleService scheduleService;

    @ResponseBody
    @RequestMapping("/list")
    public List<ScheduleDTO> selectByEmployeeId(String employeeId) {
        return scheduleService.selectByEmployeeId(employeeId);
    }

    @RequestMapping("/insert")
    public String insert(ScheduleInsertDTO dto) {
        ScheduleDTO scheduleDTO = ScheduleDTO.builder()
                .calendarId(dto.getCalendarId())
                .title(dto.getTitle())
                .content(dto.getContent())
                .startDate(Timestamp.valueOf(dto.getStartDate()))
                .endDate(Timestamp.valueOf(dto.getEndDate()))
                .build();
        scheduleService.insert(scheduleDTO);

        return "redirect:/calendar/list";
    }

    @RequestMapping("/update")
    public void update(ScheduleDTO dto) {
        scheduleService.update(dto);
    }

    @RequestMapping("/delete/{id}")
    public void deleteById(@PathVariable int id) {
        scheduleService.deleteById(id);
    }
}
