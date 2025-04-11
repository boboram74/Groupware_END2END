package com.end2end.spring.commute.serviceImpl;

import com.end2end.spring.commute.dao.SolderingDAO;
import com.end2end.spring.commute.dao.VacationDAO;
import com.end2end.spring.commute.dto.*;
import com.end2end.spring.util.HolidayUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.end2end.spring.commute.service.VacationService;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@Service
public class VacationServiceImpl implements VacationService {
    @Autowired
    private VacationDAO vacationDAO;

    @Autowired
    private SolderingDAO solderingDAO;

    @Override
    public List<VacationDTO> selectByEmployeeId(String employeeId) {
        return vacationDAO.selectByEmployeeId(employeeId);
    }

    @Override
    public void insert(VacationDTO dto) {
        // TODO: 휴가 쓰기
        vacationDAO.insert(dto);
    }

    @Transactional
    @Override
    public void insertUsableVacationHired1st() throws IOException {
        List<GetVacationDTO> employeeList = vacationDAO.selectGetVacationForHired1st();

        if (employeeList.isEmpty()) {
            return;
        }

        LocalDate today = LocalDate.now();
        LocalDate startDate = today.minusDays(30);

        int workingDays = HolidayUtil.getWorkingDaysBetween(startDate, today);

        for (GetVacationDTO getVacationDTO : employeeList) {
            SelectPeriodDTO selectPeriodDTO = SelectPeriodDTO.builder()
                    .startDate(Date.valueOf(startDate))
                    .endDate(Date.valueOf(today))
                    .employeeId(getVacationDTO.getEmployeeId())
                    .build();
            List<CommuteStateDTO> solderingList = solderingDAO.selectByPeriod(selectPeriodDTO);

            int count = 0;
            int countCount = 0;
            for (CommuteStateDTO commuteStateDTO : solderingList) {
                if (commuteStateDTO.getState().equals("ABSENCE")) {
                    count++;
                } else {
                    countCount++;
                    if (countCount == 3) {
                        count++;
                        countCount = 0;
                    }
                }
            }

            if ((count / workingDays) * 10 < 2) {
                VacationManagementDTO vacationManagementDTO = VacationManagementDTO.builder()
                        .dates(1)
                        .reason("연차")
                        .employeeId(getVacationDTO.getEmployeeId())
                        .build();
                vacationDAO.insertUsableVacation(vacationManagementDTO);
            }
        }
    }

    /**
     * 1년 이상 근무자의 휴가를 넣어주는 메서드
     */
    @Transactional
    @Override
    public void insertUsableVacation() throws IOException {
        List<GetVacationDTO> employeeList = vacationDAO.selectGetVacationList();

        if (employeeList.isEmpty()) {
            return;
        }

        LocalDate today = LocalDate.now();
        LocalDate startDate = today.minusYears(1);

        int workingDays = HolidayUtil.getWorkingDaysBetween(startDate, today);

        for( GetVacationDTO getVacationDTO : employeeList) {
            SelectPeriodDTO selectPeriodDTO = SelectPeriodDTO.builder()
                    .startDate(Date.valueOf(startDate))
                    .endDate(Date.valueOf(today))
                    .employeeId(getVacationDTO.getEmployeeId())
                    .build();
            List<CommuteStateDTO> solderingList = solderingDAO.selectByPeriod(selectPeriodDTO);

            int count = 0;
            int countCount = 0;

            for (CommuteStateDTO commuteStateDTO : solderingList) {
                if (commuteStateDTO.getState().equals("ABSENCE")) {
                    count++;
                } else {
                    countCount++;
                    if (countCount == 3) {
                        count++;
                    }
                }
            }

            if ((count / workingDays) * 10 < 2) {
                int bonusVacation = getVacationDTO.getYearOfService() / 2;

                VacationManagementDTO vacationManagementDTO = VacationManagementDTO.builder()
                        .dates(15 + bonusVacation)
                        .reason("연차")
                        .employeeId(getVacationDTO.getEmployeeId())
                        .build();
                vacationDAO.insertUsableVacation(vacationManagementDTO);
            }
        }
    }

    @Override
    public double sumTotalVacationDates(String employeeId) {
        double totalVacationDates = vacationDAO.sumTotalVacationDates(employeeId);
        totalVacationDates = Math.round(totalVacationDates * 10.0) / 10.0;

        return totalVacationDates;
    }

    @Override
    public double sumTotalUsedVacationDates(String employeeId) {
        double totalUsedVacationDates = vacationDAO.sumTotalUsedVacationDates(employeeId);
        totalUsedVacationDates = Math.round(totalUsedVacationDates * 10.0) / 10.0;

        return totalUsedVacationDates;
    }

    @Override
    public double sumThisMonthUsedVacationDates(String employeeId) {
        double thisMonthUsedVacationDates = vacationDAO.sumUsedThisMonthVacationDates(employeeId);
        thisMonthUsedVacationDates = Math.round(thisMonthUsedVacationDates * 10.0) / 10.0;

        return thisMonthUsedVacationDates;
    }
}
