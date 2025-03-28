package com.end2end.spring.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/member")
@Controller
public class MemberController {
    @RequestMapping("/login")
    public void login() {}

    @RequestMapping("/logout")
    public void logout() {}


    @RequestMapping("/update")
    public void update() {}

    @RequestMapping("/insert")
    public void insert() {}

    @RequestMapping("/delete")
    public void delete() {}

    @RequestMapping("/mypage")
    public String mypage(Model model) {
        return "";
    }
}
