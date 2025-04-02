package com.end2end.spring.employee.serviceImpl;

import com.end2end.spring.employee.dao.EmployeeDAO;
import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.employee.dto.EmployeeDetailDTO;
import com.end2end.spring.employee.dto.LoginDTO;
import com.end2end.spring.employee.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
public class EmployeeServiceImpl implements EmployeeService {
    @Autowired
    private EmployeeDAO employeeDAO;
    // @Autowired private EmailDAO

    @Override
    public EmployeeDTO selectById(String id) {
        // TODO: 해당 id의 사원 출력
        return null;
    }

    @Override
    public EmployeeDetailDTO selectDetailById(String id) {
        // TODO: 해당 id의 상세 사원 데이터 출력
        return null;
    }

    @Override
    public void login(LoginDTO dto) {
        // TODO: 로그인
    }

    @Override
    public void logout() {
        // TODO: 로그아웃
    }

    @Transactional
    @Override
    public void insert(EmployeeDetailDTO dto, MultipartFile file) {
        // TODO: 사원 등록
        // employee <- insert employeeId 1번
        EmployeeDTO employeeDTO = EmployeeDTO.builder()
                .departmentId(dto.getDepartmentId())
                .jobId(dto.getJobId())
                .name(dto.getName())
                .email(dto.getEmail())
                .profileImg(dto.getProfileImage())
                .build();
        employeeDAO.insert(employeeDTO);

        String employeeId = employeeDTO.getId();  // 방금 만든 사번

        // 2번
        dto.setId(employeeId);
    }

    @Override
    public void update(EmployeeDetailDTO dto) {
        // TODO: 사원 수정
    }

    @Override
    public void deleteById(String id) {
        // TODO: 해당 id의 사원 삭제
    }
}
