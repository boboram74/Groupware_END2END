package com.end2end.spring.works.dao;

import com.end2end.spring.works.dto.ProjectWorkDTO;
import com.end2end.spring.works.dto.ProjectWorkReplyDTO;
import com.end2end.spring.works.dto.WorkUpdateDTO;
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


    public List<ProjectWorkDTO> selectAll(int id) {

        return mybatis.selectList("works.selectAll", id);
    }

    public List<ProjectWorkDTO> selectAll() {

        return mybatis.selectList("works.selectAllProjectWork");
    }

    public int getProjectId() {
        return mybatis.selectOne("works.getProjectId");
    }

    public String selectByProjectIdAndEmployeeId(int projectId, String employeeId) {
        Map<String, Object> params = new HashMap<>();
        params.put("projectId", projectId);
        params.put("employeeId", employeeId);
        return mybatis.selectOne("works.selectByProjectIdAndEmployeeId", params);

    }

    public void insert(ProjectWorkDTO dto) {
        mybatis.insert("works.insert", dto);
    }

    public void update(ProjectWorkDTO dto) {
        
//        System.out.println("dao도착");
        mybatis.update("works.update", dto);
    }
public List<ProjectWorkDTO> searchBynameAndTitle(String keyword,int projectId, String searchOption) {


        Map<String, Object> params = new HashMap<>();
        params.put("projectId", projectId);
    params.put("searchOption", searchOption);
        params.put("keyword",keyword);

    return mybatis.selectList("searchWorkList",params);
}

public int countTotalWorksByProjectId(int projectId) {
        return mybatis.selectOne("works.countTotalWorksByProjectId", projectId);
}
    public int countFinishWorksByProjectId(int projectId) {
        return mybatis.selectOne("works.countFinishWorksByProjectId", projectId);
    }

    public void updateState(String state, int workItemId) {

        Map<String, Object> params = new HashMap<>();
        params.put("state", state);
        params.put("workId", workItemId);
        mybatis.update("works.updateState", params);
    }

    public void deleteById(int workId) {
//        System.out.println("dao 도착" + workId);
        mybatis.delete("works.deleteById", workId);
    }

    public ProjectWorkDTO selectByworksId(int id) {
        return mybatis.selectOne("works.selectByworksId", id);
    }

    public void toggleState(int id) {
        // select * from POJECT_WORK WHERE id = ${id} => state값 추출

        // String changeValue = (state.eqauls("ON_GOING") ?  "FINISH" : "ON_GOING"
        // update PROJECT_WORK set state = #{state} where id = ${id}

        //아니면 값으로 string state 를 받는 방법도 있음
    }

    public int countByState(int selectedId, String state) {
        Map<String, Object> params = new HashMap<>();
        params.put("state", state);
        params.put("selectedId", selectedId);
        return mybatis.selectOne("works.countByState", params);

    }

    public int countByType(int selectedId, String type) {
Map<String, Object> params = new HashMap<>();
params.put("type", type);
params.put("selectedId", selectedId);
        return mybatis.selectOne("works.countByType", params);
    }
public int countTotalWorks(int selectedId) {
        return mybatis.selectOne("works.countTotalWorks", selectedId);
}
    public int countFinishedWorks(int selectedId) {
        return mybatis.selectOne("works.countFinishedWorks", selectedId);
    }


    public void endworks(int projectId) {
    }
}
