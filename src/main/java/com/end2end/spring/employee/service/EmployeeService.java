package com.end2end.spring.employee.service;

import com.end2end.spring.employee.dto.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface EmployeeService {
    EmployeeDTO selectById(String id);
    List<EmployeeDTO> selectAll();
    EmployeeDetailDTO selectDetailById(String id);
    EmployeeDTO login(LoginDTO dto);
    void logout();
    void insert(EmployeeDetailDTO dto, MultipartFile file);
    void roleUpdate(String id);
    void update(EmployeeDetailDTO dto);
    void deleteById(String id);
    boolean idVali(String loginId);
    List<EmployeeDTO> selectByDepartmentId(int departmentId);
    List<DepartmentDTO> selectAllDepartment();
    List<JobDTO> selectAllJob();
    boolean isNoAuthExist();
    List<EmployeeDTO> selectByThisMonthBirthday();
}
