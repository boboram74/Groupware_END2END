package com.end2end.spring.main.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class ErrorController {
    @ExceptionHandler(NoHandlerFoundException.class)
    public String handleNotFound(Model model) {
        model.addAttribute("state", 404);
        model.addAttribute("message", "요청하신 페이지를 찾을 수 없습니다.");

        return "/main/error";
    }
}
