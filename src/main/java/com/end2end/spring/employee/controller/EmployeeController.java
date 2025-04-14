package com.end2end.spring.employee.controller;

import com.end2end.spring.commute.service.CommuteService;
import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.employee.dto.LoginDTO;
import com.end2end.spring.employee.service.EmployeeService;
import com.end2end.spring.main.dto.LoginHistoryDTO;
import com.end2end.spring.main.service.LoginHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RequestMapping("/employee")
@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    @Autowired
    private LoginHistoryService loginHistoryService;

    @Autowired
    private CommuteService commuteService;

    @RequestMapping("/login")
    public String login(@ModelAttribute LoginDTO dto, HttpSession session, HttpServletRequest request, Model model) {
        EmployeeDTO employee = employeeService.login(dto);

        if (employee != null) {
            LoginHistoryDTO loginHistoryDTO = LoginHistoryDTO.builder()
                    .employeeId(employee.getId())
                    .state("LOGIN")
                    .accessIp(request.getRemoteAddr())
                    .build();
            loginHistoryService.insert(loginHistoryDTO);

            session.setAttribute("employee", employee);
            boolean isWorkOn = commuteService.isExistByState(employee.getId(), "WORK_ON");
            session.setAttribute("isWorkOn", isWorkOn);
            boolean isWorkOff = commuteService.isExistByState(employee.getId(), "WORK_OFF");
            session.setAttribute("isWorkOff", isWorkOff);
        }
        return "redirect:/";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @RequestMapping("/change/password")
    public void changePassword() {
        // TODO: 패스워드 변경
    }

    @RequestMapping("/{id}")
    public void selectEmployee(@PathVariable String id) {
        // TODO: 해당 id 사원의 데이터를 출력
    }

    @RequestMapping("/detail/{id}")
    public void selectDetailEmployee(@PathVariable String id) {
        // TODO: 해당 id 사원의 상세 데이터를 출력
    }

    @ResponseBody
    @RequestMapping("/department/{departmentId}")
    public List<EmployeeDTO> selectDepartmentEmployee(@PathVariable int departmentId) {
        return employeeService.selectByDepartmentId(departmentId);
    }

    @ResponseBody
    @RequestMapping("/orgChart")
    public List<EmployeeDTO>  getOrgChart(Model model) {
        return employeeService.selectAll();
    }
}
