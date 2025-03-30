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
}
