package com.end2end.spring.board.controller;

import com.end2end.spring.board.dto.ReplyDTO;
import com.end2end.spring.board.service.ReplyService;
import com.end2end.spring.employee.dto.EmployeeDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@RequestMapping("/reply")
@Controller
public class ReplyController {
    @Autowired
    private ReplyService replyService;

    @RequestMapping("/list")
    @ResponseBody
    public List<ReplyDTO> list(@RequestParam("boardId") int boardId, HttpSession session) {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
//        System.out.println("dddd" + employee);
        List<ReplyDTO> replyList = replyService.selectByBoardId(boardId);
//        System.out.println("replies.size(): " + replyList.size()); // 이거 꼭 찍어봐!
        return replyList;

        // TODO: 게시글 id로 댓글 조회
    }

    @RequestMapping("/insert")
    @ResponseBody
    public ResponseEntity<String> insert(HttpSession session, ReplyDTO dto) {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
        String employeeId = employee.getId();
        dto.setEmployeeId(employeeId);

//        System.out.println("댓글 등록" + dto);
        replyService.insert(dto);
        //return "/board/list";
        // TODO: 댓글을 등록함
        return ResponseEntity.ok().build();
    }

    @RequestMapping("/update")
    public void update(ReplyDTO dto) {
        // TODO: 댓글을 수정함
    }

    @RequestMapping("/delete/{id}")
    @ResponseBody
    public boolean  deleteById(@PathVariable int id, HttpSession session) {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
        ReplyDTO reply = replyService.selectById(id);

//        System.out.println("로그인한 사용자 ID: " + employee.getId());
//        System.out.println("댓글 작성자 ID: " + reply.getEmployeeId());

        if (employee.getId().equals(reply.getEmployeeId())) {
//            System.out.println("댓글 삭제 진행 중... 댓글 ID: " + id); //삭제필요
//            System.out.println("성공");
            replyService.deleteById(id);
            return true;
        }
//        int result = replyService.deleteById(id);
        return false;
    }
}
