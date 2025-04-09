package com.end2end.spring.approval.dao;

import com.end2end.spring.approval.dto.ApprovalRejectDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ApprovalRejectDAO {
    @Autowired
    private SqlSession mybatis;

    public void insertReject(ApprovalRejectDTO dto) {
        mybatis.insert("approvalReject.insertReject", dto);
    }
}
