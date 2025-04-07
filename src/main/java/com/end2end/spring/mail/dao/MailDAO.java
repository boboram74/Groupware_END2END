package com.end2end.spring.mail.dao;

import com.end2end.spring.mail.dto.*;
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

    public int insert(String emailAddressDTO) {
        return mybatis.insert("mail.insert", emailAddressDTO);
    }
    public int selectDepartmentById(int id) {
        return mybatis.selectOne("mail.selectDepartmentById",id);
    }

    public void insertEmailAddressUser(String emailAddressUserDTO) {
        mybatis.insert("mail.insertEmailAddressUser",emailAddressUserDTO);
    }

    public List<MailPersonalListDTO> selectByEmployeeId(String employeeId) {
        return mybatis.selectList("mail.selectAll", employeeId);
    }
    public int getRecordTotalCount(String employeeId) {
        return mybatis.selectOne("mail.getRecordTotalCount",employeeId);
    }

    public int getRecordImportantTotalCount(String employeeId) {
        return mybatis.selectOne("mail.getRecordImportantTotalCount",employeeId);
    }

    public int getRecordSendTotalCount(String employeeId) {
        return mybatis.selectOne("mail.getRecordSendTotalCount",employeeId);
    }

    public int getRecordReadCount(String employeeId) {
        return mybatis.selectOne("mail.getRecordReadCount",employeeId);
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

    public List<MailTeamListDTO> selectFromtoImportant(int start, int end, String employeeId) {
        Map<String, Object> param = new HashMap<>();
        param.put("employeeId", employeeId);
        param.put("start", start);
        param.put("end", end);
        return mybatis.selectList("mail.selectFromtoImportant", param);
    }

    public List<SendMailListDTO> selectFromtoSendList(int start, int end, String employeeId) {
        Map<String, Object> param = new HashMap<>();
        param.put("employeeId", employeeId);
        param.put("start", start);
        param.put("end", end);
        return mybatis.selectList("mail.selectFromtoSendList", param);
    }

    public MailDetailDTO selectByEmail(String email) {
        return mybatis.selectOne("mail.selectByEmail", email);
    }

    public int insertReadYn(int esId) {
        return mybatis.update("mail.insertReadYn", esId);
    }

    public int insertTrashCan(int esId) {
        return mybatis.update("mail.insertTrashCanYn", esId);
    }

    public int updateImportant(ImportYnDTO dto) {
        return mybatis.update("mail.updateImportant", dto);
    }

}