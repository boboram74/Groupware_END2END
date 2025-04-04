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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class CommuteServiceImpl implements CommuteService {
    @Autowired private CommuteDAO commuteDAO;
    @Autowired private SolderingDAO solderingDAO;
    @Autowired private EmployeeDAO employeeDAO;
    @Autowired private VacationDAO vacationDAO;

    @Override
    public void workOn(String employeeId) {
        //commuteDAO.workOn(employeeId);
    }

    @Override
    public void workOff(String employeeId) {
        //commuteDAO.workOff(employeeId);
    }

    @Transactional
    @Override
    public void checkLate() {
        List<CommuteDTO> lateList = commuteDAO.selectLate();

        List<SolderingDTO> solderingDTOList = lateList.stream()
                .map((commuteDTO) -> SolderingDTO.builder()
                        .employeeId(commuteDTO.getEmployeeId())
                        .state("LATE")
                        .build())
                .collect(Collectors.toList());
        solderingDAO.insertList(solderingDTOList);
    }

    @Transactional
    @Override
    public void checkLeaveEarly() {
        // TODO: 조퇴자 체크
        List<TodayWorkTimeDTO> todayWorkTimeList = commuteDAO.selectTodayWorkTimeList();

        List<SolderingDTO> leaveEarlyList = todayWorkTimeList.stream()
                .filter((leaveEarlyDTO) ->
                        leaveEarlyDTO.todayWorkTime().toHours() < 2)
                .map((leaveEarlyDTO) ->
                        SolderingDTO.builder()
                            .employeeId(leaveEarlyDTO.getEmployeeId())
                            .state("LEAVE_EARLY")
                        .build())
                .collect(Collectors.toList());
        solderingDAO.insertList(leaveEarlyList);
    }

    @Transactional
    @Override
    public void checkNotCheck() {
        // TODO: 미체크 체크
        List<EmployeeDTO> employeeList = commuteDAO.selectNotCheck();

        List<SolderingDTO> solderingDTOList = employeeList.stream()
                .map((employee) -> SolderingDTO.builder()
                        .employeeId(employee.getId())
                        .state("NOT_CHECK")
                        .build())
                .collect(Collectors.toList());
        solderingDAO.insertList(solderingDTOList);
    }

    @Transactional
    @Override
    public void checkAbsence() {
        // TODO: 결근자 체크
        List<EmployeeDTO> employeeList = commuteDAO.selectAbsence();
        List<EmployeeDTO> notVacationEmployeeList = vacationDAO.selectNotTodayVacation(employeeList);

        List<SolderingDTO> solderingDTOList = notVacationEmployeeList.stream()
                .map((employee) -> SolderingDTO.builder()
                        .employeeId(employee.getId())
                        .state("ABSENCE")
                        .build())
                .collect(Collectors.toList());
        solderingDAO.insertList(solderingDTOList);
    }

    @Transactional
    @Override
    public void insertAll() {
        List<EmployeeDTO> employeeDTOList = employeeDAO.selectAll();

        List<CommuteDTO> commuteDTOList = employeeDTOList.stream()
                .map(employeeDTO ->
                        CommuteDTO.builder().employeeId(employeeDTO.getId()).build())
                .collect(Collectors.toList());

        //commuteDAO.insertAll(commuteDTOList);
    }
}
