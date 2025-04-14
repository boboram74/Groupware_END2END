package com.end2end.spring.main.serviceImpl;

import com.end2end.spring.alarm.AlarmService;
import com.end2end.spring.main.dao.LoginHistoryDAO;
import com.end2end.spring.main.dto.LoginHistoryDTO;
import com.end2end.spring.main.service.LoginHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LoginHistoryServiceImpl implements LoginHistoryService {
    @Autowired private LoginHistoryDAO loginHistoryDAO;
    @Autowired private AlarmService alarmService;

    @Override
    public List<LoginHistoryDTO> selectByEmployeeId(String employeeId) {
        return loginHistoryDAO.selectByEmployeeId(employeeId);
    }

    @Override
    public void insert(LoginHistoryDTO dto) {
        loginHistoryDAO.insert(dto);

        if (dto.getState().equals("LOGIN")) {
            List<LoginHistoryDTO> loginHistoryList = loginHistoryDAO.selectByAccessIpAndEmployeeId(dto);

            if (loginHistoryList.isEmpty()) {
                alarmService.sendNewLoginIpAlarm(dto.getEmployeeId());
            }
        }
    }
}
