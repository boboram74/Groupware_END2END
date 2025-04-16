package com.end2end.spring.schedule.dao;

import com.end2end.spring.schedule.dto.CalendarDTO;
import com.end2end.spring.schedule.dto.ScheduleDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ScheduleDAO {
    @Autowired private SqlSession mybatis;

    public List<ScheduleDTO> selectByEmployeeId(String employeeId) {
        return mybatis.selectList("schedule.selectByEmployeeId", employeeId);
    }

    public List<ScheduleDTO> selectByCalendarId(int calendarId) {
        return mybatis.selectList("schedule.selectByCalendarId", calendarId);
    }

    public ScheduleDTO selectById(int id) {
        return mybatis.selectOne("schedule.selectById", id);
    }

    public void insert(ScheduleDTO dto) {
        mybatis.insert("schedule.insert", dto);
    }

    public void update(ScheduleDTO dto) {
        mybatis.update("schedule.update", dto);
    }

    public void deleteById(int id) {
        mybatis.delete("schedule.deleteById", id);
    }
}
