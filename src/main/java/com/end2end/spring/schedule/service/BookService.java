package com.end2end.spring.schedule.service;

import com.end2end.spring.schedule.dto.BookDTO;
import com.end2end.spring.schedule.dto.CalendarDTO;

import java.util.List;

public interface BookService {
    List<BookDTO> selectAll();
    List<BookDTO> search();
    BookDTO selectById(int id);
    void insert(CalendarDTO dto);
    void update(CalendarDTO dto);
    void deleteById(int id);
    boolean isReserved(int itemId);
}
