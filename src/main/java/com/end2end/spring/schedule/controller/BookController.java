package com.end2end.spring.schedule.controller;

import com.end2end.spring.schedule.dto.BookDTO;
import com.end2end.spring.schedule.dto.BookInsertDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@RequestMapping("/book")
@Controller
public class BookController {
    @RequestMapping("/list")
    public String toBook(Model model) {
        return "schedule/book";
    }

    @RequestMapping("/search")
    public String toBookSearch(Model model) {
        return "schedule/book";
    }

    @ResponseBody
    @RequestMapping("/detail/{id}")
    public BookDTO detail(@PathVariable int id) {
        return BookDTO.builder().build();
    }

    @RequestMapping("/insert")
    public String insert(BookInsertDTO dto) {
        return "redirect:/book/list";
    }

    @RequestMapping("/update")
    public String update(BookInsertDTO dto) {
        return "redirect:/book/list";
    }

    @RequestMapping
    public String delete() {
        return "redirect:/book/list";
    }
}
