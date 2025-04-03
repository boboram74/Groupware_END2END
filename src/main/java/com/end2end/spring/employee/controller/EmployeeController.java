package com.end2end.spring.employee.controller;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.employee.dto.LoginDTO;
import com.end2end.spring.employee.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@RequestMapping("/employee")
@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    @RequestMapping("/login")
    public String login(@ModelAttribute LoginDTO dto, HttpSession session, Model model) {
        // TODO: 로그인 처리
         EmployeeDTO employee = employeeService.login(dto);
        if (employee != null) {
            session.setAttribute("employee", employee);
        }
        return "redirect:/";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        // TODO: 로그아웃 처리
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
}
