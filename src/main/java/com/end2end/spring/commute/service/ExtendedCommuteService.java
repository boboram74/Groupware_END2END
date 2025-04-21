package com.end2end.spring.commute.service;

import com.end2end.spring.commute.dto.ExtendedCommuteDTO;

public interface ExtendedCommuteService {
    ExtendedCommuteDTO selectByApprovalId(String approvalId);
}
