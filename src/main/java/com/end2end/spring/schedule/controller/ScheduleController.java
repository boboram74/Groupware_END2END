package com.end2end.spring.schedule.controller;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.schedule.dto.ScheduleDTO;
import com.end2end.spring.schedule.dto.ScheduleInsertDTO;
import com.end2end.spring.schedule.service.ScheduleService;
import com.end2end.spring.util.EventDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;
import java.time.LocalDate;
import java.util.List;

@RequestMapping("/schedule")
@Controller
public class ScheduleController {
    @Autowired ScheduleService scheduleService;

    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    @ResponseBody
    @RequestMapping("/list")
    public List<EventDTO> selectByEmployeeId(HttpSession session, String startDate, String endDate)
            throws IOException {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");

        LocalDate parsedStartDate = LocalDate.parse(startDate, DATE_FORMATTER);
        LocalDate parsedEndDate = LocalDate.parse(endDate, DATE_FORMATTER);

        return scheduleService.selectByEmployeeId(employee.getId(), parsedStartDate, parsedEndDate);
    }

    @ResponseBody
    @RequestMapping("/detail/${id}")
    public ScheduleDTO selectById(@PathVariable int id) {
        return scheduleService.selectById(id);
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
