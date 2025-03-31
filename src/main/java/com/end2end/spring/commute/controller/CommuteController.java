package com.end2end.spring.commute.controller;

import com.end2end.spring.commute.dto.CommuteDTO;
import com.end2end.spring.commute.service.CommuteService;
import com.end2end.spring.employee.dto.EmployeeDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@RequestMapping("/commute")
@Controller
public class CommuteController {
    @Autowired
    private CommuteService commuteService;

    @RequestMapping("/{employeeId}")
    public String toDetail(@PathVariable int employeeId, Model model) {
        // TODO: 해당 id의 사원의 detail.jsp로 이동
        return "commute/detail";
    }

    @RequestMapping("/list/{departmentId}")
    public String toList(@PathVariable int departmentId, Model model) {
        // TODO: 해당 id의 부서의 list.jsp로 이동
        return "commute/list";
    }

    @ResponseBody
    @RequestMapping("/insert")
    public String commute(HttpSession session, String state) {
        // TODO: 출퇴근
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");

        CommuteDTO dto = CommuteDTO.builder()
                .employeeId(employee.getEmployeeId())
                .state(state)
                .build();

        commuteService.insert(dto);
        return dto.getState();
    }
}
