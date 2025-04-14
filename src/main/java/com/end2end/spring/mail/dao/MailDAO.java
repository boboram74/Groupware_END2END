package com.end2end.spring.mail.dao;

import com.end2end.spring.employee.dto.DepartmentDTO;
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

    public int insert(EmailAddressDTO emailAddressDTO) {
        return mybatis.insert("mail.insert", emailAddressDTO);
    }
    public DepartmentDTO selectDepartmentById(int id) {
        return mybatis.selectOne("mail.selectDepartmentById",id);
    }

    public void insertEmailAddressUser(EmailAddressUserDTO emailAddressUserDTO) {
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

    public int getRecordReceiveReadCount(String employeeId) {
        return mybatis.selectOne("mail.getRecordReceiveReadCount",employeeId);
    }

    public int getRecordReceiveCount(String employeeId) {
        return mybatis.selectOne("mail.getRecordReceiveCount",employeeId);
    }

    public int getRecordTrashCount(String employeeId) {
        return mybatis.selectOne("mail.getRecordTrashCount",employeeId);
    }

    public String selectDepartment(String employeeId) {
        return mybatis.selectOne("mail.selectDepartmentName", employeeId);
    }
    public List<MailListDTO> selectDepartEmail(String teamEmail) {
        return mybatis.selectList("mail.selectDepartEmail",teamEmail);
    }
    public List<MailListDTO> selectFromto(int start, int end, String employeeId) {
        Map<String, Object> param = new HashMap<>();
        param.put("employeeId", employeeId);
        param.put("start", start);
        param.put("end", end);
        return mybatis.selectList("mail.selectFromto", param);
    }

    public List<MailListDTO> selectFromtoImportant(int start, int end, String employeeId) {
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

    public List<MailListDTO> selectFromtoReceiveList(int start, int end, String employeeId) {
        Map<String, Object> param = new HashMap<>();
        param.put("employeeId", employeeId);
        param.put("start", start);
        param.put("end", end);
        return mybatis.selectList("mail.selectFromtoReciveList", param);
    }

    public List<MailListDTO> selectFromtoTrashList(int start, int end, String employeeId) {
        Map<String, Object> param = new HashMap<>();
        param.put("employeeId", employeeId);
        param.put("start", start);
        param.put("end", end);
        return mybatis.selectList("mail.selectFromtoTrashList", param);
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
    public int insertDelete(int esId) {
        return mybatis.update("mail.insertDelete", esId);
    }

    public List<EmailAddressUserDTO> selectEmailAddressUserByEmailAddress(String email) {
        return mybatis.selectList("mail.selectEmailAddressUserByEmailAddress", email);
    }
}