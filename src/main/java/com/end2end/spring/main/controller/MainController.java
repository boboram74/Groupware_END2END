package com.end2end.spring.main.controller;

import com.end2end.spring.main.dto.ExamDTO;
import com.end2end.spring.main.service.MainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

	@Autowired
	private MainService mainService;
	
	@GetMapping("/")
	public String home(ExamDTO dto) throws Exception {
		mainService.insertByMember(dto);
		return "main/index";
	}
}