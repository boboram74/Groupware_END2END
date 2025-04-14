package com.end2end.spring.main.service;

import com.end2end.spring.main.dto.LoginHistoryDTO;

import java.util.List;

public interface LoginHistoryService {
    List<LoginHistoryDTO> selectByEmployeeId(String employeeId);
    List<LoginHistoryDTO> selectByEmployeeId(String employeeId, int page);
    void insert(LoginHistoryDTO dto);
}
