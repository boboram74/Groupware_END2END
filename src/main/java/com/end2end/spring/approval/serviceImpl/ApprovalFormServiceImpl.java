package com.end2end.spring.approval.serviceImpl;

import com.end2end.spring.approval.dto.ApprovalFormDTO;
import com.end2end.spring.approval.service.ApprovalFormService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ApprovalFormServiceImpl implements ApprovalFormService {
    @Override
    public List<ApprovalFormDTO> selectAll() {
        // TODO: 모든 결재 문서 양식 출력
        return null;
    }

    @Override
    public List<ApprovalFormDTO> selectByEmployeeId(String employeeId) {
        // TODO: 해당 직원의 자주 쓰는 결재 문서 양식 출력
        return null;
    }

    @Override
    public List<ApprovalFormDTO> selectByCategoryId(int categoryId) {
        // TODO: 해당 결재 카테고리에 해당하는 모든 결재 문서 양식 출력
        return null;
    }

    @Override
    public ApprovalFormDTO selectById(int id) {
        // TODO: 해당 id의 결재 문서 양식 출력
        return null;
    }

    @Override
    public void insert(ApprovalFormDTO approvalFormDTO) {
        // TODO: 결재 문서 양식 추가
    }

    @Override
    public void update(ApprovalFormDTO approvalFormDTO) {
        // TODO: 결재 문서 양식 수정
    }

    @Override
    public void deleteById(int id) {
        // TODO: 해당 id의 결재 문서 양식 삭제
    }

    @Override
    public void insertFrequency(int formId, String employeeId) {
        // TODO: 해당 employeeId의 사원의 formId의 자주 쓰는 문서 양식을 추가
    }

    @Override
    public void deleteFrequencyById(int id) {
        // TODO: 해당 id의 자주 쓰는 결재 문서 양식 삭제
    }
}
