package com.end2end.spring.approval.serviceImpl;

import com.end2end.spring.approval.dto.ApprovalDTO;
import com.end2end.spring.approval.service.ApprovalService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ApprovalServiceImpl implements ApprovalService {
    @Override
    public List<ApprovalDTO> selectAll() {
        return null;
    }

    @Override
    public List<ApprovalDTO> selectByEmployeeId(String employeeId) {
        return null;
    }

    @Override
    public List<ApprovalDTO> search() {
        return null;
    }

    @Override
    public List<ApprovalDTO> selectByState(String state) {
        return null;
    }

    @Override
    public ApprovalDTO selectById(String id) {
        return null;
    }

    @Override
    public void insert(ApprovalDTO dto) {

    }

    @Override
    public void update(ApprovalDTO dto) {

    }

    @Override
    public void deleteById(String id) {

    }

    @Override
    public void submit() {

    }
}
