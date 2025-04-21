package com.end2end.spring.commute.serviceImpl;

import com.end2end.spring.commute.dao.ExtendedCommuteDAO;
import com.end2end.spring.commute.dto.ExtendedCommuteDTO;
import com.end2end.spring.commute.service.ExtendedCommuteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ExtendedCommuteServiceImpl implements ExtendedCommuteService {
    @Autowired private ExtendedCommuteDAO extendedCommuteDAO;

    @Override
    public ExtendedCommuteDTO selectByApprovalId(String approvalId) {
        return extendedCommuteDAO.selectByApprovalId(approvalId);
    }
}
