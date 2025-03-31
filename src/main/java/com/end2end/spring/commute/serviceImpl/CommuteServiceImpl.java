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
        List<CommuteDTO> lateList = commuteDAO.selectByNotState(state);
        List<SolderingDTO> dtoList = lateList.stream().map(SolderingDTO::of)
                .collect(Collectors.toList());

        solderingDAO.insertList(dtoList);

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
        List<CommuteDTO> leaveEarly = commuteDAO.selectEarlyLeave();

        for(CommuteDTO dto : leaveEarly){
            System.out.println(dto.getEmployeeId());
        }
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
