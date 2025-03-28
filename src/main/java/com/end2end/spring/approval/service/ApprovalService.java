package com.end2end.spring.approval.service;

import com.end2end.spring.approval.dto.ApprovalDTO;

import java.util.List;

public interface ApprovalService {
    List<ApprovalDTO> selectAll();
    List<ApprovalDTO> selectByEmployeeId(String employeeId);
    List<ApprovalDTO> search();
    List<ApprovalDTO> selectByState(String state);
    ApprovalDTO selectById(String id);
    void insert(ApprovalDTO dto);
    void update(ApprovalDTO dto);
    void deleteById(String id);
    void submit();
}
