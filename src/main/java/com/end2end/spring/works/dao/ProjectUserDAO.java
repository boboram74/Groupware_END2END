package com.end2end.spring.works.dao;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.works.dto.ProjectUserDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ProjectUserDAO {
    @Autowired
    private SqlSession mybatis;

    public int insert(ProjectUserDTO dto) {
        return  mybatis.insert("project.insertProjectUser",dto);
    }

    public void insertProjectMember(int projectId, String employee) {
        Map<String, Object> params = new HashMap<>();
        params.put("projectId", projectId);
        params.put("employeeId",employee);
        mybatis.insert("project.insertProjectUser", params);
    }

    public int searchById(int id) {
        return mybatis.selectOne("project.searchById",id);
    }

    public void deleteMemberById(int projectId, String userId) {
        Map<String, Object> params = new HashMap<>();
        params.put("projectId", projectId);
        params.put("employeeId", userId);
        mybatis.delete("project.deleteMemberById",params);
    }

    public List<EmployeeDTO> selectByprojectId(int id) {
        return mybatis.selectList("project.selectByprojectId",id);
    }

}
