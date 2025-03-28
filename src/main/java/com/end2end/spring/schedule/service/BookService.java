package com.end2end.spring.schedule.service;

import com.end2end.spring.schedule.dto.BookDTO;
import com.end2end.spring.schedule.dto.CalenderDTO;

import java.util.List;

public interface BookService {
    List<BookDTO> selectAll();
    List<BookDTO> search();
    BookDTO selectById(int id);
    void insert(CalenderDTO dto);
    void update(CalenderDTO dto);
    void deleteById(int id);
}
