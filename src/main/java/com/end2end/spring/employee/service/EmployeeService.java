package com.end2end.spring.employee.service;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.employee.dto.EmployeeDetailDTO;
import com.end2end.spring.employee.dto.LoginDTO;

public interface EmployeeService {
    EmployeeDTO selectById(String id);
    EmployeeDetailDTO selectDetailById(String id);
    void login(LoginDTO dto);
    void logout();
}
