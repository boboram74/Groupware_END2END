package com.end2end.spring.approval.serviceImpl;

import com.end2end.spring.approval.dto.ApprovalCategoryDTO;
import com.end2end.spring.approval.service.ApprovalCategoryService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ApprovalCategoryServiceImpl implements ApprovalCategoryService {
    @Override
    public List<ApprovalCategoryDTO> selectAll() {
        // TODO: 모든 결재 카테고리 추가
        return null;
    }

    @Override
    public ApprovalCategoryDTO selectById(int id) {
        // TODO: 해당 id의 결재 카테고리 선택
        return null;
    }

    @Override
    public void insert(ApprovalCategoryDTO approvalCategoryDTO) {
        // TODO: 결재 카테고리 추가
    }

    @Override
    public void update(ApprovalCategoryDTO approvalCategoryDTO) {
        // TODO: 결재 카테고리 수정
    }

    @Override
    public void deleteById(int id) {
        // TODO: 해당 id의 결재 카테고리 삭제
    }
}
