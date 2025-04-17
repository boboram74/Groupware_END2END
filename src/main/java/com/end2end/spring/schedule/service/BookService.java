package com.end2end.spring.schedule.service;

import com.end2end.spring.schedule.dto.BookDTO;
import com.end2end.spring.schedule.dto.BookInsertDTO;
import com.end2end.spring.schedule.dto.BookTargetDTO;
import com.end2end.spring.util.EventDTO;

import java.time.LocalDate;
import java.util.List;

public interface BookService {
    List<BookTargetDTO> selectAllTarget();
    List<EventDTO> selectByPeriod(LocalDate startDate, LocalDate endDate);
    List<BookDTO> selectAll();
    List<BookDTO> search();
    BookDTO selectById(int id);
    BookDTO selectDateAndTarget(LocalDate date, String targetType, int targetId);
    void insert(BookInsertDTO dto);
    void update(BookInsertDTO dto);
    void deleteById(int id);
    boolean isReserved(BookDTO dto);
}
