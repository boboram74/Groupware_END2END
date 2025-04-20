package com.end2end.spring.works.controller;

import com.end2end.spring.employee.dto.DepartmentDTO;
import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.works.dto.*;

import com.end2end.spring.works.service.ProjectService;

import com.end2end.spring.works.service.ProjectWorkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/project")
@Controller
public class ProjectController {

    @Autowired
    private ProjectService projectService;
    @Autowired
    private ProjectWorkService wserv;


    @RequestMapping("/main")
    public String main(HttpSession session, Model model) throws Exception {
        EmployeeDTO EmployeeDTO = (EmployeeDTO) session.getAttribute("employee");

        List<ProjectSelectDTO> projects = projectService.selectAllProject();

            for (ProjectSelectDTO dto : projects) {
                int id = dto.getId();
                List<ProjectWorkDTO> list = wserv.selectAll(id);

//                System.out.println("nearDeadline: " + dto.getNearDeadline());

                model.addAttribute("nearDeadline", dto.getNearDeadline());

            }


        model.addAttribute("isTeamLeader",
                "TEAM_LEADER".equals(EmployeeDTO.getRole()) && "연구팀".equals(EmployeeDTO.getDepartmentName()));
        model.addAttribute("projects", projects);
        model.addAttribute("employee", EmployeeDTO);

        return "works/worksmain";
    }
@ResponseBody
@RequestMapping("/hide")
public String hide(int projectId,String hideYn) {
//        System.out.println("프젝아이디"+projectId+hideYn);
    projectService.hideById(projectId,hideYn);
    return "SUCCESS";
}
    @RequestMapping("/insert")
    public String insert(@ModelAttribute ProjectInsertDTO dto) {
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
    public String detail(@PathVariable int id, Model model, HttpSession session) {
        EmployeeDTO employeeDTO = (EmployeeDTO) session.getAttribute("employee");
        ProjectDTO project = projectService.selectById(id);
        List<ProjectWorkDTO> list = wserv.selectAll(id);
model.addAttribute("employee", employeeDTO);
        model.addAttribute("project", project);
        model.addAttribute("projectId", id);
        model.addAttribute("works", list);

        return "works/detailpage";
    }

    @RequestMapping("/searchDetail/{id}")
    public String toSearchDetail(@PathVariable int id, Model model, HttpSession session) {
        EmployeeDTO EmployeeDTO = (EmployeeDTO) session.getAttribute("employee");
        ProjectDTO project = projectService.selectById(id);

        List<ProjectWorkDTO> list = wserv.selectAll(id);
        model.addAttribute("employee", EmployeeDTO);
        model.addAttribute("project", project);
        model.addAttribute("projectId", id);
        model.addAttribute("works", list);

        return "works/detailpage";
    }

    @ResponseBody
    @RequestMapping("/latestProjectId")
    public int findLatestProject(Model model) {
        ProjectDTO latestProject = projectService.findLatestProject();
        model.addAttribute("latestProjectId", latestProject != null ? latestProject.getId() : -1);
        return latestProject.getId();
    }

    @ResponseBody
    @RequestMapping("/update/{id}")
    public Map<String, Object> updateForm(@PathVariable int id) {
        List<EmployeeDTO> selectedMembers = projectService.getMembersByProjectId(id);//선택되었던 멤버들
        Map<String, Object> result = new HashMap<>();

        ProjectDTO dto = projectService.selectById(id);//저장된 프젝 정보
        result.put("project", dto);
        result.put("selectedMembers", selectedMembers);


        return result;
    }

    @RequestMapping("/update")
    public String update(@ModelAttribute ProjectInsertDTO dto, @RequestParam("employeeId") List<String> employeeId) {

        projectService.updateProject(dto); // 기본 정보 수정
        int projectId = dto.getProjectId();
        projectService.updateProjectUser(projectId, employeeId);


        return "redirect:/project/main";
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

        return "works/worksmain";
    }

    @ResponseBody
    @RequestMapping("/searchUser")
    public List<EmployeeDTO> selectByUser(@RequestParam String name) {

        return projectService.selectByUser(name);

    }
}
