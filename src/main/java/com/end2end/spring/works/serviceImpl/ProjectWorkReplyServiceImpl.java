package com.end2end.spring.works.serviceImpl;


import com.end2end.spring.works.dto.ProjectWorkReplyDTO;
import com.end2end.spring.works.service.ProjectWorkReplyService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProjectWorkReplyServiceImpl implements ProjectWorkReplyService {


    @Override
    public List<ProjectWorkReplyDTO> selectByprojectId(int id) {
        return null;
    }

    @Override
    public void insert(ProjectWorkReplyDTO dto) {
        // TODO: 댓글 등록
    }

    @Override
    public void update(ProjectWorkReplyDTO dto) {
        // TODO: 댓글 수정
    }

    @Override
    public void deleteById(int id) {
        // TODO: 해당 id의 댓글 삭제
    }
}
