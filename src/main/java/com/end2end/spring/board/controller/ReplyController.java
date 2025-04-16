package com.end2end.spring.board.controller;

import com.end2end.spring.board.dto.ReplyDTO;
import com.end2end.spring.board.service.ReplyService;
import com.end2end.spring.employee.dto.EmployeeDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@RequestMapping("/reply")
@Controller
public class ReplyController {
    @Autowired
    private ReplyService replyService;

    @RequestMapping("/list")
    @ResponseBody
    public List<ReplyDTO> list(@RequestParam("boardId") int boardId) {
        List<ReplyDTO> replyDTOList = replyService.selectByBoardId(boardId);
        return replyService.selectByBoardId(boardId);
        // TODO: 게시글 id로 댓글 조회
    }

    @RequestMapping("/insert")
    @ResponseBody
    public ResponseEntity<String> insert(HttpSession session, ReplyDTO dto) {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
        String employeeId = employee.getId();
        dto.setEmployeeId(employeeId);

        System.out.println("댓글 등록" + dto);
        replyService.insert(dto);
        //return "/board/list";
        // TODO: 댓글을 등록함
        return ResponseEntity.ok().build();
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
