package com.end2end.spring.mail.serviceImpl;

import com.end2end.spring.mail.dto.TempMailDTO;
import com.end2end.spring.mail.service.TempMailService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TempMailServiceImpl implements TempMailService {
    @Override
    public List<TempMailDTO> selectByEmployeeId(String employeeId) {
        // TODO: 해당 id의 직원의 모든 임시 저장 메일 출력
        return null;
    }

    @Override
    public void insert(TempMailDTO tempMailDTO) {
        // TODO: 임시 저장 메일 추가
    }

    @Override
    public void update(TempMailDTO tempMailDTO) {
        // TODO: 임시 저장 메일 수정
    }

    @Override
    public void deleteById(int id) {
        // TODO: 해당 id의 임시 저장 메일 삭제
    }

    @Override
    public void deleteAll(String employeeId) {
        // TODO: 해당 id의 사원의 모든 임시 저장 메일 삭제
    }
}