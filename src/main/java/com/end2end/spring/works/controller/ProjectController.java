package com.end2end.spring.works.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/project")
@Controller
public class ProjectController {
        @RequestMapping("/main")
        public String main() {
            return "/works/worksmain";
        }

        @RequestMapping("/insert")
        public void insert(String name) {
            // TODO: 프로젝트 추가
        }

    @RequestMapping("/userinsert")
    public void userinsert(String employeeId) {
        // TODO: 프로젝트 인원 추가
    }
}
