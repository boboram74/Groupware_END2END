package com.end2end.spring.approval.service;

import com.end2end.spring.approval.dto.ApprovalDTO;
import com.end2end.spring.approval.dto.ApprovalInsertDTO;
import org.springframework.web.multipart.MultipartFile;


import java.util.List;
import java.util.Map;

public interface ApprovalService {
    List<ApprovalDTO> selectAll();


    List<ApprovalDTO> selectAll(String state);

    List<ApprovalDTO> selectByEmployeeId(String employeeId);
     List<ApprovalDTO> myList(String state);
    List<ApprovalDTO> search();
    List<ApprovalDTO> search(String employeeId);
    List<ApprovalDTO> selectByState(String state);
//    List<ApprovalDTO> selectByState(String state, String employeeId);
    ApprovalDTO selectById(String id);

    List<String> nextId(String approvalId);
    List<Map<String, Object>> selectByState(String state, String employeeId);
    void insert(MultipartFile[] files, ApprovalInsertDTO dto);

    void update(ApprovalDTO dto);
    void deleteById(String id);
    void submit(boolean isSubmit);
}
