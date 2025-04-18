package com.end2end.spring.board.serviceImpl;

import com.end2end.spring.alarm.AlarmService;
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

    @Autowired private AlarmService alarmService;

    @Override
    public List<ReplyDTO> selectByBoardId(int boardId) {
        return replyDAO.selectByBoardId(boardId);
        // TODO: 게시글 id의 모든 댓글 조회

    }

    @Override
    public void insert(ReplyDTO dto) {
        replyDAO.insert(dto);
        alarmService.sendAddReplyAlarm(dto.getBoardId());
    }

    @Override
    public void update(ReplyDTO dto) {
        // TODO: 댓글 수정
    }

    @Override
    public int deleteById(int id) {
        return replyDAO.deleteById(id);
        // TODO: 해당 id의 댓글 삭제
    }

    @Override
    public ReplyDTO selectById(int id) {
        return replyDAO.selectById(id);
    }
}
