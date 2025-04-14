package com.end2end.spring.board.serviceImpl;

import com.end2end.spring.board.dao.BoardCategoryDAO;
import com.end2end.spring.board.dto.BoardCategoryDTO;
import com.end2end.spring.board.service.BoardCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardCategoryServiceImpl implements BoardCategoryService {

    @Autowired
    private BoardCategoryDAO boardCategoryDAO;
    @Override
    public BoardCategoryDTO selectCategoryById(int categoryId) {
        return boardCategoryDAO.selectCategoryById(categoryId);
    }

    @Override
    public List<BoardCategoryDTO> selectAll() {
           return boardCategoryDAO.selectAll();
        // TODO: 모든 카테고리 내용 조회

    }

    @Override
    public List<BoardCategoryDTO> selectByEmployeeId(String employeeId) {
        // TODO: 해당 사원의 카테고리 내용 조회
        return null;
    }

    @Override
    public void insertCategory(BoardCategoryDTO dto) {
        boardCategoryDAO.insertCategory(dto);
        // TODO: 카테고리 등록
    }

    @Override
    public void update(BoardCategoryDTO dto) {
        // TODO: 카테고리 수정
    }

    @Override
    public void deleteById(int id) {
        // TODO: 해당 id의 카테고리 삭제
    }
}
