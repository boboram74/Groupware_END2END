package com.end2end.spring.works.service;

import com.end2end.spring.works.dto.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface ProjectWorkService {
    List<ProjectWorkDTO> selectAll(int id);
    void insert(MultipartFile[] files, ProjectWorkDTO dto) throws Exception;
    ProjectWorkDTO update(ProjectWorkDTO dto) throws Exception;
    void deleteById(int workId);
    void toggleState(int id);
    String selectByProjectIdAndEmployeeId(int projectId, String employeeId);
    void updateState(String state, int workItemId);
    ProjectWorkDTO selectByworksId(int id);
    int getChartDataCount(int selectedId);
    int countByState(int selectedId, String state);
    int countByType(int selectedId, String type);
    List<ProjectWorkDTO> searchBynameAndTitle(String keyword,int projectId, String searchOption);
}
