package com.end2end.spring.main.controller;

import com.end2end.spring.util.UnauthorizedException;
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
        model.addAttribute("description", 
                "요청하신 페이지가 삭제되었거나 일시적으로 사용할 수 없습니다.<br> 입력하신 주소가 정확한지 다시 한 번 확인해 주세요.");

        return "/main/error";
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public String handleIllegalArgumentException(Model model) {
        model.addAttribute("state", 400);
        model.addAttribute("message", "잘못된 값이 입력되었습니다.");
        model.addAttribute("description",
                "해당 요청에 유효한 값이 입력되지 않았습니다.<br> 입력하신 값이 정확한지 확인해주세요.");

        return "/main/error";
    }

    @ExceptionHandler(NumberFormatException.class)
    public String handleNumberFormatException(Model model) {
        model.addAttribute("state", 400);
        model.addAttribute("message", "잘못된 값이 입력되었습니다.");
        model.addAttribute("description",
                "해당 요청에 유효한 값이 입력되지 않았습니다.<br> 입력하신 값이 정확한지 확인해주세요.");

        return "/main/error";
    }

    @ExceptionHandler(NullPointerException.class)
    public String handleNullPointerException(Model model) {
        model.addAttribute("state", 400);
        model.addAttribute("message", "잘못된 값이 입력되었습니다.");
        model.addAttribute("description",
                "해당 요청에 유효한 값이 입력되지 않았습니다.<br> 입력하신 값이 정확한지 확인해주세요.");

        return "/main/error";
    }

    @ExceptionHandler(UnauthorizedException.class)
    public String handleNoAuthIntercept(Model model) {
        model.addAttribute("state", 401);
        model.addAttribute("message", "해당 요청으로의 접근 권한이 없습니다.");
        model.addAttribute("description",
                "해당 요청에 대한 접근 권한이 없습니다.<br> 입력하신 주소가 아닌 다른 서비스를 사용해 주십시오.");

        return "/main/error";
    }

    @ExceptionHandler(Exception.class)
    public String handleException(Model model) {
        model.addAttribute("state", 500);
        model.addAttribute("message", "서버가 요청을 수행하지 못했습니다.");
        model.addAttribute("description",
                "서버가 해당 요청의 수행을 실패했습니다. ㅈㅅㅎㅎ");

        return "/main/error";
    }
}

