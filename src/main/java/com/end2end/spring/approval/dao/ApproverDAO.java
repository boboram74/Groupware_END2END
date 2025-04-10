package com.end2end.spring.approval.dao;

import com.end2end.spring.approval.dto.ApproverDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

@Repository
public class ApproverDAO {

    @Autowired
    private SqlSession mybatis;

    public void insertApprover(ApproverDTO approverDTO) {
        mybatis.insert("approver.insertApprover", approverDTO);
    }

    public List<ApproverDTO> nextId(String approvalId) {
        return mybatis.selectList("approver.nextId", approvalId);
    }
    public List<Map<String, Object>> selectApproversList(String approvalId) {
        return mybatis.selectList("approver.selectApproversList", approvalId);
    }
    public void updateSubmitYn(int id, String submitYn, Timestamp submitDate) {
        ApproverDTO approverDTO = new ApproverDTO();
        approverDTO.setId(id);
        approverDTO.setSubmitYn(submitYn);
        approverDTO.setSubmitDate(submitDate);
        mybatis.update("approver.updateSubmitYn", approverDTO);
    }

    public void deleteByApprovalId(String approvalId) {
        mybatis.delete("approver.deleteByApprovalId", approvalId);
    }

}
