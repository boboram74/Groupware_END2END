package com.end2end.spring.main.controller;

import com.end2end.spring.employee.dto.EmployeeDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
public class MainController {
	@GetMapping("/")
<<<<<<< HEAD
	public String home(HttpSession session, Model model) {
		session.getAttribute("loginId");
		EmployeeDTO employee = EmployeeDTO.builder()
				.id("21092011")
				.name("오호정")
				.email("21092011@end2end.site")
				.role("USER")
				.profileImg("https://picsum.photos/200/200")
				.departmentId(1)
				.jobId(4)
				.jobName("사원")
				.build();
		session.setAttribute("employee", employee);

		model.addAttribute("title", "내용");

=======
	public String home() {
>>>>>>> 353f33ddf8156b499ad2f9f2a45e8c862fd9c87f
		return "main/index";
	}

	@RequestMapping("/mypage/{employeeId}")
	public String toMyPage(@PathVariable String employeeId, Model model) {
		// TODO: 해당 사원의 마이페이지 출력
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
}