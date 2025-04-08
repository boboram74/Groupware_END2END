package com.end2end.spring.main.controller;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.employee.dto.EmployeeDetailDTO;
import com.end2end.spring.employee.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpSession;

@Controller
public class MainController {

	@Autowired
	private EmployeeService employeeService;

	@GetMapping("/")
	public String home(HttpSession session) {
		EmployeeDTO loginUser = (EmployeeDTO) session.getAttribute("employee");
		if (loginUser == null) {
			return "main/login";
		}
		return "main/index";
	}

	@RequestMapping("/mypage/{employeeId}")
	public String toMyPage(@PathVariable String employeeId, HttpSession session, Model model) {
		EmployeeDTO loginUser = (EmployeeDTO) session.getAttribute("employee");
		if (loginUser == null) {
			return "redirect:/";
		}
		// 만약 로그인한 사용자가 자신의 마이페이지가 아니면서 HR 권한이 없는 경우
		if (!loginUser.getId().equals(employeeId)
			&& !loginUser.getDepartmentName().equals("인사팀")
			&& !loginUser.getRole().equals("ADMIN")) {
			return "redirect:/";
		}
		EmployeeDetailDTO employee = employeeService.selectDetailById(employeeId);
		model.addAttribute("employeeDetail", employee);
		return "main/mypage";
	}

	@RequestMapping("/contact")
	public String toContact() {
		// TODO: 연락처 페이지 출력
		return "main/contact";
	}

	@RequestMapping("/worktree")
	public String toWorktree() {
		// TODO: 조직도 페이지 출력
		return "main/worktree";
	}

	@RequestMapping("/test")
	public String toTest() {
		return "/template/exam";
	}
}