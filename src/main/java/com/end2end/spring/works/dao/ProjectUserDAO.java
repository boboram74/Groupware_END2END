package com.end2end.spring.works.dao;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.works.dto.ProjectUserDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProjectUserDAO {
    @Autowired
    private SqlSession mybatis;

    public int insert(ProjectUserDTO dto) {
        return  mybatis.insert("project.insertProjectUser",dto);
    }


    public List<EmployeeDTO> selectByprojectId(int id) {
        return mybatis.selectList("project.selectByprojectId",id);
    }

    public int searchById(int id) {
        return mybatis.selectOne("project.searchById",id);
    }
}
