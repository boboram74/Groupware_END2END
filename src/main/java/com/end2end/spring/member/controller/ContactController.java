package com.end2end.spring.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/contact")
@Controller
public class ContactController {
    @RequestMapping("/home")
    public String home(Model model) {
        return "";
    }
}
