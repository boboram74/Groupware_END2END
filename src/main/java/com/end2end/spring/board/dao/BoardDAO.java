package com.end2end.spring.board.dao;

import com.end2end.spring.board.dto.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class BoardDAO {
    @Autowired
    private SqlSession mybatis;

    public List<BoardDTO> selectAll() {
        return mybatis.selectList("board.toList");
    }

    public int deleteById(int id) {
        return mybatis.delete("board.deleteById", id);
    }

    public List<BoardDTO> search(String option, String keyword) {
        Map<String, Object> map = new HashMap<>();
        map.put("option", option);
        map.put("keyword", keyword);
        return mybatis.selectList("board.search", map);
    }

    public List<BoardDTO> selectByCategoryId(int id, String employeeId) {
        Map<String, Object> map = new HashMap<>();
        map.put("categoryId", id);
        map.put("employeeId", employeeId);
        return mybatis.selectList("board.selectByCategoryId", map);
    }

    public BoardDTO selectById(int id) {
        return mybatis.selectOne("board.selectById", id);
    }

    public void insert(BoardDTO dto) {
        mybatis.selectOne("board.insert", dto);
    }

    public BoardCategoryDTO selectCategoryByName(String name) {
        return mybatis.selectOne("board.selectCategoryByName", name);
    }

    public void insertBoardCtUser(BoardCtUserDTO boardCtUserDTO) {
        mybatis.insert("board.insertBoardCtUser", boardCtUserDTO);
    }

    public int update(BoardDTO dto) {
        return mybatis.update("board.update", dto);
    }

    public List<BoardDTO> selectRecent() {
        return mybatis.selectList("board.selectRecent");
    }

    public void increaseViewCount(int id) {
        mybatis.update("board.increaseViewCount", id);
    }

    public int selectNextVal() {
        return mybatis.selectOne("board.selectNextVal");
    }
}
