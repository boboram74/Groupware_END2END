package com.end2end.spring.works.service;
import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.works.dto.ProjectDTO;
import com.end2end.spring.works.dto.ProjectInsertDTO;
import com.end2end.spring.works.dto.ProjectUserDTO;


import java.util.List;
import java.util.Map;

public interface ProjectService {

    List<ProjectDTO> selectAll();
//    Map<String, Integer> getProjectStatistics();
    ProjectDTO selectById(int id);
    void insert(ProjectInsertDTO dto);
    void deleteById(int id);
    void update(ProjectDTO dto);
    List<ProjectDTO> selectByName(String name);//프로젝트 찾는 메서드
    List<EmployeeDTO> selectByUser(String name);

}
