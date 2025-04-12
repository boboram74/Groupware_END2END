package com.end2end.spring.works.controller;


import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.dto.FileDetailDTO;
import com.end2end.spring.file.service.FileService;
import com.end2end.spring.works.dto.ProjectSelectDTO;
import com.end2end.spring.works.dto.ProjectUserDTO;
import com.end2end.spring.works.dto.ProjectWorkDTO;
import com.end2end.spring.works.dto.WorkUpdateDTO;
import com.end2end.spring.works.service.ProjectWorkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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

    @ResponseBody
    @RequestMapping("/update")
    public String update(ProjectWorkDTO dto,@RequestParam("files") MultipartFile[] files) throws Exception {
        System.out.println(dto);
        System.out.println("수정 컨트롤러 도착 ");
        // TODO: 게시글 수정을 받음
        wserv.update(files,dto);
        return "SUCCESS";

    }
    @ResponseBody
    @RequestMapping("/updateState")
    public String updateState(int workItemId, String state) {
        System.out.println("도착");
    // 클라이언트로부터 데이터 수신
//    int workItemId = (int) data.get("workItemId");
//    String state = (String) data.get("state");
   System.out.println("아이디값"+workItemId);
   System.out.println("상태값"+state);
    wserv.updateState(state, workItemId);

    return "SUCCESS";
}
    @ResponseBody
    @RequestMapping("/delete")
    public String deleteById(int workId) {
        System.out.println("작업번호 컨트롤러도착:"+workId);
        wserv.deleteById(workId);
        // TODO: 작업 번호로 작업게시글삭제
        return "SUCCESS";
    }

}
