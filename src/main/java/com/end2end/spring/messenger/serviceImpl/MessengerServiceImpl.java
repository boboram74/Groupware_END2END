package com.end2end.spring.messenger.serviceImpl;

import com.end2end.spring.messenger.dao.MessengerDAO;
import com.end2end.spring.messenger.dto.MessengerEmployeeListDTO;
import com.end2end.spring.messenger.service.MessengerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MessengerServiceImpl implements MessengerService {

    @Autowired
    private MessengerDAO messengerDAO;

    @Override
    public List<MessengerEmployeeListDTO> employeeListAll() {
        return messengerDAO.selectByEmployeeId();
    }
}