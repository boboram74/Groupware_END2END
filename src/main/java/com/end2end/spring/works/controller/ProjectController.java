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
    public String main(HttpSession session, Model model) {
        EmployeeDTO EmployeeDTO = (EmployeeDTO) session.getAttribute("employee");

        List<ProjectSelectDTO> projects = projectService.selectAllProject();

System.out.println("도착체크"+projects);
System.out.println(projects.get(0));
        model.addAttribute("projects", projects);
        model.addAttribute("employee", EmployeeDTO);

        return "works/worksmain";
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

    /// /            employeedto에 role 에서 권한부분에 팀리더만 버튼 보이도록 설정
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
    @ResponseBody
    @GetMapping("/members/{projectId}")
    public List<EmployeeDTO> getProjectMembers(@PathVariable int projectId) {
        return projectService.getMembersByProjectId(projectId);
    }

    @RequestMapping("/detail/{id}")
    public String detail(@PathVariable int id, Model model) {

        ProjectDTO project = projectService.selectById(id);
        List<ProjectWorkDTO> list = wserv.selectAll(id);
        List<ProjectSelectDTO> projects = projectService.selectAllProject();
        boolean isProjectFinish = list.stream()
                .allMatch(dto -> "FINISH".equals(dto.getState()));
        if (isProjectFinish) {
            for (ProjectSelectDTO dto : projects) {
                if (dto.getId() == id) {
                    dto.setStatus("FINISH");
                    break;
                }
            }
        }
        //isProjectFinish는 완료된 프로젝트만 숨길수있도록 조건을 걸어서 필요한거임 !!!!
        System.out.println(isProjectFinish);
        model.addAttribute("project", project);
        model.addAttribute("projectId", id);
        model.addAttribute("works", list);
        model.addAttribute("isProjectFinish", isProjectFinish);
        return "works/detailpage";
    }
    @ResponseBody
    @RequestMapping("/latestProjectId")
    public int findLatestProject(Model model) {
        ProjectDTO latestProject = projectService.findLatestProject();
        System.out.println("최근프로젝트번호:"+latestProject);
        model.addAttribute("latestProjectId", latestProject != null ? latestProject.getId() : -1);
        return latestProject.getId();
    }

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

        return projectService.selectByUser(name);
    }
}
