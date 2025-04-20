package com.end2end.spring.commute.dao;

import com.end2end.spring.commute.dto.ExtendedCommuteDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ExtendedCommuteDAO {
    @Autowired private SqlSession mybatis;

    public void insert(ExtendedCommuteDTO dto) {
        mybatis.insert("extendedCommute.insert", dto);
    }

    public List<ExtendedCommuteDTO> selectTodayByEmployeeId(String employeeId) {
        return mybatis.selectList("extendedCommute.selectTodayByEmployeeId", employeeId);
    }

    public ExtendedCommuteDTO selectByApprovalId(String approvalId) {
        return mybatis.selectOne("extendedCommute.selectByCommuteId", approvalId);
    }
}
