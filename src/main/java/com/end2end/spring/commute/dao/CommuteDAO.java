package com.end2end.spring.commute.dao;

import com.end2end.spring.commute.dto.CommuteDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CommuteDAO {
    @Autowired
    private SqlSession mybatis;

    public void workOff(String employeeId) {
        mybatis.insert("commute.workOff", employeeId);
    }

    public void workOn(String employeeId) {
        mybatis.update("commute.workOn", employeeId);
    }

    public List<CommuteDTO> selectLate() {
        return mybatis.selectList("commute.checkLate");
    }

    public List<CommuteDTO> selectEarlyLeave() {
        return mybatis.selectList("commute.selectEarlyLeave");
    }

    public void insertAll(List<CommuteDTO> dtoList) {
        mybatis.insert("commute.insertAll", dtoList);
    }
}
