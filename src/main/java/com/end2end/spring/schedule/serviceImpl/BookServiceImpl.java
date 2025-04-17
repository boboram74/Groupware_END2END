package com.end2end.spring.schedule.serviceImpl;

import com.end2end.spring.schedule.dto.BookDTO;
import com.end2end.spring.schedule.dto.CalendarDTO;
import com.end2end.spring.schedule.service.BookService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookServiceImpl implements BookService {
    @Override
    public List<BookDTO> selectAll() {
        // TODO: 모든 예약을 출력
        return null;
    }

    @Override
    public List<BookDTO> search() {
        // TODO: 검색 결과에 따른 예약을 출력
        return null;
    }

    @Override
    public BookDTO selectById(int id) {
        // TODO: 해당 id의 예약을 출력
        return null;
    }

    @Override
    public void insert(CalendarDTO dto) {
        // TODO: 예약 등록
    }

    @Override
    public void update(CalendarDTO dto) {
        // TODO: 예약 수정
    }

    @Override
    public void deleteById(int id) {
        // TODO: 해당 id의 모든 예약 삭제
    }

    @Override
    public boolean isReserved(int itemId) {
        return false;
    }
}
