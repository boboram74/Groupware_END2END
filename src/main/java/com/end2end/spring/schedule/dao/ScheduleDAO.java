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

    public List<ScheduleDTO> selectByEmployeeIdAndCalendarId(CalendarDTO dto) {
        return mybatis.selectList("schedule.selectByEmployeeIdAndCalendarId", dto);
    }
}
