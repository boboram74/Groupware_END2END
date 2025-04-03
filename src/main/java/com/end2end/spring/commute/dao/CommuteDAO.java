package com.end2end.spring.commute.dao;

import com.end2end.spring.commute.dto.CommuteDTO;
import com.end2end.spring.commute.dto.TodayWorkTimeDTO;
import com.end2end.spring.employee.dto.EmployeeDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CommuteDAO {
    @Autowired
    private SqlSession mybatis;

    public void workOn(String employeeId) {
        mybatis.update("commute.workOn", employeeId);
    }

    public void workOff(String employeeId) {
        mybatis.insert("commute.workOff", employeeId);
    }

    public List<CommuteDTO> selectLate() {
        return mybatis.selectList("commute.checkLate");
    }

    public List<EmployeeDTO> selectWorked() { return mybatis.selectList("commute.selectWorked"); }

    public List<EmployeeDTO> selectNotCheck() {
        return mybatis.selectList("commute.selectByNotCheck");
    }

    public List<EmployeeDTO> selectAbsence() {
        return mybatis.selectList("commute.selectAbsence");
    }

    public List<TodayWorkTimeDTO> selectTodayWorkTimeList() { return mybatis.selectList("commute.selectTodayWorkTimeList"); }

    public void insertAll(List<CommuteDTO> dtoList) {
        mybatis.insert("commute.insertAll", dtoList);
    }
}
