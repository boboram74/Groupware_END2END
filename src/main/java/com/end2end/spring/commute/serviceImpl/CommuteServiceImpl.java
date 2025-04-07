package com.end2end.spring.commute.serviceImpl;

import com.end2end.spring.commute.dao.CommuteDAO;
import com.end2end.spring.commute.dao.SolderingDAO;
import com.end2end.spring.commute.dao.VacationDAO;
import com.end2end.spring.commute.dto.CommuteDTO;
import com.end2end.spring.commute.dto.SolderingDTO;
import com.end2end.spring.commute.dto.TodayWorkTimeDTO;
import com.end2end.spring.commute.service.CommuteService;
import com.end2end.spring.employee.dao.EmployeeDAO;
import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.util.Statics;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Date;
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
    public boolean workOn(String employeeId) {
        CommuteDTO dto = CommuteDTO.builder()
                .employeeId(employeeId)
                .state("WORK_ON")
                .build();
        if (commuteDAO.isExistByState(dto) > 0) {
            return false;
        }

        commuteDAO.insert(dto);

        Date date = new Date();
        if (date.getHours() > Statics.WORK_HOUR) {
            if (vacationDAO.isOnVacation(employeeId) == 0) {
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
    public boolean workOff(String employeeId) {
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
            if ( vacationDAO.isOnVacation(employeeId) == 0) {
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
}
