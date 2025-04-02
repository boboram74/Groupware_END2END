package com.end2end.spring.mail.controller;

import com.end2end.spring.mail.dto.MailListDTO;
import com.end2end.spring.mail.dto.TempMailDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/inbox")
@Controller
public class InboxController {
    @RequestMapping("/list")
    public void toListByEmployee(String employeeId, Model model) {
        // TODO: 해당 사원의 모든 메일을 출력하는 list.jsp
    }

    @RequestMapping("/list/{email}")
    public String toListByEmail(@PathVariable String email, Model model) {
        // TODO: 해당 이메일의 모든 메일을 출력하는 list.jsp
        return "/mail/list";
    }

    @RequestMapping("/list/search")
    public String toSearch(String email, Model model) {
        // TODO: 해당 이메일의 검색내용의 메일을 출력하는 list.jsp
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

    @RequestMapping("/{id}")
    public String toDetail(@PathVariable int id, Model model) {
        // TODO: 해당 id의 메일 상세 조회 폼으로 이동
        return "/mail/detail";
    }

    @RequestMapping("/insert")
    public void insert(MailListDTO dto) {
        // TODO: 메일을 송신함
    }

    @RequestMapping("/temp/insert")
    public void insertTemp(TempMailDTO dto) {
        // TODO: 메일을 임시 저장함
    }

    @RequestMapping("/temp/update")
    public void update(TempMailDTO dto) {
        // TODO: 임지 저장 메일을 수정함
    }

    @RequestMapping("/delete/{id}")
    public void deleteById(@PathVariable int id) {
        // TODO: 해당 id의 메일을 삭제함
    }

    @RequestMapping("/trashcan/{id}")
    public void toggleTrashCanYN(@PathVariable int id) {
        // TODO: 해당 id의 메일의 휴지통으로 보내기/ 돌려놓기
    }
}
