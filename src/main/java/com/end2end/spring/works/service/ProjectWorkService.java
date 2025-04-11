package com.end2end.spring.works.service;

import com.end2end.spring.works.dto.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface ProjectWorkService {
    List<ProjectWorkDTO> selectAll();
    void insert(MultipartFile[] files, ProjectWorkDTO dto) throws Exception;
    void update(ProjectWorkDTO dto);
    void deleteById(int id);
    void toggleState(int id);
    String selectByProjectIdAndEmployeeId(int projectId, String employeeId);

    ProjectWorkDTO selectByworksId(int id);
}
