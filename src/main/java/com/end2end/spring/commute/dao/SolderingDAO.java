package com.end2end.spring.commute.dao;

import com.end2end.spring.commute.dto.CommuteDTO;
import com.end2end.spring.commute.dto.CommuteStateDTO;
import com.end2end.spring.commute.dto.SelectPeriodDTO;
import com.end2end.spring.commute.dto.SolderingDTO;
import com.end2end.spring.employee.dto.EmployeeDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class SolderingDAO {
    @Autowired
    private SqlSession mybatis;

    public void insertList(List<SolderingDTO> dtoList) {
        mybatis.insert("soldering.insertList", dtoList);
    }
    public void insert(SolderingDTO dto) {
        mybatis.insert("soldering.insert", dto);
    }
    public int countThisWeekByStateAndEmployeeId(SolderingDTO dto) {
        return mybatis.selectOne("soldering.countThisWeekByStateAndEmployeeId", dto);
    }
    public List<EmployeeDTO> selectByState(String state) {
        return mybatis.selectList("soldering.selectByState", state);
    }
    public List<EmployeeDTO> selectNotCheck() {
        return mybatis.selectList("soldering.selectNotCheck");
    }

    public List<CommuteStateDTO> selectByPeriod(SelectPeriodDTO dto) {
        return mybatis.selectList("soldering.selectByPeriod", dto);
    }

    public void deleteByCommuteId(int commuteId) {
        mybatis.delete("soldering.deleteByCommuteId", commuteId);
    }
}
