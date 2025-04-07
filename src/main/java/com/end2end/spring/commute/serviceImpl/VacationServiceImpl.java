package com.end2end.spring.commute.serviceImpl;

import com.end2end.spring.commute.dao.VacationDAO;
import com.end2end.spring.commute.dto.VacationDTO;
import com.end2end.spring.commute.dto.VacationManagementDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.end2end.spring.commute.service.VacationService;

@Service
public class VacationServiceImpl implements VacationService {
    @Autowired
    private VacationDAO vacationDAO;

    @Override
    public void insert(VacationDTO dto) {
        vacationDAO.insert(dto);
    }

    @Override
    public void insertUsableVacation(VacationManagementDTO dto) {
        // TODO: 사용 가능한 휴가 생성
    }

    @Override
    public double sumTotalVacationDates(String employeeId) {
        double totalVacationDates = vacationDAO.sumTotalVacationDates(employeeId);
        totalVacationDates = Math.round(totalVacationDates * 100.0) / 100.0;

        return totalVacationDates;
    }
}
