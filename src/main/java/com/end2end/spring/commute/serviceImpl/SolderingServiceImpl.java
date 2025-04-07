package com.end2end.spring.commute.serviceImpl;

import com.end2end.spring.commute.dao.SolderingDAO;
import com.end2end.spring.commute.dto.SolderingDTO;
import com.end2end.spring.commute.service.SolderingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SolderingServiceImpl implements SolderingService {
    @Autowired private SolderingDAO solderingDAO;

    @Override
    public int countTisWeekByStateAndEmployeeId(SolderingDTO dto) {
        return solderingDAO.countThisWeekByStateAndEmployeeId(dto);
    }
}
