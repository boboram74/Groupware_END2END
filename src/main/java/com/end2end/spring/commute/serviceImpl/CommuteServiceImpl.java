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

        return true;

    }

    @Override
    public CommuteDTO selectByEmployeeIdAndState(CommuteDTO dto) {
        return  (dto.getState().equals("WORK_ON")) ?
                commuteDAO.selectWorkOnByEmployeeId(dto.getEmployeeId()) : commuteDAO.selectWorkOffByEmployeeId(dto.getEmployeeId());
    }

    @Override
    public int countWorkOnThisWeekByEmployeeId(String employeeId) {
        return commuteDAO.countWorKOnThisWeekByEmployeeId(employeeId);
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
