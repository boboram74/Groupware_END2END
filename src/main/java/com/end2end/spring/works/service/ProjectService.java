package com.end2end.spring.works.service;
import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.works.dao.ProjectDAO;
import com.end2end.spring.works.dto.ProjectDTO;


import java.util.List;

public interface ProjectService {

    List<ProjectDTO> selectAll();
 List<ProjectDTO> selectByEmployeeId(String employeeId);
 void insert(String name, List<String> employeeId, EmployeeDTO employeeDTO);

}
