package com.end2end.spring.commute.dao;

import com.end2end.spring.commute.dto.CommuteDTO;
import com.end2end.spring.commute.dto.CommuteStateDTO;
import com.end2end.spring.commute.dto.SelectPeriodDTO;
import com.end2end.spring.commute.dto.TodayWorkTimeDTO;
import com.end2end.spring.employee.dto.EmployeeDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class CommuteDAO {
    @Autowired
    private SqlSession mybatis;

    public CommuteDTO selectById(int id) {
        return mybatis.selectOne("commute.selectById", id);
    }

    public int countWorKOnThisWeekByEmployeeId(String employeeId) {
        return mybatis.selectOne("commute.countWorKOnThisWeekByEmployeeId", employeeId);
    }

    public int isExistByState(CommuteDTO dto) {
        return mybatis.selectOne("commute.isExistByState", dto);
    }

    public void insert(CommuteDTO dto) {
        mybatis.insert("commute.insert", dto);
    }

    public CommuteDTO selectByStateAndEmployeeId(CommuteDTO dto) {
        return mybatis.selectOne("commute.selectByStateAndEmployeeId", dto);
    }

    public List<TodayWorkTimeDTO> selectTodayWorkTimeList(String employeeId) {
        return mybatis.selectList("commute.selectThisWeekWorkTime", employeeId); }

    public List<CommuteStateDTO> selectByPeriod(SelectPeriodDTO dto) {
        return mybatis.selectList("commute.selectByPeriod", dto);
    }

    public void update(CommuteDTO dto) {
        mybatis.update("commute.update", dto);
    }
}
