package com.end2end.spring.mail.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/mail")
@Controller
public class MailController {
    @RequestMapping("/list")
    public String list(Model model) {
        return "";
    }

    @RequestMapping("/list/search")
    public String search(Model model) {
        return "";
    }

    @RequestMapping("/list/important")
    public String important() {
        return "";
    }

    @RequestMapping("/list/temp")
    public String temp(Model model) {
        return "";
    }

    @RequestMapping("/write")
    public String write(Model model) {
        return "";
    }

    @RequestMapping("/detail")
    public String detail(Model model) {
        return "";
    }

    @RequestMapping("/insert")
    public void insert() {}

    @RequestMapping("/update")
    public void update() {}

    @RequestMapping("/delete")
    public void delete() {}
}
