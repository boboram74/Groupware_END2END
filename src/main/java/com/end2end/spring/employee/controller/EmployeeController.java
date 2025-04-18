package com.end2end.spring.employee.controller;

import com.end2end.spring.commute.service.CommuteService;
import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.employee.dto.LoginDTO;
import com.end2end.spring.employee.service.EmployeeService;
import com.end2end.spring.main.dto.LoginHistoryDTO;
import com.end2end.spring.main.service.LoginHistoryService;
import com.end2end.spring.util.SecurityUtil;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

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
    public String login(@ModelAttribute LoginDTO dto, HttpSession session, HttpServletRequest request) {
        EmployeeDTO employee = employeeService.login(dto);

        // 1. 인증 실패
        if (employee == null) {
            return "redirect:/";
        }

        // 2. 권한 없음(no_auth) 체크
        String role = employee.getRole();
        if ("no_auth".equalsIgnoreCase(role)) {
            return "redirect:/";
        }

        // 3. 정상 로그인 처리
        if (employee != null) {
            LoginHistoryDTO loginHistoryDTO = LoginHistoryDTO.builder()
                    .employeeId(employee.getId())
                    .state("LOGIN")
                    .accessIp(SecurityUtil.getClientIp(request))
                    .build();
            loginHistoryService.insert(loginHistoryDTO);

            session.setAttribute("employee", employee);
            boolean isWorkOn = commuteService.isExistByState(employee.getId(), "WORK_ON");
            session.setAttribute("isWorkOn", isWorkOn);
            boolean isWorkOff = commuteService.isExistByState(employee.getId(), "WORK_OFF");
            session.setAttribute("isWorkOff", isWorkOff);
            session.setAttribute("accessIp", SecurityUtil.getClientIp(request));
        }
        return "redirect:/";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session, HttpServletRequest request) {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
        session.invalidate();

        LoginHistoryDTO loginHistoryDTO = LoginHistoryDTO.builder()
                .employeeId(employee.getId())
                .state("LOGOUT")
                .accessIp(SecurityUtil.getClientIp(request))
                .build();
        loginHistoryService.insert(loginHistoryDTO);
        return "redirect:/";
    }

    @RequestMapping("/toChangePwForm")
    public String toChangePwForm() {
        return "/main/changePw";
    }

    @PostMapping("/pwVali")
    @ResponseBody
    public boolean pwVali(@RequestBody String currentPw) {
        Map<String, Object> parsedCurrentPw = new Gson().fromJson(currentPw, Map.class);
        return employeeService.pwVali(SecurityUtil.hashPassword((String) parsedCurrentPw.get("currentPw")));
    }

    @RequestMapping("/changePw")
    @ResponseBody
    public ResponseEntity<String> changePw(String newPw, HttpSession session) {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
        String id = employee.getId();
        employeeService.changePw(SecurityUtil.hashPassword(newPw),id);
        session.invalidate();
        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
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
