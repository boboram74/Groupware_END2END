package com.end2end.spring.mail.service;

import com.end2end.spring.mail.dto.TempMailDTO;

import java.util.List;

public interface TempMailService {
    List<TempMailDTO> selectByEmployeeId(String employeeId);
    void insert(TempMailDTO tempMailDTO);
    void update(TempMailDTO tempMailDTO);
    void deleteById(int id);
    void deleteAll(String employeeId);
}
