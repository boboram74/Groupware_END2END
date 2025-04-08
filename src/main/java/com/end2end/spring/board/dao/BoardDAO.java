package com.end2end.spring.board.dao;

import com.end2end.spring.board.dto.BoardCategoryDTO;
import com.end2end.spring.board.dto.BoardCtUserDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO {
    @Autowired
    private SqlSession mybatis;

    public BoardCategoryDTO selectCategoryByName(String name) {
        return mybatis.selectOne("board.selectCategoryByName", name);
    }
    public void insertBoardCtUser(BoardCtUserDTO boardCtUserDTO) {
        mybatis.insert("board.insertBoardCtUser",boardCtUserDTO);
    }
}
