package com.end2end.spring.works.dao;

import com.end2end.spring.works.dto.ProjectUserDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProjectUserDAO {
    @Autowired
    private SqlSession mybatis;

    public int insert(ProjectUserDTO dto)
    {
        return  mybatis.insert("works.insertProjectUser",dto);

    }

}
