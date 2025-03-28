package com.end2end.spring.board.serviceImpl;

import com.end2end.spring.board.dto.BoardCategoryDTO;
import com.end2end.spring.board.service.BoardCategoryService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardCategoryServiceImpl implements BoardCategoryService {
    @Override
    public List<BoardCategoryDTO> selectAll() {
        // TODO: 모든 카테고리 내용 조회
        return null;
    }

    @Override
    public List<BoardCategoryDTO> selectByEmployeeId(String employeeId) {
        // TODO: 해당 사원의 카테고리 내용 조회
        return null;
    }

    @Override
    public void insert(BoardCategoryDTO dto) {
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
