package com.end2end.spring.works.service;

import com.end2end.spring.approval.dto.TempApprovalDTO;

import java.util.List;

public interface TempApprovalService {
    List<TempApprovalDTO> selectByEmployeeId(String employeeId);
    TempApprovalDTO selectById(int id);
    void insert(TempApprovalDTO dto);
    void update(TempApprovalDTO dto);
    void deleteById(int id);
}
