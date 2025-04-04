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

import java.util.List;

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
    public List<ApprovalDTO> selectByState(String state) {
        // TODO: 결재 상태(진행중, 완료)으로 결재 리스트 출력
        return null;
    }

    @Override
    public List<ApprovalDTO> selectByState(String state, String employeeId) {
        // TODO: 해당 id의 사원이 볼 수 있는 결재 상태(진행중, 완료)으로 결재 리스트 출력
        return approvalDAO.selectByStateAndEmployeeId(state, employeeId);
    }

    @Override
    public ApprovalDTO selectById(String id) {
        // TODO: 해당 id의 결재를 출력
        return null;
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

        int order = 1;
        for (String approverId : dto.getApproverId()) {
            ApproverDTO approverDTO = ApproverDTO.builder()
                    .approvalId(approvalDTO.getId())
                    .employeeId(approverId)
                    .orders(order)
                    .build();

            approverDAO.insertApprover(approverDTO);
            order++;
        }
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
}
