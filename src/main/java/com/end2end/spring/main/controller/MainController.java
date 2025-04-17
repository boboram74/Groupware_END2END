package com.end2end.spring.main.controller;

import com.end2end.spring.employee.dto.DepartmentDTO;
import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.employee.dto.EmployeeDetailDTO;
import com.end2end.spring.employee.dto.JobDTO;
import com.end2end.spring.employee.service.EmployeeService;
import com.end2end.spring.main.dto.LoginHistoryDTO;
import com.end2end.spring.main.service.LoginHistoryService;
import com.end2end.spring.util.HolidayUtil;
import com.end2end.spring.util.PageNaviUtil;
import com.end2end.spring.works.dto.ProjectSelectDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
public class MainController {

	@Autowired
	private EmployeeService employeeService;

	@Autowired
	private LoginHistoryService loginHistoryService;

	@GetMapping("/")
	public String home(HttpSession session, Model model) {
		EmployeeDTO loginUser = (EmployeeDTO) session.getAttribute("employee");
		if (loginUser == null) {
			return "main/login";
		}
		model.addAttribute("birthdayList", employeeService.selectByThisMonthBirthday());
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

		List<DepartmentDTO> departmentList = employeeService. selectAllDepartment();
		List<JobDTO> jobList = employeeService.selectAllJob();
		model.addAttribute("departmentList", departmentList);
		model.addAttribute("jobList", jobList);
		return "main/mypage";
	}

	@RequestMapping("/login/history/{page}")
	public String toLoginHistory(HttpSession session, Model model, @PathVariable int page) {
		EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");

		int totalLength = loginHistoryService.selectByEmployeeId(employee.getId()).size();

		PageNaviUtil.PageNavi pageNavi = new PageNaviUtil(page, totalLength).generate();
		List<LoginHistoryDTO> loginHistoryDTOList =
				loginHistoryService.selectByEmployeeId(employee.getId(), page);

		model.addAttribute("loginHistoryList", loginHistoryDTOList);
		model.addAttribute("pageNavi", pageNavi);

		return "/main/loginHistory";
	}

	@RequestMapping("/contact")
	public String selectContactList(Model model) {
		List<EmployeeDTO> contactList = employeeService.selectContactList();
		model.addAttribute("contactList", contactList);
		return "main/contact";
	}

	@RequestMapping("/contact/search")
	public String searchContactList(Model model, String contact, String name) {
		List<EmployeeDTO> contactList = employeeService.searchContactList();
		model.addAttribute("contactList", contactList);
		return "main/contact";
	}

	@RequestMapping("/worktree")
	public String toWorktree() {
		// TODO: 조직도 페이지 출력
		return "main/worktree";
	}

	@ResponseBody
	@RequestMapping("/holiday")
	public List<HolidayUtil.HolidayDTO> getHoliday(String year, String month) {
		try {
			return HolidayUtil.generateHolidayList(year, month);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	@RequestMapping("/test")
	public String toTest() {
		return "/template/exam";
	}
}