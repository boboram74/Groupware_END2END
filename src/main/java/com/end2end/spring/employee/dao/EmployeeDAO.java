package com.end2end.spring.employee.dao;

import com.end2end.spring.employee.dto.*;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class EmployeeDAO {

    @Autowired
    private SqlSession mybatis;

    public List<EmployeeDTO> selectAll() {
        return mybatis.selectList("employee.selectAll");
    }

    public void insert(EmployeeDTO dto) {
        mybatis.insert("employee.insert", dto);
    }

    public void insertDetail(EmployeeDetailDTO dto) {
        mybatis.insert("employee.insertDetail", dto);
    }

    public List<EmployeeDTO> selectByDepartmentId(int departmentId) {
        return mybatis.selectList("employee.selectByDepartmentId", departmentId);
    }

    public List<DepartmentDTO> selectAllDepartment() {
        return mybatis.selectList("employee.selectAllDepartment");
    }

    public List<JobDTO> selectAllJob() {
        return mybatis.selectList("employee.selectAllJob");
    }

    public EmployeeDTO login(LoginDTO dto) {
        return mybatis.selectOne("employee.login", dto);
    }

    public EmployeeDetailDTO selectDetailById(String employeeId) {
        return mybatis.selectOne("employee.selectDetailById", employeeId);
    }

    public EmployeeDTO selectJobById(String id) {
        return mybatis.selectOne("employee.selectJobById", id);
    }

    public boolean idVali(String loginId) {
        Integer count = mybatis.selectOne("employee.idVali", loginId);
        return count != null && count > 0;
    }

    public boolean pwVali(String currentPw) {
//        System.out.println(currentPw);
        Integer count = mybatis.selectOne("employee.pwVali", currentPw);
        if (count != null && count > 0) {
            return true;
        }
        return false;
    }

    public void roleUpdate(String id, String role) {
        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        param.put("role", role);
        mybatis.update("employee.roleUpdate", param);
    }

    public void deleteById(String id) {
        mybatis.delete("employee.deleteById", id);
    }

    public List<EmployeeDTO> selectContactList() {
        return mybatis.selectList("employee.selectContactList");
    }

    public int countNoAuth() {
        return mybatis.selectOne("employee.countNoAuth");
    }

    public List<EmployeeDTO> selectByThisMonthBirthday() {
        return mybatis.selectList("employee.selectByThisMonthBirthday");
    }

    public void update(EmployeeDTO dto) {
        mybatis.update("employee.update", dto);
    }

    public void updateDetail(EmployeeDetailDTO dto) {
        mybatis.update("employee.updateDetail", dto);
    }

    public void changePw(String newPw,String id) {
        Map<String, Object> param = new HashMap<>();
        param.put("newPw", newPw);
        param.put("id", id);
        mybatis.update("employee.changePw", param);
    }

    public List<EmployeeDTO> selectByIdIn(List<String> ids) {
        return mybatis.selectList("employee.selectByIdIn", ids);
    }

    public void isResigned(String id) {mybatis.update("employee.isResigned",id);}

    public List<Map<String,Object>> employeeAll(){
        return mybatis.selectList("employee.employeeAll");
    }

    public List<Map<String, Object>> getMonthlyStats() {
        return mybatis.selectList("employee.monthlyStats");
    }

    public String findByLoginId(String id) {
        return mybatis.selectOne("employee.findByLoginId", id);
    }

    public List<Map<String, Object>> getVacationStats() {
        return mybatis.selectList("employee.vacationStats");
    }

    public List<Map<String, Object>> getAttendanceStats() {
        return mybatis.selectList("employee.attendanceStats");
    }

    public List<EmployeeDTO> selectFromTo(int start, int end) {
        Map<String, Object> param = new HashMap<>();
        param.put("start", start);
        param.put("end", end);

        return mybatis.selectList("employee.selectFromTo", param);
    }

    public List<EmployeeDTO> searchContactList(String searchOption, String keyword) {
        Map<String, Object> param = new HashMap<>();
        param.put("searchOption", searchOption);
        param.put("keyword", keyword);
        return mybatis.selectList("employee.searchContactList", param);
    }

    public List<EmployeeDTO> searchContactListFromTo(String searchOption, String keyword, int start, int end) {
        Map<String, Object> param = new HashMap<>();
        param.put("searchOption", searchOption);
        param.put("keyword", keyword);
        param.put("start", start);
        param.put("end", end);
        return mybatis.selectList("employee.searchContactList", param);
    }

    public List<EmployeeDTO> searchEmployeeList(String searchOption, String keyword) {
        Map<String, Object> param = new HashMap<>();
        param.put("searchOption", searchOption);
        param.put("keyword", keyword);
        return mybatis.selectList("employee.searchEmployeeList", param);
    }

    public List<DepartmentDTO> selectByDepartmentList() {
        return mybatis.selectList("employee.selectByDepartmentList");
    }

    public void insertDepartment(String name, String email) {
        Map<String, Object> param = new HashMap<>();
        param.put("name", name);
        param.put("email", email);
        mybatis.insert("employee.insertDepartment", param);
    }

    public int existsById(Integer id) {
        return mybatis.selectOne("employee.existsById", id);
    }

    public void updateDepartment(Integer id, String name, String email) {
        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        param.put("name", name);
        param.put("email", email);
        mybatis.update("employee.updateDepartment", param);
    }

    public void deleteByDepartmentId(int id) {
        mybatis.delete("employee.deleteByDepartmentId", id);
    }

    public List<RoleListDTO> loadSettingList() {
        return mybatis.selectList("employee.loadSettingList");
    }

    public void updateRole(String employeeId, String role) {
        Map<String, Object> param = new HashMap<>();
        param.put("employeeId", employeeId);
        param.put("role", role);
        mybatis.update("employee.updateRole", param);
    }
}
