package com.end2end.spring.commute.serviceImpl;

import com.end2end.spring.commute.dao.SolderingDAO;
import com.end2end.spring.commute.dto.SolderingDTO;
import com.end2end.spring.commute.service.SolderingService;
import com.end2end.spring.employee.dto.EmployeeDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class SolderingServiceImpl implements SolderingService {
    @Autowired private SolderingDAO solderingDAO;

    @Override
    public int countTisWeekByStateAndEmployeeId(SolderingDTO dto) {
        return solderingDAO.countThisWeekByStateAndEmployeeId(dto);
    }

    @Transactional
    @Override
    public void insertByState(String state) {
        List<EmployeeDTO> employeeDTOList = solderingDAO.selectByState(state);

        List<SolderingDTO> solderingDTOList = employeeDTOList.stream()
                .map((employee) -> SolderingDTO.builder()
                        .employeeId(employee.getId())
                        .state(state)
                        .build())
                .collect(Collectors.toList());
        solderingDAO.insertList(solderingDTOList);
    }

    @Transactional
    @Override
    public void insertNotCheck() {
        List<EmployeeDTO> employeeDTOList = solderingDAO.selectNotCheck();

        List<SolderingDTO> solderingDTOList = employeeDTOList.stream()
                .map((employee) -> SolderingDTO.builder()
                        .employeeId(employee.getId())
                        .state("NOT_CHECK")
                        .build())
                .collect(Collectors.toList());
        solderingDAO.insertList(solderingDTOList);
    }
}
