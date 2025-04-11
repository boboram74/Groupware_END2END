package com.end2end.spring.approval.dao;

import com.end2end.spring.approval.dto.ApprovalDTO;
import com.end2end.spring.approval.dto.ApprovalFormDTO;
import com.end2end.spring.employee.dto.EmployeeDTO;
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

    public ApprovalFormDTO selectFormLikeName(String name) {
        return mybatis.selectOne("approval.selectFormLikeName", "%" + name + "%");
    }
}
