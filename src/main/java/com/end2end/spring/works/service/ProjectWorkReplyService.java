package com.end2end.spring.works.service;


import com.end2end.spring.works.dto.ProjectWorkReplyDTO;

import java.util.List;

public interface ProjectWorkReplyService {
    List<ProjectWorkReplyDTO> selectByprojectId(int id);
    void insert(ProjectWorkReplyDTO dto);
    void update(ProjectWorkReplyDTO dto);
    void deleteById(int id);
}
