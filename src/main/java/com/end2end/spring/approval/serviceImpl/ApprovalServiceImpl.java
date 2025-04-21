package com.end2end.spring.approval.serviceImpl;

import com.end2end.spring.alarm.AlarmService;
import com.end2end.spring.approval.dao.ApprovalDAO;
import com.end2end.spring.approval.dao.ApprovalRejectDAO;
import com.end2end.spring.approval.dao.ApproverDAO;
import com.end2end.spring.approval.dto.*;
import com.end2end.spring.approval.service.ApprovalService;
import com.end2end.spring.commute.dao.ExtendedCommuteDAO;
import com.end2end.spring.commute.dto.ExtendedCommuteDTO;
import com.end2end.spring.commute.dto.VacationDTO;
import com.end2end.spring.commute.service.CommuteService;
import com.end2end.spring.commute.service.VacationService;
import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Timestamp;
import java.util.*;

@Service
public class ApprovalServiceImpl implements ApprovalService {
    @Autowired private ApprovalDAO approvalDAO;
    @Autowired private ApproverDAO approverDAO;
    @Autowired private ApprovalRejectDAO approvalRejectDAO;
    @Autowired private ExtendedCommuteDAO extendedCommuteDAO;
    @Autowired private FileService fileService;
    @Autowired private VacationService vacationService;
    @Autowired private CommuteService commuteService;
    @Autowired private AlarmService alarmService;

    @Override
    public List<ApprovalDTO> myList(String state) {
        return approvalDAO.toList(state);
    }

    @Override
    public List<Map<String, Object>> search(String state, String employeeId, String keyword) {
        return approvalDAO.search(state, employeeId, keyword);
    }

    @Override
    public List<Map<String, Object>> selectByState(String state, String employeeId) {
        return approvalDAO.selectByState(state, employeeId);
    }

    @Override
    public Map<String, Object> selectById(String id) {
        return approvalDAO.selectById(id);
    }

    @Override
    public List<ApproverDTO> nextId(String approvalId) {
        return approverDAO.nextId(approvalId);
    }

    @Override
    public ApprovalFormDTO selectByFormId(int id) {
        return approvalDAO.selectByFormId(id);
    }

    @Transactional
    @Override
    public void insert(MultipartFile[] files, ApprovalInsertDTO dto) throws Exception {
        ApprovalFormDTO formDTO = approvalDAO.selectByFormId(dto.getApprovalFormId());

        ApprovalDTO approvalDTO = ApprovalDTO.builder()
                .employeeId(dto.getEmployeeId())
                .approvalFormId(dto.getApprovalFormId())
                .prefixes(formDTO.getPrefixes())
                .title(dto.getTitle())
                .content(dto.getContent())
                .build();

        approvalDAO.insert(approvalDTO);

        FileDTO fileDTO = FileDTO.builder()
                .approvalId(approvalDTO.getId())
                .build();
        fileService.insert(files, fileDTO);

        String formName = formDTO.getName();
        boolean isSubmit = formName.contains("연장");

        if (formDTO.getName().contains("휴가")) {  // 휴가 문서라면 휴가 추가
            VacationDTO vacationDTO = VacationDTO.builder()
                    .approvalId(approvalDTO.getId())
                    .employeeId(dto.getEmployeeId())
                    .vacationDate(dto.getVacationDate())
                    .reason("연차")
                    .startDate(Timestamp.valueOf(dto.getStartDate()))
                    .type(dto.getVacationType())
                    .build();
            vacationService.insert(vacationDTO);
        } else if (formDTO.getName().contains("연장")) {  // 연장 근무라면 연장 근무 추가
            ExtendedCommuteDTO extendedCommuteDTO = ExtendedCommuteDTO.builder()
                    .approvalId(approvalDTO.getId())
                    .employeeId(dto.getEmployeeId())
                    .workOffTime(Timestamp.valueOf(dto.getWorkDate() + " " + dto.getEndTime() + ":00"))
                    .build();
            extendedCommuteDAO.insert(extendedCommuteDTO);
        }

        int order = 0;
        ApproverDTO writer = ApproverDTO.builder()
                .approvalId(approvalDTO.getId())
                .employeeId(dto.getEmployeeId())
                .orders(order++)
                .submitYn("Y")
                .build();
        approverDAO.insertApprover(writer);

        Set<String> added = new HashSet<>();
        added.add(dto.getEmployeeId());

        for (String approverId : dto.getApproverId()) {
            if (added.contains(approverId)) {
                continue;
            }

            ApproverDTO approverDTO = ApproverDTO.builder()
                    .approvalId(approvalDTO.getId())
                    .employeeId(approverId)
                    .orders(order)
                    .build();
            approverDAO.insertApprover(approverDTO);
            added.add(approverId);

            if(order == 1) {
                alarmService.sendApproveCheckAlarm("/approval/detail/" + approvalDTO.getId(), approverId);
            }
            order++;
        }
    }

    @Transactional
    @Override
    public void approve(String approvalId, int approverId) {
        approverDAO.updateSubmitYn(approverId, "Y", new Timestamp(System.currentTimeMillis()));

        List<ApproverDTO> nextApprovers = approverDAO.nextId(approvalId);

        if (nextApprovers == null || nextApprovers.isEmpty()) {
            approvalDAO.updateState(approvalId, "SUBMIT");

            ApprovalDTO approvalDTO = approvalDAO.selectDTOById(approvalId);
            if (approvalDAO.selectByFormId(approvalDTO.getApprovalFormId()).getName().contains("연장 근무")) {
                ExtendedCommuteDTO extendedCommuteDTO = extendedCommuteDAO.selectByApprovalId(approvalId);

                if (extendedCommuteDTO.getCommuteId() != 0) {
                    commuteService.update(extendedCommuteDTO);
                }
            }

            alarmService.sendApprovalResultAlarm("/approval/detail/" + approvalId, approvalId);
        } else {
            approvalDAO.updateState(approvalId, "ONGOING");

            String approver = nextApprovers.get(0).getEmployeeId();
            alarmService.sendApproveCheckAlarm("/approval/detail/" + approvalId, approver);
        }

    }

    @Transactional
    @Override
    public void rejectApproval(ApprovalRejectDTO rejectDTO) {
        approvalRejectDAO.insertReject(rejectDTO);
        approverDAO.updateSubmitYn(rejectDTO.getApproverId(), "N", new Timestamp(System.currentTimeMillis()));
        approvalDAO.updateState(rejectDTO.getApprovalId(), "REJECT");

        alarmService.sendApprovalResultAlarm("/approval/detail/" + rejectDTO.getApprovalId(), rejectDTO.getApprovalId());
    }

    @Override
    public List<Map<String, Object>> selectApproversList(String approvalId) {
        return approverDAO.selectApproversList(approvalId);
    }

    @Transactional
    @Override
    public List<Map<String, Object>> searchDetail(Map<String, Object> paramMap) {
        return approvalDAO.searchDetail(paramMap);
    }
    @Override
    public String getDepartmentNameByEmployeeId(String employeeId) {
        return approvalDAO.selectDepartmentNameById(employeeId);
    }
    @Override
    public Map<String, List<Map<String, Object>>> allApprovals() {
        List<Map<String, Object>> allApprovals = approvalDAO.allApprovals();
        Map<String, List<Map<String, Object>>> allApproval = new HashMap<>();

        allApproval.put("SUBMIT", new ArrayList<>());
        allApproval.put("ONGOING", new ArrayList<>());
        allApproval.put("REJECT", new ArrayList<>());

        for (Map<String, Object> approval : allApprovals) {
            String state = (String) approval.get("STATE");
            if (allApproval.containsKey(state)) {
                allApproval.get(state).add(approval);
            }
        }

        return allApproval;
    }
    @Override
    public Map<String, List<Map<String, Object>>> SearchallApprovals(String keyword) {
        List<Map<String, Object>> allApprovals = approvalDAO.allApprovals();
        Map<String, List<Map<String, Object>>> allApproval = new HashMap<>();

        allApproval.put("SUBMIT", new ArrayList<>());
        allApproval.put("ONGOING", new ArrayList<>());
        allApproval.put("REJECT", new ArrayList<>());

        for (Map<String, Object> approval : allApprovals) {
            String state = (String) approval.get("STATE");
            if (allApproval.containsKey(state)) {
                allApproval.get(state).add(approval);
            }
        }

        return allApproval;
    }

    @Override
    public void insertImportant(CheckImportantDTO dto){
        CheckImportantDTO importantDTO = CheckImportantDTO.builder()
                .approvalId(dto.getApprovalId())
                .employeeId(dto.getEmployeeId())
                .leaderCheckYn(dto.getLeaderCheckYn())
                .build();
        approvalDAO.insertImportant(dto);
    }

    @Override
    public List<Map<String, Object>> importantlist(String employeeId) {
        return approvalDAO.importantlist(employeeId);
    }

    @Override
    public void removeImportant(CheckImportantDTO dto){
        if ("N".equals(dto.getLeaderCheckYn())) {
         approvalDAO.removeImportant(dto);
        }
    }

    @Override
    public List<Map<String, Object>> selectRecent(String state, String employeeId) {
        int start = 1;
        int end = Math.min(8, approvalDAO.selectByState(state, employeeId).size());

        return approvalDAO.selectByStateFromTO(state, employeeId, start, end);
    }

    @Override
    public ApprovalRejectDTO rejectInfo(String approvalId) {
        return  approvalDAO.rejectInfo(approvalId);
    }
}
