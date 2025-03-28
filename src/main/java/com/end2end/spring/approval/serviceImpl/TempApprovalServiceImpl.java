package com.end2end.spring.approval.serviceImpl;

import com.end2end.spring.approval.dto.TempApprovalDTO;
import com.end2end.spring.approval.service.TempApprovalService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TempApprovalServiceImpl implements TempApprovalService {
    @Override
    public List<TempApprovalDTO> selectByEmployeeId(String employeeId) {
        // TODO: 해당 직원 id의 임시 저장 결재 문서를 출력
        return null;
    }

    @Override
    public TempApprovalDTO selectById(int id) {
        // TODO: 해당 id의 임시 저장 결재 문서 출력
        return null;
    }

    @Override
    public void insert(TempApprovalDTO dto) {
        // TODO: 결재 임시 저장
    }

    @Override
    public void update(TempApprovalDTO dto) {
        // TODO: 결재 임시 저장 문서 수정
    }

    @Override
    public void deleteById(int id) {
        // TODO: 해당 결재 임시 저장 문서 삭제
    }
}
