package com.end2end.spring.board.service;

import com.end2end.spring.board.dto.BoardCategoryDTO;

import java.util.List;

public interface BoardCategoryService {
    List<BoardCategoryDTO> selectAll();
    List<BoardCategoryDTO> selectByEmployeeId(String employeeId);
    void insertCategory(BoardCategoryDTO dto);
    void update(BoardCategoryDTO dto);
    void deleteById(int id);
//    BoardCategoryDTO selectCategoryBuId(int id);

    BoardCategoryDTO selectCategoryById(int categoryId);
}
