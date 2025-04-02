package com.end2end.spring.mail.dao;

import com.end2end.spring.mail.dto.MailListDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class MailDAO {
    @Autowired
    private SqlSession mybatis;

    public List<MailListDTO> selectByEmployeeId(String employeeId) {
        return mybatis.selectList("mail.selectAll", employeeId);
    }

    public int getRecordTotalCount(String employeeId) {
        return mybatis.selectOne("mail.getRecordTotalCount",employeeId);
    }

    public List<MailListDTO> selectFromto(int start, int end, String employeeId) {
        Map<String, Object> param = new HashMap<>();
        param.put("employeeId", employeeId);
        param.put("start", start);
        param.put("end", end);
        return mybatis.selectList("mail.selectFromto", param);
    }
}