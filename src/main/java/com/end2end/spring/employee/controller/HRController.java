package com.end2end.spring.employee.controller;

import com.end2end.spring.employee.dto.DepartmentDTO;
import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.employee.dto.EmployeeDetailDTO;
import com.end2end.spring.employee.dto.JobDTO;
import com.end2end.spring.employee.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/hr")
@Controller
public class HRController {

    @Autowired
    private EmployeeService employeeService;

    @RequestMapping("/list")
    public String toList(Model model) {
        // TODO: 직원 관리 페이지로 이동
        List<EmployeeDTO> list = employeeService.selectAll();
        model.addAttribute("employeeList", list);
        model.addAttribute("isNoAuthExist", employeeService.isNoAuthExist());
        return "hr/list";
    }

    @RequestMapping("/list/search")
    public String toListSearch(Model model) {
        // TODO: 해당 검색 결과를 list.jsp에 출력
        return "hr/list";
    }

    @RequestMapping("/chart")
    public String toChart(Model model) {
        // TODO: 직원 통계 페이지로 이동
        return "hr/chart";
    }

    @RequestMapping("/write")
    public String toWrite(Model model) {
        // TODO: 직원 추가 페이지로 이동
        List<DepartmentDTO> departmentList = employeeService. selectAllDepartment();
        List<JobDTO> jobList = employeeService.selectAllJob();

        model.addAttribute("departmentList", departmentList);
        model.addAttribute("jobList", jobList);

        return "hr/write";
    }

    @RequestMapping("/insert")
    public String insert(EmployeeDetailDTO dto, MultipartFile file) {
        employeeService.insert(dto, file);
        return "redirect:/";
    }

    @RequestMapping("/roleUpdate/{id}")
    public String roleUpdate(@PathVariable("id") String id) {
        employeeService.roleUpdate(id);
        String loginId = employeeService.findByLoginId(id);

        RestTemplate restTemplate = new RestTemplate();
        String mailUrl = "http://34.70.179.192/mail/employee";
        Map<String, String> body = new HashMap<>();
        body.put("name", loginId);
        body.put("password", loginId);
        restTemplate.postForObject(mailUrl, body, String.class);
        return "redirect:/hr/list";
    }

    @RequestMapping("/idCheck")
    @ResponseBody
    public boolean idCheck(String loginId) {
        return employeeService.idVali(loginId);
    }

    @RequestMapping("/update")
    public String update(HttpSession session, EmployeeDetailDTO dto, MultipartFile file) {
        employeeService.update(dto,file);

        String employeeId = dto.getId();
        session.setAttribute("employee", employeeService.selectById(employeeId));
        return "redirect:/mypage/" + employeeId;
    }

    @RequestMapping("/deleteById/{id}")
    public String deleteById(@PathVariable String id) {
        employeeService.deleteById(id);
        return "redirect:/hr/list";
    }

    @RequestMapping("/isResigned/{id}")
    public String isResigned(@PathVariable String id) {
        employeeService.isResigned(id);
        return "redirect:/hr/list";
    }

    @RequestMapping("/chart/employeeAll")
    @ResponseBody
    public List<Map<String, Object>> getEmploymentTypeChart() {
        List<Map<String, Object>> result = employeeService.employeeAll();

        return result;
    }

    @RequestMapping("/chart/monthly")
    @ResponseBody
    public Map<String, List<Integer>> getMonthlyLineChart() {
        return employeeService.getMonthlyLineData();
    }

}
