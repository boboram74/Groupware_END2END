package com.end2end.spring.commute.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/commute")
@Controller
public class CommuteController {
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

    @RequestMapping("/insert")
    public void commute() {
        // TODO: 출퇴근
    }
}
