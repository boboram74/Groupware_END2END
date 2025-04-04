package com.end2end.spring.mail.controller;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.file.dto.FileDetailDTO;
import com.end2end.spring.file.service.FileService;
import com.end2end.spring.mail.dto.ImportYnDTO;
import com.end2end.spring.mail.dto.InboxDTO;
import com.end2end.spring.mail.dto.MailDetailDTO;
import com.end2end.spring.mail.service.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
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
    @Autowired
    private FileService fileService;

    @RequestMapping("/list")
    public String list(HttpSession session) {
        EmployeeDTO employee = EmployeeDTO.builder()
                .id("2307276")
                .name("유민기")
                .email("employee6@end2end.site")
                .role("USER")
                .profileImg("https://picsum.photos/200/200")
                .departmentId(5)
                .jobId(3)
                .build();
        session.setAttribute("employee", employee);
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

    @RequestMapping("/{email}/{esId}")
    public String email(@PathVariable("email") String email, @PathVariable("esId") int esId, Model model) {
        System.out.println("넘어온 esid:"+esId);
        MailDetailDTO result = mailService.selectByEmail(email);
        mailService.insertReadYn(esId);
        List<FileDetailDTO> fileDetailDTO = fileService.selectByEmail(email);
        model.addAttribute("fileList", fileDetailDTO);
        model.addAttribute("list", result);
        model.addAttribute("email", email);
        return "mail/detail";
    }

    @RequestMapping("/reSend")
    public String reSend(String sender,String title, String content , Model model) {
        Map<String, Object> data = new HashMap<>();
        data.put("receiveMail", sender);
        data.put("title", title);
        data.put("content", content);
        model.addAllAttributes(data);
        return "mail/write";
    }

    @RequestMapping("/updateImportant")
    public ResponseEntity<Void> updateImportant(@RequestBody ImportYnDTO dto) {
        System.out.println(dto.getImportantYn() + " " + dto.getEsId());
        mailService.updateImportant(dto);
        return ResponseEntity.ok().build();
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