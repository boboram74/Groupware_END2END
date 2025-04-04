package com.end2end.spring.employee.serviceImpl;

import com.end2end.spring.employee.dao.EmployeeDAO;
import com.end2end.spring.employee.dto.*;
import com.end2end.spring.employee.service.EmployeeService;
import com.end2end.spring.mail.dao.MailDAO;
import com.end2end.spring.util.SecurityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeDAO employeeDAO;

    @Autowired
    private MailDAO mailDAO;

    @Override
    public EmployeeDTO selectById(String id) {
        // TODO: 해당 id의 사원 출력
        return null;
    }

    @Override
    public EmployeeDetailDTO selectDetailById(String employeeId) {
        // TODO: 해당 id의 사원 상세정보 조회
        return employeeDAO.selectDetailById(employeeId);
    }

    @Override
    public EmployeeDTO  login(LoginDTO dto) {
        String password = SecurityUtil.hashPassword(dto.getPassword());
        dto.setPassword(password);

        return employeeDAO.login(dto);
    }

    @Override
    public void logout() {
        // TODO: 로그아웃
    }

    @Transactional
    @Override
    public void insert(EmployeeDetailDTO dto, MultipartFile file) {
        // TODO: 사원 등록
        // employee insert 사원 테이블 추가
        String hashedPassword = SecurityUtil.hashPassword(dto.getPassword());
        dto.setPassword(hashedPassword);
        EmployeeDTO employeeDTO = EmployeeDTO.builder()
                .departmentId(dto.getDepartmentId())
                .jobId(dto.getJobId())
                .name(dto.getName())
                .email(dto.getEmail())
                .profileImg(dto.getProfileImg())
                .contact("010-1234-1234")
                .build();
        employeeDAO.insert(employeeDTO);
        String employeeId = employeeDTO.getId();

        // employee_detail insert 사원 상세 테이블 추가
        dto.setId(employeeId);
        employeeDAO.insertDetail(dto);

        // email_addreses 사원의 이메일을 추가


    }

    @Override
    public boolean idVali(String loginId){
        return employeeDAO.idVali(loginId);
    }

    @Override
    public void update(EmployeeDetailDTO dto) {
        // TODO: 사원 수정
    }

    @Override
    public void deleteById(String id) {
        // TODO: 해당 id의 사원 삭제
    }

    @Override
    public List<EmployeeDTO> selectByDepartmentId(int departmentId) {
        return employeeDAO.selectByDepartmentId(departmentId);
    }

    @Override
    public List<DepartmentDTO> selectAllDepartment() {
        return employeeDAO.selectAllDepartment();
    }

    @Override
    public List<JobDTO> selectAllJob() {
        return employeeDAO.selectAllJob();
    }
}
