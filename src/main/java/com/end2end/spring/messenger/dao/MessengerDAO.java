package com.end2end.spring.messenger.dao;

import com.end2end.spring.messenger.dto.MessengerEmployeeListDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MessengerDAO {
    @Autowired
    private SqlSession mybatis;

    public List<MessengerEmployeeListDTO> selectByEmployeeId() {
        return mybatis.selectList("messenger.selectEmployeeAll");
    }
}