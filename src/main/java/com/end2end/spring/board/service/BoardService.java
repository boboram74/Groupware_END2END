package com.end2end.spring.board.service;

import com.end2end.spring.board.dto.BoardCategoryDTO;
import com.end2end.spring.board.dto.BoardDTO;
import com.end2end.spring.board.dto.ComplaintDTO;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;
import java.util.Optional;

public interface BoardService {
    List<BoardDTO> selectAll();
    List<BoardDTO> selectByCategoryId(int categoryId, String employeeId);
    List<BoardDTO> selectImportant(String employeeId);
    List<BoardDTO> search();
    BoardDTO selectById(int id);
    void insert(BoardDTO dto);
    void update(BoardDTO dto);
    int deleteById(int id);
    void complaint(ComplaintDTO dto);
    void insertCategory(BoardCategoryDTO dto);
    BoardCategoryDTO selectCategoryById(int categoryId);
    List<BoardDTO> selectRecent();
}
