package com.end2end.spring.board.serviceImpl;

import com.end2end.spring.board.dto.ReplyDTO;
import com.end2end.spring.board.service.ReplyService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReplyServiceImpl implements ReplyService {
    @Override
    public List<ReplyDTO> selectByBoardId(int id) {
        // TODO: 게시글 id의 모든 댓글 조회
        return null;
    }

    @Override
    public void insert(ReplyDTO dto) {
        // TODO: 댓글 등록
    }

    @Override
    public void update(ReplyDTO dto) {
        // TODO: 댓글 수정
    }

    @Override
    public void deleteById(int id) {
        // TODO: 해당 id의 댓글 삭제
    }
}
