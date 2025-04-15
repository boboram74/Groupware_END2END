package com.end2end.spring.mail.controller;

import com.end2end.spring.alarm.AlarmService;
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
    @Autowired
    private AlarmService alarmService;

    @RequestMapping("/list")
    public String list(HttpSession session) {
        return "mail/list";
    }
    @ResponseBody
    @RequestMapping("/listAll")
    public Map<String, Object> listAll(HttpServletRequest request,HttpSession session, Model model) {
        EmployeeDTO EmployeeDTO = (EmployeeDTO)session.getAttribute("employee");
        String scpage = request.getParameter("cpage");
        int cpage = (scpage == null) ? 1 : Integer.parseInt(scpage);
        return mailService.getPageList(cpage, EmployeeDTO.getId(),"listAll");
    }

    @RequestMapping("/{email}/{esId}")
    public String email(@PathVariable("email") String email, @PathVariable("esId") int esId, Model model) {
        MailDetailDTO result = mailService.selectByEmail(email);
        mailService.insertReadYn(esId);
        List<FileDetailDTO> fileDetailDTO = fileService.selectByEmail(email);
        model.addAttribute("fileList", fileDetailDTO);
        model.addAttribute("list", result);
        model.addAttribute("email", email);
        return "mail/detail";
    }

    @RequestMapping("/detailSent/{email}")
    public String detailSent(@PathVariable("email") String email, Model model) {
        MailDetailDTO result = mailService.selectByEmail(email);
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
        mailService.updateImportant(dto);
        return ResponseEntity.ok().build();
    }

    @RequestMapping("/readAndTrashAll")
    public ResponseEntity<Void> readYnAll(String action, @RequestBody List<Integer> esids) {
        if(action.equals("read")) {
            mailService.insertReadYnAll(esids);
        } else if(action.equals("trash")) {
            mailService.trashAll(esids);
        } else if(action.equals("delete")) {
            mailService.deleteAll(esids);
        }
        return ResponseEntity.ok().build();
    }

    @RequestMapping("/write")
    public String write() {
        return "mail/write";
    }

    @RequestMapping("/important")
    public String important() {
        return "mail/important";
    }

    @ResponseBody
    @RequestMapping("/listImportantAll")
    public Map<String, Object> listImportantAll(HttpServletRequest request, HttpSession session, Model model) {
        EmployeeDTO EmployeeDTO = (EmployeeDTO)session.getAttribute("employee");
        String scpage = request.getParameter("cpage");
        int cpage = (scpage == null) ? 1 : Integer.parseInt(scpage);
        return mailService.getPageList(cpage, EmployeeDTO.getId(),"important");
    }

    @RequestMapping("/sendList")
    public String sendList() {
        return "mail/sendList";
    }

    @ResponseBody
    @RequestMapping("/sendListAll")
    public Map<String, Object> listSendAll(HttpServletRequest request, HttpSession session, Model model) {
        try {
            EmployeeDTO EmployeeDTO = (EmployeeDTO) session.getAttribute("employee");
            String scpage = request.getParameter("cpage");
            int cpage = (scpage == null) ? 1 : Integer.parseInt(scpage);
            return mailService.getPageList(cpage, EmployeeDTO.getId(), "sendList");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @RequestMapping("/temp")
    public String temp() {
        return "mail/temp";
    }

    @ResponseBody
    @RequestMapping("/alertList")
    public ResponseEntity<Map<String, Object>> alertList(String employeeId) {
        int allMailBox =  mailService.getRecordReadCount(employeeId);
        int importantMailBox =  mailService.getRecordImportantTotalCount(employeeId);
        int receiveMailBox =  mailService.getRecordReceiveReadCount(employeeId);
        Map<String, Object> data = new HashMap<>();
        data.put("allMailBox", allMailBox);
        data.put("importantMailBox", importantMailBox);
        data.put("receiveMailBox", receiveMailBox);
        return ResponseEntity.ok(data);
    }

    @RequestMapping("/inbox")
    public String inbox() {
        return "mail/inbox";
    }

    @ResponseBody
    @RequestMapping("/listReceiveAll")
    public Map<String, Object> listReceiveAll(HttpServletRequest request, HttpSession session, Model model) {
        EmployeeDTO EmployeeDTO = (EmployeeDTO)session.getAttribute("employee");
        String scpage = request.getParameter("cpage");
        int cpage = (scpage == null) ? 1 : Integer.parseInt(scpage);
        return mailService.getPageList(cpage, EmployeeDTO.getId(),"receiveList");
    }


    @RequestMapping("/trash")
    public String trash() {
        return "mail/trash";
    }

    @ResponseBody
    @RequestMapping("/trashListAll")
    public Map<String, Object> trashList(HttpServletRequest request, HttpSession session, Model model) {
        EmployeeDTO EmployeeDTO = (EmployeeDTO)session.getAttribute("employee");
        String scpage = request.getParameter("cpage");
        int cpage = (scpage == null) ? 1 : Integer.parseInt(scpage);
        return mailService.getPageList(cpage, EmployeeDTO.getId(),"trashList");
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

    @ResponseBody
    @RequestMapping("/alarm")
    public void sendAlarm(int emilId) {
        alarmService.sendMailAlarm("/mail/list", "");
    }
}