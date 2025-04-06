package com.end2end.spring.commute.dao;

import com.end2end.spring.commute.dto.SolderingDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class SolderingDAO {
    @Autowired
    private SqlSession mybatis;

    public void insertList(List<SolderingDTO> dtoList) {
        mybatis.insert("soldering.insert", dtoList);
    }
    public int countByStateAndEmployeeId(SolderingDTO dto) {
        return mybatis.selectOne("soldering.countByStateAndEmployeeId", dto);
    }
}
