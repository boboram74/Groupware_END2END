package com.end2end.spring.board.service;

import com.end2end.spring.board.dto.NoticeDTO;

import java.util.List;

public interface NoticeService {
    List<NoticeDTO> selectAll();
    List<NoticeDTO> selectAll(int page);
    List<NoticeDTO> selectByCategoryId(int categoryId);
    List<NoticeDTO> selectByCategoryId(int categoryId, int page);
    NoticeDTO selectById(int id);
    void insert(NoticeDTO dto);
    void update(NoticeDTO dto);
    void deleteById(int id);
    List<NoticeDTO> selectRecent();
    List<NoticeDTO> selectRecentByCategoryId(int categoryId);
}
