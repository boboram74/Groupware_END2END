package com.end2end.spring.board.dao;


import com.end2end.spring.board.dto.BoardCategoryDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BoardCategoryDAO {
    @Autowired
    private SqlSession mybatis;

    public void insertCategory(BoardCategoryDTO dto) {
        mybatis.insert("boardCategory.insertCategory", dto);  // MyBatis 매퍼 호출
    }
    public BoardCategoryDTO selectCategoryById(int categoryId) {
        return mybatis.selectOne("boardCategory.selectCategoryById", categoryId);
    }
    public List<BoardCategoryDTO> selectAll(){
        return mybatis.selectList("boardCategory.selectAll");
    }

}
