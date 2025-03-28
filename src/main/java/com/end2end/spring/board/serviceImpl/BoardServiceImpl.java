package com.end2end.spring.board.serviceImpl;

import com.end2end.spring.board.dto.BoardDTO;
import com.end2end.spring.board.dto.ComplaintDTO;
import com.end2end.spring.board.service.BoardService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardServiceImpl implements BoardService {
    @Override
    public List<BoardDTO> selectAll() {
        // TODO: 모든 게시글 조회
        return null;
    }

    @Override
    public List<BoardDTO> selectByCategoryId(int categoryId) {
        // TODO: 카테고리 번호의 모든 게시글 조회
        return null;
    }

    @Override
    public List<BoardDTO> selectImportant(String employeeId) {
        // TODO: 해당 사원의 중요 게시글 조회
        return null;
    }

    @Override
    public List<BoardDTO> search() {
        // TODO: 검색한 모든 게시글 조회
        return null;
    }

    @Override
    public BoardDTO selectById(int id) {
        // TODO: 해당 id의 게시글 조회
        return null;
    }

    @Override
    public void insert(BoardDTO dto) {
        // TODO: 게시글 입력
    }

    @Override
    public void update(BoardDTO dto) {
        // TODO: 게시글 수정
    }

    @Override
    public void deleteById(int id) {
        // TODO: 해당 id의 게시글 삭제
    }

    @Override
    public void complaint(ComplaintDTO dto) {
        // TODO: 게시글 신고 (insert)
    }
}
