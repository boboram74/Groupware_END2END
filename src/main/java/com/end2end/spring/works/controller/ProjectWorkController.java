package com.end2end.spring.works.controller;


import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.dto.FileDetailDTO;
import com.end2end.spring.file.service.FileService;
import com.end2end.spring.works.dto.ProjectSelectDTO;
import com.end2end.spring.works.dto.ProjectWorkDTO;
import com.end2end.spring.works.service.ProjectWorkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/work")
@Controller
public class ProjectWorkController {

    @Autowired
    FileService fserv;

    @Autowired
    ProjectWorkService wserv;

    @RequestMapping("/write/{id}")
    public String toWrite(@PathVariable int id, Model model) {
        model.addAttribute("projectId", id);
        // TODO: 게시글 입력 폼으로 이동
        return "/works/write";
    }

    @RequestMapping("/write/update")
    public String toUpdate(Model model) {
        // TODO: 게시글 수정 폼으로 이동
        return "/works/updatewrite";
    }

    @ResponseBody
    @RequestMapping("/detail/{id}")
    public Map<String, Object> toDetail(@PathVariable int id) {
        // TODO: 게시글 상세글로 이동
        ProjectWorkDTO wdto = wserv.selectByworksId(id);
        FileDTO fileDTO = FileDTO.builder()
                .projectWorkId(id)
                .build();
        List<FileDetailDTO> files = fserv.selectByParentsId(fileDTO);
        System.out.println(files);
        System.out.println(wdto);
//        model.addAttribute("files", files);
//        model.addAttribute("worksDTO", wdto);
        Map<String, Object> response = new HashMap<>();
        response.put("files", files);
        response.put("worksDTO", wdto);

        return response;


    }


    @RequestMapping("/insert")
    public String insert(int projectId, HttpSession session,ProjectWorkDTO wdto, @RequestParam("files") MultipartFile[] files) throws Exception {

        EmployeeDTO employeeDTO = (EmployeeDTO) session.getAttribute("employee");
        String projectUserId = wserv.selectByProjectIdAndEmployeeId(wdto.getProjectId(),employeeDTO.getId());
        wdto.setProjectUserId(projectUserId);

        wserv.insert(files, wdto);
        // TODO: 게시글 등록
        return "redirect:/project/detail/" + wdto.getProjectId();
    }
//    리다이렉트 헷갈리지말것 !- 이유: 폼 중복 제출 방지
//- 브라우저 새로고침 시 POST 요청이 중복되는 것을 방지


    @RequestMapping("/update")
    public String update(ProjectWorkDTO dto) {
        // TODO: 게시글 수정을 받음
        wserv.update(dto);
        return "redirect:/work/" + dto.getId();

    }

    @RequestMapping("/delete")
    public void deleteById(int id) {
        wserv.deleteById(id);
        // TODO: 작업 번호로 작업게시글삭제
    }



}
