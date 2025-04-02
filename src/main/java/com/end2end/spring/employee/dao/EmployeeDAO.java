package com.end2end.spring.employee.dao;

import com.end2end.spring.employee.dto.EmployeeDTO;
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

    public List<EmployeeDTO> selectByDepartmentId(int id) {
        return mybatis.selectList("employee.selectByDepartmentId", id);
    }
}
