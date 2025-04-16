package com.end2end.spring.schedule.dao;

import com.end2end.spring.schedule.dto.CalendarDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CalendarDAO {
    @Autowired
    private SqlSession mybatis;

    public List<CalendarDTO> selectByEmployeeId(String employeeId) {
        return mybatis.selectList("calendar.selectByEmployeeId", employeeId);
    }

    public CalendarDTO selectById(int calendarId) {
        return mybatis.selectOne("calendar.selectById", calendarId);
    }

    public void insert(CalendarDTO dto) {
        mybatis.insert("calendar.insert", dto);
    }

    public void update(CalendarDTO dto) {
        mybatis.update("calendar.update", dto);
    }

    public void deleteById(int id) {
        mybatis.delete("calendar.deleteById", id);
    }
}
