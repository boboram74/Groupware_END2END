package com.end2end.spring.main.dao;

import com.end2end.spring.main.dto.LoginHistoryDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class LoginHistoryDAO {
    @Autowired private SqlSession mybatis;

    public List<LoginHistoryDTO> selectByEmployeeId(String employeeId) {
        return mybatis.selectList("loginHistory.selectByEmployeeId", employeeId);
    }

    public List<LoginHistoryDTO> selectByEmployeeIdFromTo(String employeeId, int start, int end) {
        Map<String, Object> map = new HashMap<>();
        map.put("employeeId", employeeId);
        map.put("start", start);
        map.put("end", end);

        return mybatis.selectList("loginHistory.selectByEmployeeIdFromTo", map);
    }

    public List<LoginHistoryDTO> selectByAccessIpAndEmployeeId(LoginHistoryDTO dto) {
        return mybatis.selectList("loginHistory.selectByAccessIpAndEmployeeId", dto);
    }

    public void insert(LoginHistoryDTO dto) {
        mybatis.insert("loginHistory.insert", dto);
    }
}
