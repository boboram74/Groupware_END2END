package com.end2end.spring.mail.service;

import com.end2end.spring.mail.dto.MailDetailDTO;
import com.end2end.spring.mail.dto.MailPersonalListDTO;
import com.end2end.spring.mail.dto.MailTeamListDTO;

import java.util.List;
import java.util.Map;

public interface MailService {
    List<MailPersonalListDTO> selectByEmployeeId(String employeeId);
    MailDetailDTO selectByEmail(String email);
    List<MailPersonalListDTO> search();
    void insert(MailPersonalListDTO mailListDTO);
    void deleteById(int id);
    void toggleTrashYN(int id, boolean isInTrashCan);
    Map<String, Object> getPageList(int cpage, String employeeId);
    int getRecordTotalCount(String employeeId);
    String selectDepartment(String employeeId);
    List<MailTeamListDTO> selectFromto(int start, int end, String employeeId);
}