package com.end2end.spring.works.dao;

import com.end2end.spring.works.dto.ProjectWorkDTO;
import com.end2end.spring.works.dto.ProjectWorkReplyDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ProjectWorkDAO {

    @Autowired
    private SqlSession mybatis;


    public List<ProjectWorkDTO> selectAll() {
        return   mybatis.selectList("works.selectAll");
    }
    public int getProjectId() {
   return  mybatis.selectOne("works.getProjectId");
    }
    public String selectByProjectIdAndEmployeeId(int projectId,String employeeId) {
        Map<String, Object> params = new HashMap<>();
        params.put("projectId", projectId);
        params.put("employeeId", employeeId);
        return mybatis.selectOne("works.selectByProjectIdAndEmployeeId", params);

    }
        public void insert(ProjectWorkDTO dto) {
       mybatis.insert("works.insert",dto);
    }

    public void update(ProjectWorkDTO dto) {
mybatis.update("works.update",dto);
    }

    public void deleteById(int id) {
mybatis.delete("works.deleteById",id);
    }

    public void toggleState(int id) {
        // select * from POJECT_WORK WHERE id = ${id} => state값 추출

        // String changeValue = (state.eqauls("ON_GOING") ?  "FINISH" : "ON_GOING"
        // update PROJECT_WORK set state = #{state} where id = ${id}

        //아니면 값으로 string state 를 받는 방법도 있음
    }
}
