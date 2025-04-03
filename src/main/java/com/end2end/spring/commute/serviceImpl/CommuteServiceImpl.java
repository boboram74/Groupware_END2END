package com.end2end.spring.commute.serviceImpl;

import com.end2end.spring.commute.dao.CommuteDAO;
import com.end2end.spring.commute.dao.SolderingDAO;
import com.end2end.spring.commute.dto.CommuteDTO;
import com.end2end.spring.commute.dto.SolderingDTO;
import com.end2end.spring.commute.service.CommuteService;
import com.end2end.spring.employee.dao.EmployeeDAO;
import com.end2end.spring.employee.dto.EmployeeDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class CommuteServiceImpl implements CommuteService {
    @Autowired
    private CommuteDAO commuteDAO;
    @Autowired
    private SolderingDAO solderingDAO;
    @Autowired
    private EmployeeDAO employeeDAO;

    @Override
    public List<CommuteDTO> checkLate(String state) {
        // TODO: 지각자 체크
        return null;
    }

    @Override
    public void workOn(String employeeId) {
        commuteDAO.workOn(employeeId);
    }

    @Override
    public void workOff(String employeeId) {
        commuteDAO.workOff(employeeId);
    }

    @Override
    public void checkLeaveEarly() {
        // TODO: 조퇴자 체크
    }

    @Override
    public void checkNotCheck() {
        // TODO: 미체크 체크
        List<EmployeeDTO> employeeList = commuteDAO.selectNotCheck();
    }

    @Override
    public void checkLate() {
        // TODO: 지각자 체크
    }

    @Override
    public void checkAbsence() {
        // TODO: 결근자 체크
        List<EmployeeDTO> employeeList = commuteDAO.selectAbsence();
    }

    @Override
    public void insertAll() {
        List<EmployeeDTO> employeeDTOList = employeeDAO.selectAll();

        List<CommuteDTO> commuteDTOList = employeeDTOList.stream()
                .map(employeeDTO ->
                        CommuteDTO.builder().employeeId(employeeDTO.getId()).build())
                .collect(Collectors.toList());

        commuteDAO.insertAll(commuteDTOList);
    }
}
