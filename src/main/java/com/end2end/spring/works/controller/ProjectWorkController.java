package com.end2end.spring.works.controller;


import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.dto.FileDetailDTO;
import com.end2end.spring.file.service.FileService;
import com.end2end.spring.works.dto.*;
import com.end2end.spring.works.service.ProjectService;
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
    ProjectService serv;
    @Autowired
    ProjectWorkService wserv;

    @RequestMapping("/write/{id}")
    public String toWrite(@PathVariable int id, Model model, HttpSession session) {

        EmployeeDTO employeeDTO = (EmployeeDTO) session.getAttribute("employee");

        ProjectUserDTO udto = serv.selectByProjectIdAndEmployeeId(id, employeeDTO.getId());

        boolean isProjectUser = (udto.getEmployeeId().equals(employeeDTO.getId()));
        model.addAttribute("isProjectUser", isProjectUser);
        model.addAttribute("projectId", id);
        model.addAttribute("dto", serv.selectProjectDeadLine(id));
        // TODO: 게시글 입력 폼으로 이동
        if (isProjectUser) {
            return "/works/write";
        }
        return "redirect:/project/detail/"+id;
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
//        System.out.println(files);
//        System.out.println(wdto);

        Map<String, Object> response = new HashMap<>();
        response.put("files", files);
        response.put("worksDTO", wdto);
        return response;
    }

    @ResponseBody
    @RequestMapping("/search/{projectId}")
    public List<ProjectWorkDTO> searchBynameAndTitle(String keyword, @PathVariable int projectId, String searchOption) {
//       System.out.println(keyword+projectId);
        return wserv.searchBynameAndTitle(keyword, projectId, searchOption);
    }


    @RequestMapping("/insert")
    public String insert(int projectId, HttpSession session, ProjectWorkDTO wdto, @RequestParam("files") MultipartFile[] files) throws Exception {

        EmployeeDTO employeeDTO = (EmployeeDTO) session.getAttribute("employee");
        ProjectUserDTO udto = wserv.selectByProjectIdAndEmployeeId(wdto.getProjectId(), employeeDTO.getId());
        wdto.setProjectUserId(udto.getId());
//        System.out.println(projectUserId);

        wserv.insert(files, wdto);
        // TODO: 게시글 등록
        return "redirect:/project/detail/" + wdto.getProjectId();
    }
//    리다이렉트 헷갈리지말것 !- 이유: 폼 중복 제출 방지
//- 브라우저 새로고침 시 POST 요청이 중복되는 것을 방지

//    @ResponseBody
//    @RequestMapping("/update")
//    public String update(ProjectWorkDTO dto,@RequestParam("files") MultipartFile[] files) throws Exception {
//        System.out.println(dto);
//        System.out.println("수정 컨트롤러 도착 ");
//        // TODO: 게시글 수정을 받음
//        wserv.update(files,dto);
//        return "SUCCESS";
//
//    }

    @ResponseBody
    @RequestMapping("/update")
    public void update(MultipartFile[] files, ProjectWorkUpdateDTO dto) throws Exception {

//        System.out.println("수정 컨트롤러 도착 ");
        // TODO: 게시글 수정을 받음
        FileDTO fileDTO = FileDTO.builder()
                .projectWorkId(dto.getId())
                .build();
        fserv.update(files, fileDTO, dto.getFileId());

        ProjectWorkDTO wdto = ProjectWorkDTO.builder()
                .id(dto.getId())
                .title(dto.getTitle())
                .content(dto.getContent())
                .type(dto.getType())
                .state(dto.getState())
                .priority(dto.getPriority())
                .deadLine(dto.getDeadLine())
                .build();
        wserv.update(wdto);
//        System.out.println(dto.getContent());
    }

    @ResponseBody
    @RequestMapping("/updateState")
    public int updateState(int workItemId, String state, int projectId) {

        // 클라이언트로부터 데이터 수신
//    int workItemId = (int) data.get("workItemId");
//    String state = (String) data.get("state");
//        System.out.println("아이디값" + workItemId);
//        System.out.println("상태값" + state);
//        System.out.println("프젝아이디값" + projectId);
        return wserv.updateState(state, workItemId, projectId);
    }

    @ResponseBody
    @RequestMapping("/finish")
    public void finish(int projectId) {

        wserv.endworks(projectId);
    }

    @ResponseBody
    @RequestMapping("/delete")
    public String deleteById(int workId) {

        wserv.deleteById(workId);
        // TODO: 작업 번호로 작업게시글삭제
        return "SUCCESS";
    }

    @ResponseBody
    @RequestMapping("chartData/{selectedId}")
    public Map<String, Integer> getChartDataCount(@PathVariable("selectedId") int selectedId) {

        int chartData = wserv.getChartDataCount(selectedId);
//        System.out.println("차트값" + chartData);
        Map<String, Integer> map = new HashMap<>();
        map.put("progress", chartData);
        return map;
    }

    //진행률 퍼센트용
    @ResponseBody
    @RequestMapping("statusChartData/{selectedId}")
    public Map<String, Integer> getStatusChartData(@PathVariable("selectedId") int selectedId) {

        Map<String, Integer> chartData = new HashMap<>();

        int notStarted = wserv.countByState(selectedId, "READY");
        int inProgress = wserv.countByState(selectedId, "ONGOING");
        int completed = wserv.countByState(selectedId, "FINISH");
//        System.out.println("컨트롤러도착:" + notStarted);
        chartData.put("READY", notStarted);
        chartData.put("ONGOING", inProgress);
        chartData.put("FINISH", completed);

        return chartData;
    }

    @ResponseBody
    @RequestMapping("typeChartData/{selectedId}")
    public Map<String, Integer> getCountByType(@PathVariable("selectedId") int selectedId) {
        Map<String, Integer> chartData = new HashMap<>();

        int document = wserv.countByType(selectedId, "DOCUMENT");
        int report = wserv.countByType(selectedId, "REPORT");
        int wbs = wserv.countByType(selectedId, "WBS");
        int meetingFolder = wserv.countByType(selectedId, "MEETING_FOLDER");
        int specification = wserv.countByType(selectedId, "SPECIFICATION");

        chartData.put("DOCUMENT", document);
        chartData.put("REPORT", report);
        chartData.put("WBS", wbs);
        chartData.put("MEETING_FOLDER", meetingFolder);
        chartData.put("SPECIFICATION", specification);
//        System.out.println(chartData);
//        System.out.println("컨트롤러" + wserv.countByState(selectedId, "DOCUMENT"));
        return chartData;

    }

}
