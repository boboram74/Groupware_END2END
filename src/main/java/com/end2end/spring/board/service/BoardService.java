package com.end2end.spring.board.service;

import com.end2end.spring.board.dto.BoardDTO;
import com.end2end.spring.board.dto.ComplaintDTO;

import java.util.List;
import java.util.Optional;

public interface BoardService {
    List<BoardDTO> selectAll();
    List<BoardDTO> selectByCategoryId(int categoryId);
    List<BoardDTO> selectImportant(String employeeId);
    List<BoardDTO> search();
    BoardDTO selectById(int id);
    void insert(BoardDTO dto);
    void update(BoardDTO dto);
    void deleteById(int id);
    void complaint(ComplaintDTO dto);
}
