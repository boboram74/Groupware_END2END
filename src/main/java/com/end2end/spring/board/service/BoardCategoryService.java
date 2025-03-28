package com.end2end.spring.board.service;

import com.end2end.spring.board.dto.BoardCategoryDTO;

import java.util.List;

public interface BoardCategoryService {
    List<BoardCategoryDTO> selectAll();
    List<BoardCategoryDTO> selectByCategoryId(int categoryId);
    List<BoardCategoryDTO> selectByEmployeeId(String employeeId);
    void insert(BoardCategoryDTO dto);
    void update(BoardCategoryDTO dto);
    void deleteById(int id);
}
