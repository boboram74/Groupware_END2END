package com.end2end.spring.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	@GetMapping("/")
	public String home() {
		return "main/index";
	}

	@RequestMapping("/mypage/{employeeId}")
	public String toMyPage(@PathVariable String employeeId, Model model) {
		// TODO: 해당 사원의 마이페이지로 이동
		return "main/mypage";
	}

	@RequestMapping("/contact")
	public String contact() {
		// TODO: 연락처 페이지로 이동
		return "main/contact";
	}
}