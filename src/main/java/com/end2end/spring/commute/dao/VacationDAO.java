package com.end2end.spring.commute.dao;

import com.end2end.spring.commute.dto.GetVacationDTO;
import com.end2end.spring.commute.dto.SelectPeriodDTO;
import com.end2end.spring.commute.dto.VacationDTO;
import com.end2end.spring.commute.dto.VacationManagementDTO;
import com.end2end.spring.employee.dto.EmployeeDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class VacationDAO {
    @Autowired
    private SqlSession mybatis;

    public List<EmployeeDTO> selectNotCurrentVacation(List<EmployeeDTO> employeeIds) {
        return mybatis.selectList("vacation.selectNotCurrentVacation", employeeIds);
    }

    public List<EmployeeDTO> selectNotTodayVacation(List<EmployeeDTO> employeeIds) {
        return mybatis.selectList("vacation.selectNotTodayVacation", employeeIds);
    }

    public void insert(VacationDTO dto) {
        mybatis.insert("vacation.insert", dto);
    }

    public void insertUsableVacation(VacationManagementDTO dto) {
        mybatis.insert("vacation.insertUsableVacation", dto);
    }

    public double sumTotalVacationDates(String employeeId) {
        return mybatis.selectOne("vacation.sumTotalVacationDates", employeeId);
    }

    public double sumTotalUsedVacationDates(String employeeId) {
        return mybatis.selectOne("vacation.sumTotalUsedVacationDates", employeeId);
    }

    public double sumUsedThisMonthVacationDates(String employeeId){
        return mybatis.selectOne("vacation.sumUsedThisMonthVacationDates", employeeId);
    }

    public int isOnVacation(String employeeId) {
        return mybatis.selectOne("vacation.isOnVacation", employeeId);
    }

    public List<VacationDTO> selectByPeriod(SelectPeriodDTO dto) {
        return mybatis.selectList("vacation.selectByPeriod", dto);
    }

    public List<VacationDTO> selectByEmployeeId(String employeeId) {
        return mybatis.selectList("vacation.selectByEmployeeId", employeeId);
    }

    public List<GetVacationDTO> selectGetVacationForHired1st() {
        return mybatis.selectList("vacation.selectGetVacationForHired1st");
    }

    public List<GetVacationDTO> selectGetVacationList() {
        return mybatis.selectList("vacation.selectGetVacationList");
    }

    public VacationDTO selectByApprovalId(String approvalId) {
        return mybatis.selectOne("vacation.selectByApprovalId", approvalId);
    }
}
