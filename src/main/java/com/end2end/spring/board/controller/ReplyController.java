package com.end2end.spring.board.controller;

import com.end2end.spring.board.dto.ReplyDTO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/reply")
@Controller
public class ReplyController {
    @RequestMapping("/list")
    public void list(int boardId) {
        // TODO: 게시글 id로 댓글 조회
    }

    @RequestMapping("/insert")
    public void insert(ReplyDTO dto) {
        // TODO: 댓글을 등록함
    }

    @RequestMapping("/update")
    public void update(ReplyDTO dto) {
        // TODO: 댓글을 수정함
    }

    @RequestMapping("/delete")
    public void deleteById(int id) {
        // TODO: 해당 댓글 id로 삭제
    }
}
