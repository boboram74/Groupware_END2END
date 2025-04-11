package com.end2end.spring.works.controller;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.works.dto.ProjectDTO;

import com.end2end.spring.works.dto.ProjectInsertDTO;

import com.end2end.spring.works.dto.ProjectSelectDTO;
import com.end2end.spring.works.dto.ProjectWorkDTO;
import com.end2end.spring.works.service.ProjectService;

import com.end2end.spring.works.service.ProjectWorkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


import javax.servlet.http.HttpSession;
import java.util.List;

@RequestMapping("/project")
@Controller
public class ProjectController {

    @Autowired
    private ProjectService projectService;
    @Autowired
    private ProjectWorkService wserv;


        @RequestMapping("/main")
        public String main(HttpSession session,Model model) {
            EmployeeDTO EmployeeDTO = (EmployeeDTO)session.getAttribute("employee");

            List<ProjectSelectDTO> projects = projectService.selectAllProject();


            model.addAttribute("projects",projects);

            return   "works/worksmain";
        }

//    @RequestMapping("/profileSelect")
//    public String selectProjectMemberProfiles(Model model, @RequestParam int id) {
//
//        System.out.println("프로필찾는컨트롤러도착");
//
//        List<EmployeeDTO> profiles = projectService.selectProjectMemberProfiles(id);
//        model.addAttribute("profiles", profiles);
//        return "works/worksmain"; // 리다이렉트 대신 직접 뷰 반환
//    }

//        @RequestMapping("list")
//            public String list(HttpSession session,Model model ){
//            EmployeeDTO EmployeeDTO = (EmployeeDTO)session.getAttribute("employee");
//
//            model.addAttribute("projects",  projectService.selectAll());
//
////            employeedto에 role 에서 권한부분에 팀리더만 버튼 보이도록 설정
//            return     "works/worksmain";
//        }

        @RequestMapping("/insert")
        public String insert(@ModelAttribute ProjectInsertDTO dto) {
            System.out.println(dto);
            System.out.println("프로젝트컨트롤러도착");

            projectService.insert(dto);

            // TODO: 프로젝트 생성
            return "redirect:/project/main";
        }


    @RequestMapping("/detail/{id}")
    public String detail(@PathVariable int id, Model model) {
            System.out.println("디테일 프젝 컨트롤러 도착");
            ProjectDTO project = projectService.selectById(id);//프로젝트 아이디를 받아서 정보를 가져오도록
        List<ProjectWorkDTO>list =  wserv.selectAll();

        model.addAttribute("project", project);
        model.addAttribute("projectId", id);
        model.addAttribute("works", list);

        return "works/detailpage";
    }

    // Update
    @ResponseBody
    @RequestMapping("/update/{id}")
    public ProjectDTO updateForm(@PathVariable int id) {
        return projectService.selectById(id);
    }

    @RequestMapping("/update")
    public String update(@ModelAttribute ProjectDTO dto, Model model) {
        projectService.update(dto);
        return "redirect:/project/detail/" + dto.getId();
    }

    // Delete
    @RequestMapping("/delete/{id}")
    public String delete(@PathVariable int id) {
        projectService.deleteById(id);
        return "redirect:/project/main";
    }

    @RequestMapping("/search")
    public String selectByName(@RequestParam String name, Model model) {

        List<ProjectDTO> result = projectService.selectByName(name);
        model.addAttribute("projects", result);
        //jsp에서 검색해서 나오는 부분에 projects로 c:foreach로 풀어줘야됨
        return "works/worksmain";
    }
    @ResponseBody
    @RequestMapping("/searchUser")
    public List<EmployeeDTO> selectByUser(@RequestParam String name) {

        return    projectService.selectByUser(name);
    }

}
