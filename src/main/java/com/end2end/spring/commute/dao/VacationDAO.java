package com.end2end.spring.commute.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class VacationDAO {
    @Autowired
    private SqlSession mybatis;

}
