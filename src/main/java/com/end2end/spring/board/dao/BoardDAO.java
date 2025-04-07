package com.end2end.spring.board.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO {
    @Autowired
    private SqlSession mybatis;

    public void selectCategoryByName(String name) {
        return mybatis.selectList("board.selectCategoryByName", name);
    }
    public void insertBoardCtUser(boardCtUserDTO) {
        mybatis.insert("board.insertBoardCtUser",boardCtUserDTO);
    }
}
