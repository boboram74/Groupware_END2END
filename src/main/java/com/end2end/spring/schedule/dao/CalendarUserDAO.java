package com.end2end.spring.schedule.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;

@Repository
public class CalendarUserDAO {
    @Autowired
    private SqlSession mybatis;


}
