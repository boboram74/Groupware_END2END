package com.end2end.spring.approval.dao;

import com.end2end.spring.approval.dto.ApproverDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ApproverDAO {

    @Autowired
    private SqlSession mybatis;

    public void insertApprover(ApproverDTO approverDTO) {
        mybatis.insert("approver.insertApprover", approverDTO);
    }


}
