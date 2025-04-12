package com.end2end.spring.works.service;

import com.end2end.spring.works.dto.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface ProjectWorkService {
    List<ProjectWorkDTO> selectAll(int id);
    void insert(MultipartFile[] files, ProjectWorkDTO dto) throws Exception;
    void update(WorkUpdateDTO dto);
    void deleteById(int workId);
    void toggleState(int id);
    String selectByProjectIdAndEmployeeId(int projectId, String employeeId);
    void updateState(String state, int workItemId);
    ProjectWorkDTO selectByworksId(int id);
}
