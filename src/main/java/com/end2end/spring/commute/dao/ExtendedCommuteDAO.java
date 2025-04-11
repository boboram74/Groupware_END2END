package com.end2end.spring.commute.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ExtendedCommuteDAO {
    @Autowired private SqlSession mybatis;

    public void insert() {
        mybatis.insert("extendedCommute.insert");
    }
}
