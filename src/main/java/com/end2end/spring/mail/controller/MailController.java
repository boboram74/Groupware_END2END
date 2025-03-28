package com.end2end.spring.mail.controller;

import com.end2end.spring.mail.dto.MailDTO;
import com.end2end.spring.mail.dto.MailTempDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/mail")
@Controller
public class MailController {
    @RequestMapping("/list")
    public String toList(int employeeId, Model model) {
        // TODO: 해당 사원의 모든 메일을 출력하는 list.jsp
        return "/mail/list";
    }

    @RequestMapping("/list/search")
    public String toSearch(int employeeId, Model model) {
        // TODO: 해당 사원의 검색내용의 메일을 출력하는 list.jsp
        return "/mail/list";
    }

    @RequestMapping("/list/important")
    public String toImportant(int employeeId, Model model) {
        // TODO: 해당 사원의 중요 메일을 출력하는 list.jsp
        return "/mail/list";
    }

    @RequestMapping("/list/temp")
    public String toTemp(Model model) {
        // TODO: 해당 사원의 임시 저장된 메일을 출력하는 list.jsp
        return "/mail/list";
    }

    @RequestMapping("/write")
    public String toWrite(Model model) {
        // TODO: 메일 작성 폼으로 이동
        return "/mail/write";
    }

    @RequestMapping("/detail")
    public String toDetail(int id, Model model) {
        // TODO: 해당 id의 메일 상세 조회 폼으로 이동
        return "/mail/detail";
    }

    @RequestMapping("/insert")
    public void insert(MailDTO dto) {
        // TODO: 메일을 송신함
    }

    @RequestMapping("/temp/insert")
    public void insertTemp(MailTempDTO dto) {
        // TODO: 메일을 임시 저장함
    }

    @RequestMapping("/temp/update")
    public void update(MailTempDTO dto) {
        // TODO: 임지 저장 메일을 수정함
    }

    @RequestMapping("/delete")
    public void deleteById(int id) {
        // TODO: 해당 id의 메일을 삭제함
    }

    @RequestMapping("/trashcan")
    public void toggleTrashCanYN(int id) {
        // TODO: 해당 id의 메일의 휴지통으로 보내기/ 돌려놓기
    }
}
