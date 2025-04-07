package com.end2end.spring.works.service;
import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.works.dao.ProjectDAO;
import com.end2end.spring.works.dto.ProjectDTO;
import com.end2end.spring.works.dto.ProjectUserDTO;


import java.util.List;
import java.util.Map;

public interface ProjectService {

    List<ProjectDTO> selectAll();
    Map<String, Integer> getProjectStatistics();
    List<ProjectDTO> selectByName(String name);
 void insert(ProjectDTO dto, ProjectUserDTO udto);

}
