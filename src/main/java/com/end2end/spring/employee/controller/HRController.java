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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    public String toList(Model model, HttpSession session, RedirectAttributes redirectAttributes) {

        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
        if (employee == null ||
                (!"ADMIN".equalsIgnoreCase(employee.getRole()) &&
                        !"인사팀".equals(employee.getDepartmentName()))) {

            redirectAttributes.addFlashAttribute("msg", "접근 권한이 없습니다.");
            return "redirect:/";
        }
        List<EmployeeDTO> list = employeeService.selectAll();
        model.addAttribute("employeeList", list);
        model.addAttribute("isNoAuthExist", employeeService.isNoAuthExist());
        return "hr/list";
    }


    @RequestMapping("/list/search")
    public String searchEmployeeList(Model model,String searchOption, String keyword) {

        if (keyword == null || keyword.trim().isEmpty()) {
            return "redirect:/hr/list";
        }

        List<EmployeeDTO> list = employeeService.searchEmployeeList(searchOption, keyword);
        model.addAttribute("employeeList", list);
        return "hr/list";
    }

    @RequestMapping("/contact/search")
    public String searchContactList(Model model, String searchOption, String keyword) {

        List<EmployeeDTO> contactList = employeeService.searchContactList(searchOption, keyword);
        model.addAttribute("contactList", contactList);

        return "main/contact";
    }

    @RequestMapping("/chart")
    public String toChart(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");

        if (employee == null ||
                (!"ADMIN".equalsIgnoreCase(employee.getRole()) &&
                        !"인사팀".equals(employee.getDepartmentName()))) {

            redirectAttributes.addFlashAttribute("msg", "접근 권한이 없습니다.");
            return "redirect:/";
        }
        return "hr/chart";
    }

    @RequestMapping("/write")
    public String toWrite(Model model) {

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
        System.out.println(employeeService.selectById(employeeId));
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

    @RequestMapping("/chart/vacation")
    @ResponseBody
    public List<Map<String, Object>> getVacationStats() {
        return employeeService.getVacationStats();
    }

    @RequestMapping("/chart/attendance")
    @ResponseBody
    public List<Map<String, Object>> getAttendanceStats() {
        return employeeService.getAttendanceStats();
    }

}
