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

    public void insert(CommuteDTO dto) {
        mybatis.insert("commute.insert", dto);
    }

    public List<CommuteDTO> selectLate() {
        return mybatis.selectList("commute.checkLate");
    }

    public List<EmployeeDTO> selectNotCheck() {
        return mybatis.selectList("commute.selectByNotCheck");
    }

    public List<EmployeeDTO> selectAbsence() {
        return mybatis.selectList("commute.selectAbsence");
    }

    public List<TodayWorkTimeDTO> selectTodayWorkTimeList() { return mybatis.selectList("commute.selectTodayWorkTimeList"); }
}
