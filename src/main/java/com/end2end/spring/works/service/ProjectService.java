package com.end2end.spring.works.service;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.works.dto.ProjectDTO;
import com.end2end.spring.works.dto.ProjectInsertDTO;
import com.end2end.spring.works.dto.ProjectSelectDTO;
import com.end2end.spring.works.dto.ProjectUserDTO;


import java.util.List;

public interface ProjectService {

    //    List<ProjectMainDTO> selectAll();
//    Map<String, Integer> getProjectStatistics();
    ProjectDTO selectById(int id);

    void insert(ProjectInsertDTO dto);

    void deleteById(int id);

    List<ProjectDTO> selectByName(String name);//프로젝트 찾는 메서드
    int hideById(int projectId,String hideYn);
    List<EmployeeDTO> selectByUser(String name);

    List<EmployeeDTO> getMembersByProjectId(int projectId);

    List<ProjectSelectDTO> selectAllProject();

    ProjectInsertDTO update(ProjectInsertDTO dto);

    void updateProjectUser(int projectId, List<String> employeeId);

    ProjectDTO findLatestProject();

    void updateProject(ProjectInsertDTO dto);

    ProjectDTO selectProjectDeadLine(int id);
    void endworks(int projectId);


//    List<ProjectSelectDTO> selectAllProject(int page);
}
