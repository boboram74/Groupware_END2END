package com.end2end.spring.works.service;

import com.end2end.spring.works.dto.*;

import java.util.List;

public interface ProjectWorkService {
    List<ProjectWorkDTO> selectAll();
    List<ProjectWorkDTO> selectByEmployeeId(String employeeId);
    void insert(ProjectWorkDTO dto);
    void update(ProjectWorkDTO dto);
    void deleteById(int id);
    void toggleState(int id);
}
