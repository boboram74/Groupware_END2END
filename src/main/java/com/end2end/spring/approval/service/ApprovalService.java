package com.end2end.spring.approval.service;

import com.end2end.spring.approval.dto.*;
import org.springframework.web.multipart.MultipartFile;


import java.util.List;
import java.util.Map;

public interface ApprovalService {
    List<ApprovalDTO> myList(String state);
    List<Map<String, Object>> search(String state, String employeeId, String keyword);
    List<Map<String, Object>> selectApproversList(String approvalId);
    Map<String, Object> selectById(String id);
    List<ApproverDTO> nextId(String approvalId);
    List<Map<String, Object>> selectByState(String state, String employeeId);
    ApprovalFormDTO selectByFormId(int id);
    void insert(MultipartFile[] files, ApprovalInsertDTO dto) throws Exception;
    void approve(String approvalId, int approverId);
    void rejectApproval(ApprovalRejectDTO rejectDTO);
    List<Map<String, Object>> searchDetail(Map<String, Object> paramMap);
    String getDepartmentNameByEmployeeId(String employeeId);
    Map<String, List<Map<String, Object>>> allApprovals();
    Map<String, List<Map<String, Object>>> SearchallApprovals(String keyword);
    void insertImportant(CheckImportantDTO dto);
    List<Map<String, Object>> importantlist(String employeeId);
    void removeImportant(CheckImportantDTO dto);
    List<Map<String, Object>> selectRecent(String  state, String employeeId);
}
