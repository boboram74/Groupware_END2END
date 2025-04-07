package com.end2end.spring.works.controller;

import com.end2end.spring.works.dto.ProjectDTO;
import com.end2end.spring.works.dto.ProjectUserDTO;
import com.end2end.spring.works.service.ProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


import java.util.List;
import java.util.Map;

@RequestMapping("/project")
@Controller
public class ProjectController {

    @Autowired
    private ProjectService projectService;

        @RequestMapping("/main")
        public String main(Model model) {
            List<ProjectDTO> projects = projectService.selectAll();
            //진행상태별 프로젝트 수
            Map<String, Integer> projectStats = projectService.getProjectStatistics();
            model.addAttribute("projects", projects);
            model.addAttribute("stats", projectStats);
            return "works/worksmain";
        }
//        @RequestMapping("/insertpage")
//        public String insertpage() {
//                    return "/works/insertpage";
//        }//프로젝트 생성 페이지로 이동 대신 모달창으로 대체


        @RequestMapping("/insert")
        public void insert( ProjectDTO dto, ProjectUserDTO udto) {

            projectService.insert(dto,udto);

            // TODO: 프로젝트 생성
        }


    @RequestMapping("/detail/{id}")
    public String detail(@PathVariable int id, Model model) {
        ProjectDTO project = projectService.getProjectById(id);//프로젝트 아이디를 받아서 정보를 가져오도록
        model.addAttribute("project", project);
        return "works/projectDetail";
    }//프로젝트의 디테일 누르면 works 페이지로 가도록

    // Update
    @RequestMapping("/update/{id}")
    public String updateForm(@PathVariable Long id, Model model) {
        ProjectDTO project = projectService.getProjectById(id);
        model.addAttribute("project", project);
        return "works/updateForm";
    }

    @RequestMapping("/update")
    public String update(@ModelAttribute ProjectDTO dto) {
        projectService.update(dto);
        return "redirect:/project/detail/" + dto.getId();
    }

    // Delete
    @RequestMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        projectService.deleteById(id);
        return "redirect:/project/main";
    }

    // Search
    @RequestMapping("/search")
    public String searchByName(@RequestParam String name) {
        List<ProjectDTO> result = projectService.searchByName(name);
        model.addAttribute("projects", result);
        return "works/worksmain";
    }


}
