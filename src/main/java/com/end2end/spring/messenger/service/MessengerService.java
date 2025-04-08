package com.end2end.spring.messenger.service;

import com.end2end.spring.messenger.dto.MessengerEmployeeListDTO;

import java.util.List;

public interface MessengerService {
    List<MessengerEmployeeListDTO> employeeListAll();
}