package com.end2end.spring.approval.serviceImpl;

import com.end2end.spring.approval.dto.ApprovalDTO;
import com.end2end.spring.approval.service.ApprovalService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ApprovalServiceImpl implements ApprovalService {
    @Override
    public List<ApprovalDTO> selectAll() {
        // TODO: 모든 결재 리스트 출력
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
        return null;
    }

    @Override
    public ApprovalDTO selectById(String id) {
        // TODO: 해당 id의 결재를 출력
        return null;
    }

    @Override
    public void insert(ApprovalDTO dto) {
        // TODO: 결재 등록
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
