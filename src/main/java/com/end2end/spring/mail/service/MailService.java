package com.end2end.spring.mail.service;

import com.end2end.spring.mail.dto.MailDTO;

import java.util.List;

public interface MailService {
    List<MailDTO> selectByEmployeeId(String employeeId);
    List<MailDTO> selectByEmail();
    List<MailDTO> search();
    void insert(MailDTO mailDTO);
    void update(MailDTO mailDTO);
    void deleteById(int id);
}
