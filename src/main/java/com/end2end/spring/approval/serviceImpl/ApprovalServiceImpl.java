package com.end2end.spring.approval.serviceImpl;

import com.end2end.spring.approval.dao.ApprovalDAO;
import com.end2end.spring.approval.dao.ApprovalRejectDAO;
import com.end2end.spring.approval.dao.ApproverDAO;
import com.end2end.spring.approval.dto.ApprovalDTO;
import com.end2end.spring.approval.dto.ApprovalInsertDTO;
import com.end2end.spring.approval.dto.ApprovalRejectDTO;
import com.end2end.spring.approval.dto.ApproverDTO;
import com.end2end.spring.approval.service.ApprovalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class ApprovalServiceImpl implements ApprovalService {
    @Autowired
    private ApprovalDAO approvalDAO;

    @Autowired
    private ApproverDAO approverDAO;

    @Autowired
    private ApprovalRejectDAO approvalRejectDAO;

    @Override
    public List<ApprovalDTO> myList(String state) {

        return approvalDAO.toList(state);
    }


    @Override
    public List<ApprovalDTO> selectAll() {
        return null;
    }

    @Override
    public List<ApprovalDTO> selectAll(String state) {
        return null;
    }

    @Override
    public List<ApprovalDTO> selectByEmployeeId(String employeeId) {
        // TODO: 해당 id의 직원의 결재 리스트 출력
        return null;
    }

    @Override
    public List<ApprovalDTO> search() {
        // TODO: 검색 결과 내용의 결재 리스트 출력
        return null;
    }

    @Override
    public List<ApprovalDTO> search(String employeeId) {
        // TODO: 해당 id의 사원이 볼 수 있는 검색 결과 내용의 결재 리스트 출력
        return null;
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

    @Transactional
    @Override
    public void insert(MultipartFile[] files, ApprovalInsertDTO dto) {

        ApprovalDTO approvalDTO = ApprovalDTO.builder()
                .employeeId(dto.getEmployeeId())
                .approvalFormId(dto.getApprovalFormId())
                .title(dto.getTitle())
                .content(dto.getContent())
                .build();

        approvalDAO.insert(approvalDTO);

        int order = 0;
        ApproverDTO writer = ApproverDTO.builder()
                .approvalId(approvalDTO.getId())
                .employeeId(dto.getEmployeeId())
                .orders(order++)
                .submitYn("Y")
                .submitDate(new Timestamp(System.currentTimeMillis()))
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
                    .orders(order++)
                    .build();
            approverDAO.insertApprover(approverDTO);
            added.add(approverId);
        }
    }

    @Transactional
    @Override
    public void approve(String approvalId, int approverId) {
        approverDAO.updateSubmitYn(approverId, "Y", new Timestamp(System.currentTimeMillis()));

        List<ApproverDTO> nextApprovers = approverDAO.nextId(approvalId);

        if (nextApprovers == null || nextApprovers.isEmpty()) {
            approvalDAO.updateState(approvalId, "SUBMIT");
        } else {
            approvalDAO.updateState(approvalId, "ONGOING");
        }

    }

    @Transactional
    @Override
    public void rejectApproval(ApprovalRejectDTO rejectDTO) {

        approvalRejectDAO.insertReject(rejectDTO);

        approverDAO.updateSubmitYn(rejectDTO.getApproverId(), "N", new Timestamp(System.currentTimeMillis()));

        approvalDAO.updateState(rejectDTO.getApprovalId(), "REJECT");
    }

    @Override
    public void update(ApprovalDTO dto) {
        // TODO: 결재 수정
    }

    @Override
    public void deleteById(String id) {
        // TODO: 해당 id의 결재 삭제
    }

    @Override
    public void submit(boolean isSubmit) {
        // TODO: 들어온 값에 따라 결재 승인/반려
    }

    @Override
    public List<Map<String, Object>> selectApproversList(String approvalId) {
        return approverDAO.selectApproversList(approvalId);
    }
}
