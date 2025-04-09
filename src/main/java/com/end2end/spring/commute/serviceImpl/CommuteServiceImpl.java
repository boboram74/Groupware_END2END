package com.end2end.spring.commute.serviceImpl;

import com.end2end.spring.commute.dao.CommuteDAO;
import com.end2end.spring.commute.dao.SolderingDAO;
import com.end2end.spring.commute.dao.VacationDAO;
import com.end2end.spring.commute.dto.*;
import com.end2end.spring.commute.service.CommuteService;
import com.end2end.spring.employee.dao.EmployeeDAO;
import com.end2end.spring.util.EventDTO;
import com.end2end.spring.util.HolidayUtil;
import com.end2end.spring.util.Statics;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CommuteServiceImpl implements CommuteService {
    @Autowired private CommuteDAO commuteDAO;
    @Autowired private SolderingDAO solderingDAO;
    @Autowired private EmployeeDAO employeeDAO;
    @Autowired private VacationDAO vacationDAO;

    @Transactional
    @Override
    public boolean isExistByState(String employeeId, String state) {
        return commuteDAO.isExistByState(CommuteDTO.builder()
                .employeeId(employeeId)
                .state(state)
                .build()) > 0;
    }

    @Transactional
    @Override
    public boolean workOn(String employeeId) throws IOException {
        CommuteDTO dto = CommuteDTO.builder()
                .employeeId(employeeId)
                .state("WORK_ON")
                .build();
        if (commuteDAO.isExistByState(dto) > 0) {
            return false;
        }

        commuteDAO.insert(dto);

        LocalDateTime date = LocalDateTime.now();
        if (date.getHour() > Statics.WORK_ON_CHECK_TIME) {
            if (vacationDAO.isOnVacation(employeeId) == 0 || HolidayUtil.isHoliday(LocalDate.now())) {
                SolderingDTO solderingDTO = SolderingDTO.builder()
                        .employeeId(employeeId)
                        .state("LATE")
                        .build();
                solderingDAO.insert(solderingDTO);
            }
        }

        return true;
    }

    @Transactional
    @Override
    public boolean workOff(String employeeId) throws IOException {
        CommuteDTO dto = CommuteDTO.builder()
                .employeeId(employeeId)
                .state("WORK_ON")
                .build();
        if (commuteDAO.isExistByState(dto) == 0) {
            return false;
        }

        dto.setState("WORK_OFF");
        if (commuteDAO.isExistByState(dto) > 0) {
            return false;
        }
        commuteDAO.insert(dto);
        CommuteDTO workOnDTO = commuteDAO.selectByStateAndEmployeeId(dto);

        long workHour = Duration.between(workOnDTO.getRegDate().toLocalDateTime(), LocalDateTime.now()).toHours();
        if(workHour < Statics.WORK_HOUR) {
            if ( vacationDAO.isOnVacation(employeeId) == 0 || HolidayUtil.isHoliday(LocalDate.now())) {
                SolderingDTO solderingDTO = SolderingDTO.builder()
                        .employeeId(employeeId)
                        .state("LEAVE_EARLY")
                        .build();
                solderingDAO.insert(solderingDTO);
            }
        }

        return true;

    }

    @Override
    public CommuteDTO selectByStateAndEmployeeId(CommuteDTO dto) {
        return  commuteDAO.selectByStateAndEmployeeId(dto);
    }

    @Override
    public int countWorkOnThisWeekByEmployeeId(String employeeId) {
        return commuteDAO.countWorKOnThisWeekByEmployeeId(employeeId);
    }

    @Override
    public int rateWorkOnThisWeekByEmployeeId(String employeeId) {
        int workOnThisWeek = commuteDAO.countWorKOnThisWeekByEmployeeId(employeeId);

        LocalDate today = LocalDate.now();
        LocalDate hiredDate = employeeDAO.selectDetailById(employeeId).getHireDate()
                .toLocalDateTime().toLocalDate();
        long daysBetween = ChronoUnit.DAYS.between(hiredDate, today);

        int dayValue;
        if (daysBetween > 7) {
            dayValue = today.getDayOfWeek().getValue();
        } else {
            dayValue = (int) daysBetween + 1;
        }

        return (int) ((double) workOnThisWeek / dayValue * 100);
    }

    @Override
    public long sumTotalWorkTimeThisWeekByEmployeeId(String employeeId) {
        List<TodayWorkTimeDTO> workTimeList = commuteDAO.selectTodayWorkTimeList(employeeId);

        long totalDuration = 0;
        for (TodayWorkTimeDTO dto : workTimeList) {
            totalDuration += dto.todayWorkTime();
        }

        return totalDuration;
    }

    @Transactional
    @Override
    public List<EventDTO> selectPeriodWorkState(SelectPeriodDTO dto) {
        List<CommuteStateDTO> commutePeriodList = commuteDAO.selectByPeriod(dto);
        List<CommuteStateDTO> solderingPeriodList = solderingDAO.selectByPeriod(dto);
        List<VacationDTO> vacationPeriodList = vacationDAO.selectByPeriod(dto);

        LocalDate start = dto.getStartDate().toLocalDate();
        LocalDate end = dto.getEndDate().toLocalDate();

        List<CommuteStateDTO> list = new ArrayList<>();
        for (LocalDate date = start; !date.isAfter(end); date = date.plusDays(1)) {
            LocalDate finalDate = date;

            List<CommuteStateDTO> commuteLocalDateList = commutePeriodList.stream()
                    .filter(commuteStateDTO ->
                            commuteStateDTO.getDates().toLocalDate().equals(finalDate))
                    .collect(Collectors.toList());
            list.addAll(commuteLocalDateList);

            List<CommuteStateDTO> solderingLocalDateList = solderingPeriodList.stream()
                    .filter(commuteStateDTO ->
                            commuteStateDTO.getDates().toLocalDate().equals(finalDate))
                    .collect(Collectors.toList());
            list.addAll(solderingLocalDateList);
        }

        List<EventDTO> result = list.stream()
                .map(EventDTO::convertFromCommuteState)
                .collect(Collectors.toList());

        result.addAll(
                vacationPeriodList.stream()
                        .map(vacationDTO ->
                                EventDTO.convertFromVacation(vacationDTO, start, end))
                        .collect(Collectors.toList()));

        return result;
    }
}
