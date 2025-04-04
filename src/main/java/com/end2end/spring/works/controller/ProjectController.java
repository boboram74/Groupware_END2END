package com.end2end.spring.works.controller;

import com.end2end.spring.works.dto.ProjectDTO;
import com.end2end.spring.works.dto.ProjectUserDTO;
import com.end2end.spring.works.service.ProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.sql.Timestamp;
import java.util.List;

@RequestMapping("/project")
@Controller
public class ProjectController {

    @Autowired
    private ProjectService projectService;

        @RequestMapping("/main")
        public String main() {
            return "/works/worksmain";
        }
        @RequestMapping("/insertpage")
        public String insertpage() {
                    return "/works/insertpage";
        }//프로젝트 생성 페이지로 이동


        @RequestMapping("/insert")
        public void insert( ProjectDTO dto, ProjectUserDTO udto) {

            projectService.insert(dto,udto);

            // TODO: 프로젝트 생성
        }

    @RequestMapping("/userinsert")
    public void userinsert(String employeeId) {
        // TODO: 프로젝트 인원 추가
    }
}
