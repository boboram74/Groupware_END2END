package com.end2end.spring.works.service;

import com.end2end.spring.approval.dto.ApprovalCategoryDTO;

import java.util.List;

public interface ApprovalCategoryService {
    List<ApprovalCategoryDTO> selectAll();
    ApprovalCategoryDTO selectById(int id);
    void insert(ApprovalCategoryDTO approvalCategoryDTO);
    void update(ApprovalCategoryDTO approvalCategoryDTO);
    void deleteById(int id);
}
