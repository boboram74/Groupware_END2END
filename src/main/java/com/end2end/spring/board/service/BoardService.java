package com.end2end.spring.board.service;

import com.end2end.spring.board.dto.BoardCategoryDTO;
import com.end2end.spring.board.dto.BoardDTO;
import com.end2end.spring.board.dto.BoardUpdateDTO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface BoardService {
    List<BoardDTO> selectAll();
    List<BoardDTO> selectAll(int page);
    List<BoardDTO> selectByCategoryId(int categoryId, String employeeId);
    List<BoardDTO> selectImportant(String employeeId);
    List<BoardDTO> search(String option, String keyword);
    BoardDTO selectById(int id);
    void insert(MultipartFile[] files, BoardDTO dto) throws Exception;
    void update(MultipartFile[] files, BoardUpdateDTO dto);
    int deleteById(int id);

    void insertCategory(BoardCategoryDTO dto);
    BoardCategoryDTO selectCategoryById(int categoryId);
    List<BoardDTO> selectRecent();
}
