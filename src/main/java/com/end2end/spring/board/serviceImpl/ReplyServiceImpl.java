package com.end2end.spring.board.serviceImpl;

import com.end2end.spring.board.dao.ReplyDAO;
import com.end2end.spring.board.dto.ReplyDTO;
import com.end2end.spring.board.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReplyServiceImpl implements ReplyService {

    @Autowired
    private ReplyDAO replyDAO;

    @Override
    public List<ReplyDTO> selectByBoardId(int boardId) {
        return replyDAO.selectByBoardId(boardId);
        // TODO: 게시글 id의 모든 댓글 조회

    }

    @Override
    public void insert(ReplyDTO dto) {
        replyDAO.insert(dto);

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
