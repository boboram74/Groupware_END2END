package com.end2end.spring.main.dao;

import com.end2end.spring.main.dto.ExamDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ExamDAO {

    @Autowired
    private SqlSession mybatis;

    public int exam(ExamDTO dto) {
        return mybatis.insert("exam.insert", dto);
    }
}