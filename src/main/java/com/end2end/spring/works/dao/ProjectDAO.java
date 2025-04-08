package com.end2end.spring.works.dao;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.works.dto.ProjectDTO;
import com.end2end.spring.works.dto.ProjectInsertDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

@Repository
public class ProjectDAO {

    @Autowired
    private SqlSession mybatis;

    public int insert(ProjectDTO dto) {
        return mybatis.insert("project.insertProject", dto);

    }

    public List<ProjectDTO> selectAll(){
        return mybatis.selectList("project.selectAll");
    }

    public int deleteById(int id){
        return mybatis.delete("project.deleteBySeq",id);
    }

    public ProjectDTO selectById(int id){

        return mybatis.selectOne("project.selectById",id);
    }
 public List<EmployeeDTO>selectByUser(String target){
        return mybatis.selectList("project.selectByUser",target);
 }


}
