package com.end2end.spring.commute.dao;

import com.end2end.spring.commute.dto.CommuteDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CommuteDAO {
    @Autowired
    private SqlSession mybatis;

    public List<CommuteDTO> selectByNotState(String state) {
        return mybatis.selectList("commute.selectByNotState", state);
    }

    public void insert(CommuteDTO dto) {
        mybatis.insert("commute.insert", dto);
    }

    public List<CommuteDTO> selectEarlyLeave() {
        return mybatis.selectList("commute.selectEarlyLeave");
    }

    public void insertAll(List<CommuteDTO> dtoList) {
        mybatis.insert("commute.insertAll", dtoList);
    }
}
