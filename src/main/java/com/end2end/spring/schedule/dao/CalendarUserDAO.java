package com.end2end.spring.schedule.dao;

import com.end2end.spring.schedule.dto.CalendarUserDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CalendarUserDAO {
    @Autowired
    private SqlSession mybatis;

    public List<CalendarUserDTO> selectByCalendarId(int calendarId) {
        return mybatis.selectList("calendarUser.selectByCalendarId", calendarId);
    }

    public void insertAll(List<CalendarUserDTO> dtos) {
        mybatis.insert("calendarUser.insertAll", dtos);
    }

    public void insert(CalendarUserDTO dto) {
        mybatis.insert("calendarUser.insert", dto);
    }

    public void deleteById(int id) {
        mybatis.delete("calendarUser.deleteById", id);
    }
}
