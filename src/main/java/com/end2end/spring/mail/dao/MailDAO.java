package com.end2end.spring.mail.dao;

import com.end2end.spring.mail.dto.MailDetailDTO;
import com.end2end.spring.mail.dto.MailPersonalListDTO;
import com.end2end.spring.mail.dto.MailTeamListDTO;
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

    public List<MailPersonalListDTO> selectByEmployeeId(String employeeId) {
        return mybatis.selectList("mail.selectAll", employeeId);
    }
    public int getRecordTotalCount(String employeeId) {
        return mybatis.selectOne("mail.getRecordTotalCount",employeeId);
    }
    public String selectDepartment(String employeeId) {
        return mybatis.selectOne("mail.selectDepartmentName", employeeId);
    }
    public List<MailTeamListDTO> selectDepartEmail(String teamEmail) {
        return mybatis.selectList("mail.selectDepartEmail",teamEmail);
    }
    public List<MailTeamListDTO> selectFromto(int start, int end, String employeeId) {
        Map<String, Object> param = new HashMap<>();
        param.put("employeeId", employeeId);
        param.put("start", start);
        param.put("end", end);
        return mybatis.selectList("mail.selectFromto", param);
    }

    public MailDetailDTO selectByEmail(String email) {
        return mybatis.selectOne("mail.selectByEmail", email);
    }
}