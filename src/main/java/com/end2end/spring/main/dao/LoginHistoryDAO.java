package com.end2end.spring.main.dao;

import com.end2end.spring.main.dto.LoginHistoryDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class LoginHistoryDAO {
    @Autowired private SqlSession mybatis;

    public List<LoginHistoryDTO> selectByEmployeeId(String employeeId) {
        return mybatis.selectList("loginHistory.selectByEmployeeId", employeeId);
    }

    public List<LoginHistoryDTO> selectByAccessIpAndEmployeeId(LoginHistoryDTO dto) {
        return mybatis.selectList("loginHistory.selectByAccessIpAndEmployeeId", dto);
    }

    public void insert(LoginHistoryDTO dto) {
        mybatis.insert("loginHistory.insert", dto);
    }
}
