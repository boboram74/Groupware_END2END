package com.end2end.spring.approval.service;

import com.end2end.spring.approval.dto.ApprovalFormDTO;

import java.util.List;

public interface ApprovalFormService {
    List<ApprovalFormDTO> selectAll();
    List<ApprovalFormDTO> selectByEmployeeId(String employeeId);
    List<ApprovalFormDTO> selectByCategoryId(int categoryId);

    ApprovalFormDTO selectByFormId(int id);

    List<ApprovalFormDTO> selectFormList();

    void insert(ApprovalFormDTO approvalFormDTO);
    void update(ApprovalFormDTO approvalFormDTO);
    void deleteById(int id);
    void insertFrequency(int formId, String employeeId);
    void deleteFrequencyById(int id);
}
