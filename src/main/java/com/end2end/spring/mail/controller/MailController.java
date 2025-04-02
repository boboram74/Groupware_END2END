package com.end2end.spring.mail.controller;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.mail.dto.InboxDTO;
import com.end2end.spring.mail.dto.MailListDTO;
import com.end2end.spring.mail.service.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/mail")
@Controller
public class MailController {

    @Autowired
    private MailService mailService;

    @RequestMapping("/list")
    public String list() {
        return "mail/list";
    }
    @ResponseBody
    @RequestMapping("/listAll")
    public Map<String, Object> listAll(HttpServletRequest request,HttpSession session, Model model) {
        EmployeeDTO EmployeeDTO = (EmployeeDTO)session.getAttribute("employee");
        String scpage = request.getParameter("cpage");
        int cpage = (scpage == null) ? 1 : Integer.parseInt(scpage);
        return mailService.getPageList(cpage, EmployeeDTO.getId());
    }
    @RequestMapping("/inbox")
    public String inbox() {
        return "mail/inbox";
    }
    @RequestMapping("/write")
    public String write() {
        return "mail/write";
    }

    @RequestMapping("/{email}")
    public void email(@PathVariable String email) {
        // TODO: 해당 이메일을 가져옴
    }
    
    @RequestMapping("/insert")
    public void insert(InboxDTO dto) {
        // TODO: 이메일 등록함
    }

    @RequestMapping("/update")
    public void update(InboxDTO dto) {
        // TODO: 이메일 수정함
    }
    
    @RequestMapping("/delete")
    public void deleteByEmail(String email) {
        // TODO: 해당 이메일을 삭제함
    }
}