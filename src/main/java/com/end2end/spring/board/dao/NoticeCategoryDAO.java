package com.end2end.spring.board.dao;

import com.end2end.spring.board.dto.NoticeCategoryDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class NoticeCategoryDAO {
    @Autowired private SqlSession mybatis;

    public List<NoticeCategoryDTO> selectAll() {
        return mybatis.selectList("noticeCategory.selectAll");
    }

    public NoticeCategoryDTO selectById(int id) {
        return mybatis.selectOne("noticeCategory.selectById", id);
    }

    public void insert(NoticeCategoryDTO dto) {
        mybatis.insert("noticeCategory.insert", dto);
    }

    public void update(NoticeCategoryDTO dto) {
        mybatis.update("noticeCategory.update", dto);
    }

    public void deleteById(int id) {
        mybatis.delete("noticeCategory.deleteById", id);
    }
}
