package com.end2end.spring.approval.controller;

import com.end2end.spring.approval.dto.*;
import com.end2end.spring.approval.service.ApprovalFormService;
import com.end2end.spring.commute.dto.VacationDTO;
import com.end2end.spring.commute.service.VacationService;
import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.file.dao.FileDAO;
import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.approval.service.ApprovalService;
import com.end2end.spring.file.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RequestMapping("/approval")
@Controller
public class ApprovalController {

    @Autowired
    public ApprovalService approvalService;

    @Autowired
    private ApprovalFormService approvalFormService;

    @Autowired
    private VacationService vacationService;
    @Autowired private FileService fileService;

    @RequestMapping("/list")
    public String toList(HttpServletRequest request,HttpSession session, Model model) {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
        String employeeId = employee.getId();
        String scpage = request.getParameter("cpage");
        int cpage = (scpage == null) ? 1 : Integer.parseInt(scpage);

        String departmentName = approvalService.getDepartmentNameByEmployeeId(employeeId);
        boolean team = "경영팀".equals(departmentName);

        List<ApprovalFormDTO> formList = approvalFormService.selectFormList();
        List<Map<String, Object>> waitingList = approvalService.selectByState("ONGOING", employeeId);
        List<Map<String, Object>> goingList = approvalService.selectByState("ONGOING", employeeId);
        List<Map<String, Object>> rejectList = approvalService.selectByState("REJECT", employeeId);
        List<Map<String, Object>> completedList = approvalService.selectByState("SUBMIT", employeeId);
        Map<String, List<Map<String, Object>>> approvalByState = approvalService.allApprovals();

        List<Map<String, Object>> importantList = approvalService.importantlist(employeeId);

        int totalSize = 0;
        for (List<Map<String, Object>> approvalList : approvalByState.values()) {
            totalSize += approvalList.size();
        }

        model.addAttribute("waitingList", waitingList);
        model.addAttribute("goingList", goingList);
        model.addAttribute("completedList", completedList);
        model.addAttribute("rejectList", rejectList);
        model.addAttribute("formList", formList);
        model.addAttribute("team", team);
        model.addAttribute("cpage", cpage);
        model.addAttribute("importantSize", importantList.size());
        model.addAttribute("totalSize", totalSize);

        return "approval/approval-test";
    }

    @RequestMapping("/all")
    public String allList(HttpSession session,Model model) {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
        String employeeId = employee.getId();

        Map<String, List<Map<String, Object>>> approvalByState = approvalService.allApprovals();
        List<ApprovalFormDTO> formList = approvalFormService.selectFormList();

        int totalSize = 0;
        for (List<Map<String, Object>> approvalList : approvalByState.values()) {
            totalSize += approvalList.size();
        }
        System.out.println("totalSize: " + totalSize);
        String userRole = employee.getDepartmentName();
        boolean isAdmin = "경영팀".equals(userRole);
        String departmentName = approvalService.getDepartmentNameByEmployeeId(employeeId);
        boolean team = "경영팀".equals(departmentName) || isAdmin;

        List<Map<String, Object>> importantList = approvalService.importantlist(employeeId);

        model.addAttribute("waitingList", approvalByState.get("WAITING"));
        model.addAttribute("goingList", approvalByState.get("ONGOING"));
        model.addAttribute("completedList", approvalByState.get("SUBMIT"));
        model.addAttribute("rejectList", approvalByState.get("REJECT"));
        model.addAttribute("formList", formList);
        model.addAttribute("isAll", true);
        model.addAttribute("team", team);
        model.addAttribute("importantSize", importantList.size());
        model.addAttribute("totalSize", totalSize);

        return "approval/approval-test";
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

    @RequestMapping("/write/{id}")
    public String toWrite2(HttpSession session, @PathVariable int id, Model model) {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");

        model.addAttribute("dto", approvalFormService.selectByFormId(id));
        model.addAttribute("formId", id);
        model.addAttribute("employee", employee);

        double totalVacationDate = vacationService.sumTotalVacationDates(employee.getId());
        boolean isAbleHalf = totalVacationDate >= 0.5;

        model.addAttribute("totalVacationDate", (int) vacationService.sumTotalVacationDates(employee.getId()));
        model.addAttribute("isAbleHalf", isAbleHalf);

        return "approval/write";
    }

    @RequestMapping("/detail/{id}")
    public String toDetail(Model model, @PathVariable String id, HttpSession session) {
        try {
            EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
            String employeeId = employee.getId();

            String userRole = employee.getDepartmentName();

            boolean isAdmin = "경영팀".equals(userRole);

            String departmentName = approvalService.getDepartmentNameByEmployeeId(employeeId);
            boolean team = "경영팀".equals(departmentName) || isAdmin;
            FileDTO fileDTO = FileDTO.builder()
                    .approvalId(id)
                    .build();
            model.addAttribute("fileList", fileService.selectByParentsId(fileDTO));

            if (employee == null) {
                return "redirect:/login";
            }
            Map<String, Object> approval = approvalService.selectById(id);
            if (approval == null) {
                model.addAttribute("error", "존재하지 않는 문서입니다.");
                return "error/404";
            }
            String formName = (String) approval.get("FORMNAME");
            ApprovalFormDTO approvalFormDTO = approvalFormService.selectByFormName(formName);
            List<ApproverDTO> nextId = approvalService.nextId(id);
            List<Map<String, Object>> approvers = approvalService.selectApproversList(id);

            if ("휴가계".equals(approval.get("FORMNAME"))) {
                VacationDTO vacationDTO = vacationService.getVacationByApprovalId(id);
                model.addAttribute("vacationDTO", vacationDTO);
            }
            if(team) {
                model.addAttribute("approval", approval);
                model.addAttribute("nextId", nextId);
                model.addAttribute("approvers", approvers);
                model.addAttribute("employee", employee);
                model.addAttribute("approvalFormDTO", approvalFormDTO);

                return "approval/detail";
            }


            model.addAttribute("approval", approval);
            model.addAttribute("nextId", nextId);
            model.addAttribute("approvers", approvers);
            model.addAttribute("employee", employee);
            model.addAttribute("approvalFormDTO", approvalFormDTO);
            return "approval/detail";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "문서를 불러오는 도중 오류가 발생했습니다.");
            return "error/500";
        }
    }

    @ResponseBody
    @RequestMapping("/insert")
    public void insert(MultipartFile[] files, ApprovalInsertDTO dto, HttpSession session, Model model) {
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

    @PostMapping("/submit/approve/{approvalId}")
    @ResponseBody
    public String approve(@PathVariable String approvalId, @RequestParam int approverId) {
        approvalService.approve(approvalId, approverId);
        return "success";
    }

    @PostMapping("/reject")
    @ResponseBody
    public String reject(@RequestBody ApprovalRejectDTO rejectDTO) {
        rejectDTO.setRegdate(new Timestamp(System.currentTimeMillis()));
        approvalService.rejectApproval(rejectDTO);
        return "success";
    }

    @RequestMapping("/search")
    public String search(HttpSession session, String keyword, Model model) {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
        String employeeId = employee.getId();
        String departmentName = approvalService.getDepartmentNameByEmployeeId(employeeId);
        boolean team = "경영팀".equals(departmentName);
        List<ApprovalFormDTO> formList = approvalFormService.selectFormList();

        List<Map<String, Object>> waitingList;
        List<Map<String, Object>> goingList;
        List<Map<String, Object>> rejectList;
        List<Map<String, Object>> completedList;

        if (team) {
            Map<String, List<Map<String, Object>>> approvalByState = approvalService.SearchallApprovals(keyword);
            waitingList = approvalByState.get("ONGOING");
            goingList = approvalByState.get("ONGOING");
            rejectList = approvalByState.get("REJECT");
            completedList = approvalByState.get("SUBMIT");
        } else {
            waitingList = approvalService.search("ONGOING", employeeId, keyword);
            goingList = approvalService.search("ONGOING", employeeId, keyword);
            rejectList = approvalService.search("REJECT", employeeId, keyword);
            completedList = approvalService.search("SUBMIT", employeeId, keyword);
        }

        Map<String, List<Map<String, Object>>> approvalByState = approvalService.allApprovals();
        int totalSize = 0;
        for (List<Map<String, Object>> approvalList : approvalByState.values()) {
            totalSize += approvalList.size();
        }

        List<Map<String, Object>> importantList = approvalService.importantlist(employeeId);

        model.addAttribute("waitingList", waitingList);
        model.addAttribute("goingList", goingList);
        model.addAttribute("completedList", completedList);
        model.addAttribute("rejectList", rejectList);
        model.addAttribute("keyword", keyword);
        model.addAttribute("formList", formList);
        model.addAttribute("team", team);
        model.addAttribute("importantSize", importantList.size());
        model.addAttribute("totalSize", totalSize);

        return "approval/approval-test";
    }

    @GetMapping("/searchDetail")
    public String searchDetail(@RequestParam Map<String, Object> searchParams, HttpSession session, Model model) {

        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
        if (employee == null) {
            return "redirect:/login";
        }
        String employeeId = employee.getId();

        searchParams.put("employeeId", employeeId);

        List<Map<String, Object>> approvalList = approvalService.searchDetail(searchParams);

        List<Map<String, Object>> waitingList = new ArrayList<>();
        List<Map<String, Object>> goingList = new ArrayList<>();
        List<Map<String, Object>> completedList = new ArrayList<>();
        List<Map<String, Object>> rejectList = new ArrayList<>();

        for (Map<String, Object> approval : approvalList) {
            String STATE = (String) approval.get("STATE");
            if ("WAITING".equals(STATE)) {
                waitingList.add(approval);
            } else if ("ONGOING".equals(STATE)) {
                goingList.add(approval);
            } else if ("SUBMIT".equals(STATE)) {
                completedList.add(approval);
            } else if ("REJECT".equals(STATE)) {
                rejectList.add(approval);
            }
        }
        model.addAttribute("waitingList", waitingList);
        model.addAttribute("goingList", goingList);
        model.addAttribute("completedList", completedList);
        model.addAttribute("rejectList", rejectList);
        model.addAttribute("searchParams", searchParams);

        return "approval/approval-test";
    }

    @PostMapping("/insertImportant")
    @ResponseBody
    public void insertImportant(@RequestBody CheckImportantDTO dto, HttpSession session) {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");

        if (employee != null) {
            dto.setEmployeeId(employee.getId());
        }

        approvalService.insertImportant(dto);
    }
    @GetMapping("/important")
    public String listImportant(HttpSession session, Model model) {
        EmployeeDTO employeeDTO = (EmployeeDTO) session.getAttribute("employee");
        String employeeId = employeeDTO.getId();

        String departmentName = approvalService.getDepartmentNameByEmployeeId(employeeId);
        boolean team = "경영팀".equals(departmentName);

        List<Map<String, Object>> importantList = approvalService.importantlist(employeeId);
        Map<String, List<Map<String, Object>>> approvalByState = approvalService.allApprovals();
        System.out.println("approvalByState.size :"+approvalByState.size());
        List<Map<String, Object>> waitingList = new ArrayList<>();
        List<Map<String, Object>> goingList = new ArrayList<>();
        List<Map<String, Object>> completedList = new ArrayList<>();
        List<Map<String, Object>> rejectList = new ArrayList<>();

        for (Map<String, Object> approval : importantList) {
            String state = (String) approval.get("STATE");
            if ("WAITING".equals(state)) {
                waitingList.add(approval);
            } else if ("ONGOING".equals(state)) {
                goingList.add(approval);
            } else if ("SUBMIT".equals(state)) {
                completedList.add(approval);
            } else if ("REJECT".equals(state)) {
                rejectList.add(approval);
            }
        }


        int totalSize = 0;
        for (List<Map<String, Object>> approvalList : approvalByState.values()) {
            totalSize += approvalList.size();
        }

        List<ApprovalFormDTO> formList = approvalFormService.selectFormList();
        model.addAttribute("waitingList", waitingList);
        model.addAttribute("goingList", goingList);
        model.addAttribute("completedList", completedList);
        model.addAttribute("rejectList", rejectList);
        model.addAttribute("team", team);
        model.addAttribute("formList", formList);
        model.addAttribute("importantSize", importantList.size());
        model.addAttribute("totalSize",totalSize);

        return "/approval/important";
    }

    @PostMapping("/removeImportant")
    @ResponseBody
    public String removeImportant(@RequestBody Map<String, String> requestData, HttpSession session) {
        try {
            String approvalId = requestData.get("approvalId");
            EmployeeDTO employeeDTO = (EmployeeDTO) session.getAttribute("employee");
            String employeeId = employeeDTO.getId();
            String leaderCheckYn = requestData.get("leaderCheckYn");
            CheckImportantDTO dto = new CheckImportantDTO();
            dto.setApprovalId(approvalId);
            dto.setEmployeeId(employeeId);
            dto.setLeaderCheckYn(leaderCheckYn);
            approvalService.removeImportant(dto);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "failure";
        }
    }
}
