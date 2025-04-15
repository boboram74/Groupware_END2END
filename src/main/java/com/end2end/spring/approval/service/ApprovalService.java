package com.end2end.spring.approval.service;

import com.end2end.spring.approval.dto.*;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;


import java.util.List;
import java.util.Map;

public interface ApprovalService {
    List<ApprovalDTO> selectAll();


    List<ApprovalDTO> selectAll(String state);

    List<ApprovalDTO> selectByEmployeeId(String employeeId);

    List<ApprovalDTO> myList(String state);

    public List<Map<String, Object>> search(String state, String employeeId, String keyword);

    List<ApprovalDTO> search(String employeeId);


    List<Map<String, Object>> selectApproversList(String approvalId);
    Map<String, Object> selectById(String id);

    List<ApproverDTO> nextId(String approvalId);

    List<Map<String, Object>> selectByState(String state, String employeeId);

    ApprovalFormDTO selectByFormId(int id);

    void insert(MultipartFile[] files, ApprovalInsertDTO dto);

    void update(ApprovalDTO dto);

    void deleteById(String id);
    void approve(String approvalId, int approverId);
    void rejectApproval(ApprovalRejectDTO rejectDTO);
    void submit(boolean isSubmit);

    @Transactional
    List<Map<String, Object>> searchDetail(Map<String, Object> paramMap);

    String getDepartmentNameByEmployeeId(String employeeId);

    Map<String, List<Map<String, Object>>> allApprovals();

    Map<String, List<Map<String, Object>>> SearchallApprovals(String keyword);


}
