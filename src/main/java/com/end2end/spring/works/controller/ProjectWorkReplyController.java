package com.end2end.spring.works.controller;

import com.end2end.spring.works.dto.ProjectWorkReplyDTO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@RequestMapping("/workreply")
@Controller
public class ProjectWorkReplyController {

    @RequestMapping("/list")
    public void list(int projectworkId) {
        // TODO: 프로젝트 작업id로 댓글 조회
    }

    @RequestMapping("/insert")
    public void insert(ProjectWorkReplyDTO dto) {
        // TODO: 댓글을 등록함
    }

    @RequestMapping("/update")
    public void update(ProjectWorkReplyDTO dto) {
        // TODO: 댓글을 수정함
    }

    @RequestMapping("/delete")
    public void deleteById(int id) {
        // TODO: 해당 댓글 id로 삭제
    }


}



