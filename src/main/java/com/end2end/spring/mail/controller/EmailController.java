package com.end2end.spring.mail.controller;

import com.end2end.spring.mail.dto.EmailDTO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@RequestMapping("/email")
@Controller
public class EmailController {

    @RequestMapping("/list")
    public String list() {
        // TODO: 모든 등록된 이메일을 출력
        return "mail/list";
    }
    
    @RequestMapping("/{email}")
    public void email(@PathVariable String email) {
        // TODO: 해당 이메일을 가져옴
    }
    
    @RequestMapping("/insert")
    public void insert(EmailDTO dto) {
        // TODO: 이메일 등록함
    }
    
    @RequestMapping("/update")
    public void update(EmailDTO dto) {
        // TODO: 이메일 수정함
    }
    
    @RequestMapping("/delete")
    public void deleteByEmail(String email) {
        // TODO: 해당 이메일을 삭제함
    }
}
