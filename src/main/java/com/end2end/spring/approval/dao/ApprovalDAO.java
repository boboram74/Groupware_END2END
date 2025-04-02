package com.end2end.spring.approval.dao;

import com.end2end.spring.approval.dto.ApprovalDTO;
import com.end2end.spring.employee.dto.EmployeeDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ApprovalDAO {

    @Autowired
    private SqlSession mybatis;

    public List<ApprovalDTO> toList(){

        return mybatis.selectList("approval.toList");
    }

    public List<EmployeeDTO> employeeList(int departmentId){

        return mybatis.selectList("approval.employeeList",departmentId);
    }
}
