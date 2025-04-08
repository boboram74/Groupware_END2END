package com.end2end.spring.approval.controller;

import com.end2end.spring.approval.dto.ApprovalDTO;
import com.end2end.spring.approval.dto.ApprovalInsertDTO;
import com.end2end.spring.approval.dto.ApproverDTO;
import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.approval.dto.TempApprovalDTO;
import com.end2end.spring.approval.service.ApprovalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@RequestMapping("/approval")
@Controller
public class ApprovalController {

    @Autowired
    public ApprovalService approvalService;

    @RequestMapping("/list")
    public String toList(HttpSession session, Model model) {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
        String employeeId = employee.getId();

        List<Map<String, Object>> waitingList = approvalService.selectByState("ONGOING", employeeId);
        List<Map<String, Object>> goingList = approvalService.selectByState("ONGOING", employeeId);
        List<Map<String, Object>> completedList = approvalService.selectByState("SUBMIT", employeeId);


        System.out.println(waitingList);
        System.out.println(goingList);
        System.out.println(completedList);
        model.addAttribute("waitingList", waitingList);
        model.addAttribute("goingList", goingList);
        model.addAttribute("completedList", completedList);

        return "approval/list";
    }


    @RequestMapping("/list/{employeeId}")
    public String toListEmployee(@PathVariable String employeeId, Model model) {
        // TODO: 해당 사원의 모든 전자결재를 list.jsp에 출력
        return "approval/list";
    }

    @RequestMapping("/list/important/{employeeId}")
    public String toListImportant(@PathVariable String employeeId, Model model) {
        // TODO: 해당 사원의 중요 전자 결재를 list.jsp에 출력
        return "approval/list";
    }

    @RequestMapping("/list/search")
    public String toListSearch(Model model) {
        // TODO: 모든 전자 결재의 검색 결과를 list.jsp에 출력
        return "approval/list";
    }

    @RequestMapping("/list/search/{employeeId}")
    public String toListSearchEmployee(@PathVariable String employeeId, Model model) {
        // TODO: 해당 사원의 검색 결과를 list.jsp에 출력
        return "approval/list";
    }

    @RequestMapping("/list/temp/{employeeId}")
    public String toListTemp(Model model, @PathVariable String employeeId) {
        // TODO: 해당 사원의 임시 저장된 결과를 list.jsp에 출력
        return "approval/list";
    }

    @RequestMapping("/write")
    public String toWrite(HttpSession session, Model model) {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");

        model.addAttribute("employee", employee);
        return "approval/write";
    }

    @RequestMapping("/detail/{id}")
    public String toDetail(Model model, @PathVariable String id, HttpSession session) {
        try {
            EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
            if (employee == null) {
                return "redirect:/login";
            }

            Map<String, Object> approval = approvalService.selectById(id);
            System.out.println(approval);
            if (approval == null) {
                model.addAttribute("error", "존재하지 않는 문서입니다.");
                return "error/404";
            }

            List<String> nextId = approvalService.nextId(id);

            model.addAttribute("approval", approval);
            model.addAttribute("nextId", nextId);
            model.addAttribute("employee", employee);

            return "approval/detail";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "문서를 불러오는 도중 오류가 발생했습니다.");
            return "error/500"; // 예외 시 에러 페이지
        }
    }


    @ResponseBody
    @RequestMapping("/insert")
    public void insert(MultipartFile[] files, ApprovalInsertDTO dto, HttpSession session, Model model) {
        System.out.println("Approver ID 리스트: " + dto.getApproverId());
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
        dto.setEmployeeId(employee.getId());

        approvalService.insert(files, dto);
    }

    @RequestMapping("/update")
    public void update(ApprovalDTO dto, Model model) {
        // TODO: 전자 결재 수정
    }

    @RequestMapping("/delete/{id}")
    public void deleteById(@PathVariable String id, Model model) {
        // TODO: 해당 id의 결재를 삭제
    }

    @RequestMapping("/temp/insert")
    public void insertTemp(TempApprovalDTO dto, Model model) {
        // TODO: 전자 결재 임시 저장
    }

    @RequestMapping("temp/update")
    public void updateTemp(TempApprovalDTO dto, Model model) {
        // TODO: 임시 저장된 전자 결재 수정
    }

    @RequestMapping("/temp/delete/{id}")
    public void deleteTemp(Model model, @PathVariable int id) {
        // TODO: 임지 저장 전자 결재 삭제
    }

    @RequestMapping("/submit/{id}")
    public void submit(@PathVariable String id, String result) {
        //  TODO: 해당 id의 문서를 승인/반려
    }
}
