package com.end2end.spring.mail.service;

import com.end2end.spring.mail.dto.MailListDTO;

import java.util.List;
import java.util.Map;

public interface MailService {
    List<MailListDTO> selectByEmployeeId(String employeeId);
    List<MailListDTO> selectByEmail();
    List<MailListDTO> search();
    void insert(MailListDTO mailListDTO);
    void deleteById(int id);
    void toggleTrashYN(int id, boolean isInTrashCan);
    Map<String, Object> getPageList(int cpage, String employeeId);
    int getRecordTotalCount(String employeeId);
}