package com.end2end.spring.employee.controller;

import com.end2end.spring.employee.dto.LoginDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/employee")
@Controller
public class EmployeeController {
    @RequestMapping("/login")
    public void login(LoginDTO dto) {
        // TODO: 로그인 처리
    }

    @RequestMapping("/logout")
    public void logout() {
        // TODO: 로그아웃 처리
    }

    @RequestMapping("/mypage/{id}")
    public String toMypage(@PathVariable String id, Model model) {
        return "/employee/mypage";
    }

    @RequestMapping("/change/password")
    public void changePassword() {
        // TODO: 패스워드 변경
    }
}
