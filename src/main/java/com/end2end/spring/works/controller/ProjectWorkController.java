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
import java.util.List;

@RequestMapping("/work")
@Controller
public class ProjectWorkController {

    @Autowired
    FileService fserv;

    @Autowired
    ProjectWorkService wserv;

    @RequestMapping("/list")
    public String toList(Model model) {
        // TODO:모든게시물 리스트에 표시
        List<ProjectWorkDTO>list =  wserv.selectAll();
        model.addAttribute("list", list);
        return "/works/detailpage";
    }

    @RequestMapping("/write")
    public String toWrite() {
        // TODO: 게시글 입력 폼으로 이동
        return "/works/write";
    }

    @RequestMapping("/write/update")
    public String toUpdate(Model model) {
        // TODO: 게시글 수정 폼으로 이동
        return "/works/detail";
    }

    @RequestMapping("/{id}")
//    ?projectId=${project.id}
    public String toDetail(@PathVariable int id, Model model) {
        // TODO: 게시글 상세글로 이동
        return "/works/detail";
    }


    @RequestMapping("/insert")
    public String insert(HttpSession session, ProjectWorkDTO wdto, @RequestParam("files") MultipartFile[] files) {
//
//        EmployeeDTO employeeDTO = (EmployeeDTO) session.getAttribute("employee");
//
//        wdto.getProjectId();
//        model.addAttribute("project",wdto);

        wserv.insert(wdto);
        // TODO: 게시글 등록
        return "redirect:/worksmain";
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
