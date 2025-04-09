package com.end2end.spring.commute.controller;

import com.end2end.spring.commute.dto.CommuteDTO;
import com.end2end.spring.commute.dto.SelectPeriodDTO;
import com.end2end.spring.commute.dto.SolderingDTO;
import com.end2end.spring.commute.service.CommuteService;
import com.end2end.spring.commute.service.SolderingService;
import com.end2end.spring.commute.service.VacationService;
import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.employee.service.EmployeeService;
import com.end2end.spring.util.EventDTO;
import com.end2end.spring.util.HolidayUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@RequestMapping("/commute")
@Controller
public class CommuteController {
    @Autowired private EmployeeService employeeService;
    @Autowired private CommuteService commuteService;
    @Autowired private SolderingService solderingService;
    @Autowired private VacationService vacationService;

    @RequestMapping("/detail")
    public String toDetail(HttpSession session, Model model) {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
        CommuteDTO commuteDTO = CommuteDTO.builder()
                .employeeId(employee.getId())
                .build();

        commuteDTO.setState("WORK_ON");
        CommuteDTO workOnTime = commuteService.selectByStateAndEmployeeId(commuteDTO);
        if(workOnTime != null) {
            model.addAttribute("workOnTime", workOnTime.getRegDate());
        }

        commuteDTO.setState("WORK_OFF");
        CommuteDTO workOffTime = commuteService.selectByStateAndEmployeeId(commuteDTO);
        if(workOffTime != null) {
            model.addAttribute("workOffTime", workOffTime.getRegDate());
        }

        model.addAttribute("workOnCount", commuteService.countWorkOnThisWeekByEmployeeId(employee.getId()));
        model.addAttribute("workOnRate", commuteService.rateWorkOnThisWeekByEmployeeId(employee.getId()));

        SolderingDTO solderingDTO = SolderingDTO.builder()
                .employeeId(employee.getId())
                .build();
        solderingDTO.setState("ABSENCE");
        model.addAttribute("absenceCount", solderingService.countTisWeekByStateAndEmployeeId(solderingDTO));

        solderingDTO.setState("LATE");
        model.addAttribute("lateCount", solderingService.countTisWeekByStateAndEmployeeId(solderingDTO));

        solderingDTO.setState("LEAVE_EARLY");
        model.addAttribute("leaveEarlyCount", solderingService.countTisWeekByStateAndEmployeeId(solderingDTO));

        model.addAttribute("totalWorkTimeThisWeek", commuteService.sumTotalWorkTimeThisWeekByEmployeeId(employee.getId()));

        model.addAttribute("totalVacationDates", vacationService.sumTotalVacationDates(employee.getId()));
        model.addAttribute("totalUsedVacationDates", vacationService.sumTotalUsedVacationDates(employee.getId()));
        model.addAttribute("thisMonthUsedVacationDates", vacationService.sumThisMonthUsedVacationDates(employee.getId()));

        model.addAttribute("active", 0);

        return "commute/detail";
    }

    @RequestMapping("/list")
    public String toList(HttpSession session, Model model) {
        // TODO: 해당 id의 부서의 list.jsp로 이동
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
        List<EmployeeDTO> employeeList = employeeService.selectByDepartmentId(employee.getDepartmentId());

        return "commute/list";
    }

    @ResponseBody
    @RequestMapping("/workOn")
    public boolean workOn(HttpSession session) throws IOException {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
        boolean workOn = commuteService.workOn(employee.getId());

        session.setAttribute("isWorkOn", workOn);
        return workOn;
    }

    @ResponseBody
    @RequestMapping("/workOff")
    public boolean workOff(HttpSession session) throws IOException {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
        boolean workOff = commuteService.workOff(employee.getId());

        session.setAttribute("isWorkOff", workOff);
        return workOff;
    }

    @ResponseBody
    @RequestMapping("/select/period")
    public List<EventDTO> selectPeriodWorkState(HttpSession session, SelectPeriodDTO dto) {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
        dto.setEmployeeId(employee.getId());

        return commuteService.selectPeriodWorkState(dto);
    }

    @ResponseBody
    @RequestMapping("/test")
    public boolean leaveEarly(HttpSession session) throws IOException {
        //List<HolidayUtil.HolidayDTO> list = HolidayUtil.generateHolidayList(year, month);

        return HolidayUtil.isHoliday(LocalDate.now());
/*
        return list.stream()
                .map(EventDTO::convertFromHoliday)
                .collect(Collectors.toList());

 */
    }
}
