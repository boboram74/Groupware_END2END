package com.end2end.spring.employee.service;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.employee.dto.EmployeeDetailDTO;
import com.end2end.spring.employee.dto.LoginDTO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface EmployeeService {
    EmployeeDTO selectById(String id);
    EmployeeDetailDTO selectDetailById(String id);
    void login(LoginDTO dto);
    void logout();
    void insert(EmployeeDetailDTO dto, MultipartFile file);
    void update(EmployeeDetailDTO dto);
    void deleteById(String id);
    List<EmployeeDTO> selectByDepartmentId(int departmentId);
}
