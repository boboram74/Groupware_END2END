package com.end2end.spring.employee.dao;

import com.end2end.spring.employee.dto.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class EmployeeDAO {
    @Autowired
    private SqlSession mybatis;

    public List<EmployeeDTO> selectAll() {
        return mybatis.selectList("employee.selectAll");
    }

    public void insert(EmployeeDTO dto) {
        mybatis.insert("employee.insert", dto);
    }

    public void insertDetail(EmployeeDetailDTO dto) {
        mybatis.insert("employee.insertDetail", dto);
    }

    public List<EmployeeDTO> selectByDepartmentId(int departmentId) {
        return mybatis.selectList("employee.selectByDepartmentId", departmentId);
    }

    public List<DepartmentDTO> selectAllDepartment() {
        return mybatis.selectList("employee.selectAllDepartment");
    }

    public List<JobDTO> selectAllJob() {
        return mybatis.selectList("employee.selectAllJob");
    }

    public EmployeeDTO login(LoginDTO dto) {
        return mybatis.selectOne("employee.login", dto);
    }

    public EmployeeDetailDTO selectDetailById(String loginId){
        return mybatis.selectOne("employee.selectDetailById", loginId);
    }
}
