package com.end2end.spring.works.dao;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.works.dto.ProjectDTO;
import com.end2end.spring.works.dto.ProjectInsertDTO;
import com.end2end.spring.works.dto.ProjectUserDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProjectDAO {

    @Autowired
    private SqlSession mybatis;

    public int insert(ProjectDTO dto) {
        return mybatis.insert("project.insertProject", dto);

    }
//    public List<EmployeeDTO>
//    selectProjectMemberProfiles(int id) {
//        return mybatis.selectList("project.selectProjectMemberProfiles",id);
//
//    }

    public List<ProjectDTO> selectAll(){

        return mybatis.selectList("project.selectAll");

    }

    public int deleteProjectMember(ProjectUserDTO dto){
        return mybatis.delete("project.deleteProjectMember",dto);
    }

    public List<EmployeeDTO>  getMembersByProjectId(int projectId){
        return mybatis.selectOne("project.getMembersByProjectId", projectId);
    }
public void update(ProjectInsertDTO dto) {
    mybatis.update("project.updateById", dto);
}


    public ProjectDTO findLatestProject(){
       return mybatis.selectOne("project.findLatestProject");
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
