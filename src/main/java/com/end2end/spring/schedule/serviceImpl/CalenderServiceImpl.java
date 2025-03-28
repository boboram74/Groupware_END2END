package com.end2end.spring.schedule.serviceImpl;

import com.end2end.spring.schedule.dto.CalenderDTO;
import com.end2end.spring.schedule.service.CalenderService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CalenderServiceImpl implements CalenderService {
    @Override
    public List<CalenderDTO> selectByEmployeeId(String employeeId) {
        // TODO: 해당 id의 사원의 모든 일정을 출력
        return null;
    }

    @Override
    public List<CalenderDTO> search() {
        // TODO: 검색 결과에 따른 모든 일정을 출력
        return null;
    }

    @Override
    public CalenderDTO selectById(int id) {
        // TODO: 해당 id의 일정을 출력
        return null;
    }

    @Override
    public void insert(CalenderDTO dto) {
        // TODO: 일정을 추가
    }

    @Override
    public void update(CalenderDTO dto) {
        // TODO: 일정을 수정
    }

    @Override
    public void deleteById(int id) {
        // TODO: 해당 id에 해당하는 일정을 삭제
    }
}
