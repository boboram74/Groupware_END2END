package com.end2end.spring.schedule.controller;

import com.end2end.spring.schedule.dto.BookDTO;
import com.end2end.spring.schedule.dto.BookInsertDTO;
import com.end2end.spring.schedule.service.BookService;
import com.end2end.spring.util.EventDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RequestMapping("/book")
@Controller
public class BookController {
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    @Autowired private BookService bookService;

    @RequestMapping("/list")
    public String toBook(Model model) {
        model.addAttribute("bookTargetList", bookService.selectAllTarget());

        return "schedule/book";
    }

    @RequestMapping("/search")
    public String toBookSearch(Model model) {
        return "schedule/book";
    }

    @ResponseBody
    @RequestMapping("/list/period")
    public List<EventDTO> selectByPeriod(String startDate, String endDate) {
        LocalDate parsedStartDate = LocalDate.parse(startDate, DATE_FORMATTER);
        LocalDate parsedEndDate = LocalDate.parse(endDate, DATE_FORMATTER);

        return bookService.selectByPeriod(parsedStartDate, parsedEndDate);
    }

    @ResponseBody
    @RequestMapping("/detail/{id}")
    public BookDTO detail(@PathVariable int id) {
        return bookService.selectById(id);
    }

    @RequestMapping("/insert")
    public String insert(BookInsertDTO dto) {
        bookService.insert(dto);
        return "redirect:/book/list";
    }

    @RequestMapping("/update")
    public String update(BookInsertDTO dto) {
        bookService.update(dto);
        return "redirect:/book/list";
    }

    @RequestMapping("/delete/{id}")
    public String delete(@PathVariable int id) {
        bookService.deleteById(id);
        return "redirect:/book/list";
    }
}
