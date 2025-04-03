package com.end2end.spring.works.dao;

import com.end2end.spring.works.dto.ProjectDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ProjectDAO {

    @Autowired
    private SqlSession mybatis;

    public int insert(String name)
    {
      return  mybatis.insert("project.insert",name);

    }
    public List<ProjectDTO> selectAll(){
        return mybatis.selectList("project.selectAll");
    }

    public int deleteById(int id){
        return mybatis.delete("project.deleteBySeq",id);
    }

    public  List<ProjectDTO> selectByCon(Map<String,Object> param){

        return mybatis.selectList("project.selectByCon",param);
    }
    public List<ProjectDTO>detailSearch(Map<String,Object>param){
        return mybatis.selectList("project.detailSearch",param);
    }


}
