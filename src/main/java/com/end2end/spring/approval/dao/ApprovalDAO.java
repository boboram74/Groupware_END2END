package com.end2end.spring.approval.dao;

import com.end2end.spring.approval.dto.ApprovalDTO;
import com.end2end.spring.approval.dto.ApprovalFormDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ApprovalDAO {

    @Autowired
    private SqlSession mybatis;

    public List<ApprovalDTO> toList(String state){

        return mybatis.selectList("approval.toList",state);
    }

    public void insert(ApprovalDTO dto){
        mybatis.insert("approval.insert", dto);

    }
    public List<Map<String, Object>> selectByState(String state, String employeeId) {
        Map<String, Object> map = new HashMap<>();
        map.put("state", state);
        map.put("employeeId", employeeId);

        return mybatis.selectList("approval.selectByState", map);
    }
    public Map<String, Object> selectById(String id) {
        return mybatis.selectOne("approval.selectById", id);
    }


    public void updateState(String id, String state) {
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("state", state);
        mybatis.update("approval.updateState", map);
    }

    public List<ApprovalFormDTO> selectFormList() {
        return mybatis.selectList("approval.selectFormList");
    }

    public ApprovalFormDTO selectByFormId(int id) {
        return mybatis.selectOne("approval.selectByFormId", id);
    }

    public List<Map<String, Object>> search(String state, String employeeId, String keyword) {
        Map<String, Object> map = new HashMap<>();
        map.put("state", state);
        map.put("employeeId", employeeId);
        map.put("keyword", keyword);

        return mybatis.selectList("approval.search", map);
    }

    public ApprovalDTO selectDTOById(String id) {
        return mybatis.selectOne("approval.selectDTOById", id);
    }

    public ApprovalFormDTO selectFormLikeName(String name) {
        return mybatis.selectOne("approval.selectFormLikeName", name);
    }

    public List<Map<String, Object>> searchDetail(Map<String, Object> paramMap) {
        Map<String, Object> params = new HashMap<>();

        params.put("form", paramMap.get("form"));
        params.put("state", paramMap.get("state"));
        params.put("drafter", paramMap.get("employeeName") != null ? paramMap.get("employeeName") : "");
        params.put("startDate", paramMap.get("startDate") != null ? paramMap.get("startDate").toString().substring(0, 10) : null);
        params.put("endDate", paramMap.get("endDate"));
        params.put("searchDetail", paramMap.get("searchDetail"));
        params.put("employeeId", paramMap.get("employeeId"));

        return mybatis.selectList("approval.searchDetail", params);
    }

    public ApprovalFormDTO selectByFormName(String name) {
        return mybatis.selectOne("approval.selectByFormName", name);
    }
    public String selectDepartmentNameById(String employeeId) {
        return mybatis.selectOne("approval.selectDepartmentNameById", employeeId);
    }

    public List<Map<String, Object>> allApprovals() {
        return mybatis.selectList("approval.allApprovals");
    }

}
