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

    public List<MailURLDTO> selectMailURLById(int id) {
        return mybatis.selectList("mail.selectMailURLById", id);
    }

    public List<AliasMappingDTO> selectByAliesMail() {
        return mybatis.selectList("mail.selectByAliesMail");
    }

    public void deleteRecipientsByAlias(String alias) {
        mybatis.delete("mail.deleteRecipientsByAlias", alias);
    }

    public String findEmployeeIdByEmail(String email) {
        return mybatis.selectOne("mail.findEmployeeIdByEmail", email);
    }

    public void insertAliasUser(String alias, String employeeId) {
        Map<String, Object> param = new HashMap<>();
        param.put("employeeId", employeeId);
        param.put("alias", alias);
        mybatis.insert("mail.insertAliasUser", param);
    }

    public int aliasExists(String alias) {
        return mybatis.selectOne("mail.aliasExists", alias);
    }

    public void insertAlias(String alias, String aliasNm) {
        Map<String, Object> param = new HashMap<>();
        param.put("alias", alias);
        param.put("aliasNm", aliasNm);
        mybatis.insert("mail.insertAlias", param);
    }

    public void deleteAliasUser(String alias, String employeeId) {
        Map<String, Object> param = new HashMap<>();
        param.put("employeeId", employeeId);
        param.put("alias", alias);
        mybatis.delete("mail.deleteAliasUser", param);
    }

    public int countRecipientsByAlias(String alias) {
        return mybatis.selectOne("mail.countRecipientsByAlias", alias);
    }

    public void deleteAlias(String alias) {
        mybatis.delete("mail.deleteAlias", alias);
    }

    public String loadEmailSignature() {
        return mybatis.selectOne("mail.loadEmailSignature");
    }

    public int updateEmailSignature(Map<String, String> body) {
        return mybatis.update("mail.updateEmailSignature", body);
    }
}