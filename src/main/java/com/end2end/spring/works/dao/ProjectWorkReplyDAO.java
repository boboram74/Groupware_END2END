package com.end2end.spring.works.dao;

import com.end2end.spring.works.dto.ProjectWorkReplyDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public class ProjectWorkReplyDAO {

    @Autowired
    private SqlSession mybatis;

    public List<ProjectWorkReplyDTO> selectByprojectId(int id) {
        return null;
    }

    public void insert(ProjectWorkReplyDTO dto) {
        // TODO: 댓글 등록
    }

    public void update(ProjectWorkReplyDTO dto) {
        // TODO: 댓글 수정
    }

    public void deleteById(int id) {
        // TODO: 해당 id의 댓글 삭제
    }
}
