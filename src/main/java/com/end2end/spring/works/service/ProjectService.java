package com.end2end.spring.works.service;
import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.works.dao.ProjectDAO;
import com.end2end.spring.works.dto.ProjectDTO;
import com.end2end.spring.works.dto.ProjectUserDTO;


import java.util.List;

public interface ProjectService {

    List<ProjectDTO> selectAll();
 List<ProjectDTO> selectByEmployeeId(String employeeId);
 void insert(ProjectDTO dto, ProjectUserDTO udto);

}
