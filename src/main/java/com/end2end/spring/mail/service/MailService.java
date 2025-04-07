package com.end2end.spring.mail.service;

import com.end2end.spring.mail.dto.*;

import java.util.List;
import java.util.Map;

public interface MailService {
    List<MailPersonalListDTO> selectByEmployeeId(String employeeId);
    MailDetailDTO selectByEmail(String email);
    List<MailPersonalListDTO> search();
    void insert(MailPersonalListDTO mailListDTO);
    void deleteById(int id);
    void toggleTrashYN(int id, boolean isInTrashCan);
    Map<String, Object> getPageList(int cpage, String employeeId, String action);
    int getRecordTotalCount(String employeeId);
    int getRecordImportantTotalCount(String employeeId);
    int getRecordSendTotalCount(String employeeId);
    int getRecordReadCount(String employeeId);
    String selectDepartment(String employeeId);
    List<MailTeamListDTO> selectFromto(int start, int end, String employeeId);
    List<MailTeamListDTO> selectFromtoImportant(int start, int end, String employeeId);
    List<SendMailListDTO> selectFromtoSendList(int start, int end, String employeeId);

    int insertReadYn(int esId);
    int updateImportant(ImportYnDTO dto);

    int insertReadYnAll(List<Integer> esids);
    int trashAll(List<Integer> esids);

}