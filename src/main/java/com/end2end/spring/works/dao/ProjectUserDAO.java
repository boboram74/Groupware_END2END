package com.end2end.spring.works.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProjectUserDAO {
    @Autowired
    private SqlSession mybatis;

    public int insert(List<String> employeeId)
    {
        return  mybatis.insert("works.insertProjectUser",employeeId);

    }

}
