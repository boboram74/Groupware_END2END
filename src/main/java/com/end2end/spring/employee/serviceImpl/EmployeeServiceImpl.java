package com.end2end.spring.employee.serviceImpl;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.employee.dto.EmployeeDetailDTO;
import com.end2end.spring.employee.dto.LoginDTO;
import com.end2end.spring.employee.service.EmployeeService;
import org.springframework.stereotype.Service;

@Service
public class EmployeeServiceImpl implements EmployeeService {
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

    @Override
    public void insert(EmployeeDetailDTO dto) {
        // TODO: 사원 등록
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
