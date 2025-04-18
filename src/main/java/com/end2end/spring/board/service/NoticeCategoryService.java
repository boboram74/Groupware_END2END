package com.end2end.spring.board.service;

import com.end2end.spring.board.dto.NoticeCategoryDTO;

import java.util.List;

public interface NoticeCategoryService {
    List<NoticeCategoryDTO> selectAll();
    NoticeCategoryDTO selectById(int id);
    void insert(NoticeCategoryDTO dto);
    void update(NoticeCategoryDTO dto);
    void deleteById(int id);
}
