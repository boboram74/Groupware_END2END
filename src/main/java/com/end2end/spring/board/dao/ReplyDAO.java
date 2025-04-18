package com.end2end.spring.board.dao;

import com.end2end.spring.board.dto.ReplyDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public class ReplyDAO {

    @Autowired
    private SqlSession mybatis;

    public void insert(ReplyDTO dto) {
        mybatis.insert("reply.insert",dto);
    }

    public List<ReplyDTO> selectByBoardId(int boardId) {
        return mybatis.selectList("reply.selectByBoardId",boardId);
    }

    public int deleteById(int id) {
        return mybatis.delete("reply.deleteById", id);
    }

    public ReplyDTO selectById(int id) {
        return mybatis.selectOne("reply.selectById", id);
    }
}
