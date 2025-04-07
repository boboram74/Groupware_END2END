package com.end2end.spring.commute.dao;

import com.end2end.spring.commute.dto.VacationDTO;
import com.end2end.spring.employee.dto.EmployeeDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class VacationDAO {
    @Autowired
    private SqlSession mybatis;

    public List<EmployeeDTO> selectNotCurrentVacation(List<EmployeeDTO> employeeIds) {
        return mybatis.selectList("commute.selectNotCurrentVacation", employeeIds);
    }

    public List<EmployeeDTO> selectNotTodayVacation(List<EmployeeDTO> employeeIds) {
        return mybatis.selectList("commute.selectNotTodayVacation", employeeIds);
    }

    public void insert(VacationDTO vacation) {
        mybatis.insert("commute.insertVacation", vacation);
    }
}
