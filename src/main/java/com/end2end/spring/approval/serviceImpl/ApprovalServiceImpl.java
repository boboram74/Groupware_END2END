package com.end2end.spring.approval.serviceImpl;

import com.end2end.spring.approval.dao.ApprovalDAO;
import com.end2end.spring.approval.dao.ApproverDAO;
import com.end2end.spring.approval.dto.ApprovalDTO;
import com.end2end.spring.approval.dto.ApprovalInsertDTO;
import com.end2end.spring.approval.dto.ApproverDTO;
import com.end2end.spring.approval.service.ApprovalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

@Service
public class ApprovalServiceImpl implements ApprovalService {
    @Autowired
    private ApprovalDAO approvalDAO;

    @Autowired
    private ApproverDAO approverDAO;

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
    public List<String> nextId(String approvalId) {
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

        ApproverDTO writer = ApproverDTO.builder()
                .approvalId(approvalDTO.getId())
                .employeeId(dto.getEmployeeId())
                .orders(0)
                .submitYn("Y")
                .submitDate(new Timestamp(System.currentTimeMillis()))
                .build();
        approverDAO.insertApprover(writer);

        int order = 0;
        for (String approverId : dto.getApproverId()) {
            ApproverDTO approverDTO = ApproverDTO.builder()
                    .approvalId(approvalDTO.getId())
                    .employeeId(approverId)
                    .orders(order++)
                    .build();
            approverDAO.insertApprover(approverDTO);
        }
    }

    @Transactional
    @Override
    public void approve(String approvalId, int approverId) {
        approverDAO.updateSubmitYn(approverId, "Y", new Timestamp(System.currentTimeMillis()));
        System.out.println("도착");
        List<String> nextApprovers = approverDAO.nextId(approvalId);
        System.out.println("도착2"+ " : " + nextApprovers+ " : " + approverId);
        if (nextApprovers == null || nextApprovers.isEmpty()) {
            approvalDAO.updateState(approvalId, "submit");
        } else {
            approvalDAO.updateState(approvalId, "진행중");
        }
        System.out.println("도착3");
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
