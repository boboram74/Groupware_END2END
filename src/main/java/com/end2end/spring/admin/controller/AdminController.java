package com.end2end.spring.admin.controller;

import com.end2end.spring.employee.dto.DepartmentDTO;
import com.end2end.spring.employee.dto.RoleListDTO;
import com.end2end.spring.employee.service.EmployeeService;
import com.end2end.spring.mail.dto.AliasMappingDTO;
import com.end2end.spring.mail.service.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

@RequestMapping("/admin")
@Controller
public class AdminController {

    @Autowired
    private MailService mailService;

    @Autowired
    private EmployeeService employeeService;

    @RequestMapping
    public String admin() {
        return "admin/index";
    }

    //부서관리
    @RequestMapping("/department-setting")
    public String departmentSetting() {
        return "admin/department";
    }

    //결재 문서 양식 설정
    @RequestMapping("/approval-templates")
    public String approvalTemplates() {
        return "admin/approval";
    }

    //메일 설정
    @RequestMapping("/mail-setting")
    public String mailSetting() {
        return "admin/mail";
    }

    @RequestMapping("/mailAliesUpdate")
    public String mailAliesUpdate(
            @RequestParam("aliases") List<String> aliases,
            @RequestParam("aliasNames")     List<String> names,
            @RequestParam("recipients") List<String> recipients) {
        if (aliases.size() != recipients.size()) {
            throw new IllegalArgumentException("alias 와 recipients 의 개수가 일치하지 않습니다.");
        }
        List<AliasMappingDTO> mappings = new ArrayList<>();
        for (int i = 0; i < aliases.size(); i++) {
            String addr = aliases.get(i).trim();
            String name = names.get(i).trim();
            String recs = recipients.get(i).trim();
            if (addr.isEmpty() || name.isEmpty() || recs.isEmpty()) {
                continue;
            }
            AliasMappingDTO dto = new AliasMappingDTO();
            dto.setAliasAddress(addr);
            dto.setAliasName   (name);
            dto.setRecipientList(recs);
            mappings.add(dto);
        }
        mailService.updateAliasMappings(mappings);
        return "redirect:/admin/mail-setting";
    }

    @ResponseBody
    @RequestMapping("/api/department-delete")
    public ResponseEntity<Void> deleteDepartment(@RequestParam("id") int id) {
        employeeService.deleteByDepartmentId(id);
        return ResponseEntity.ok().build();
    }

    @ResponseBody
    @RequestMapping("/api/alies-mapping")
    public ResponseEntity<List<AliasMappingDTO>> aliesMapping() {
        List<AliasMappingDTO> result = mailService.selectByAliesMail();
        return ResponseEntity.ok().body(result);
    }

    @RequestMapping("/api/alies-delete")
    public ResponseEntity<Void> aliesDelete(
            @RequestParam("alias") String alias,
            @RequestParam("recipients") String recipientsCsv) {
        List<String> recipients = Arrays.asList(recipientsCsv.split(","));
        mailService.deleteAliasMapping(alias, recipients);
        return ResponseEntity.ok().build();
    }

    @ResponseBody
    @RequestMapping(value = "/api/loadEmailSignature", produces = "text/plain; charset=UTF-8")
    public ResponseEntity<String> loadEmailSignature() {
        String signature = mailService.loadEmailSignature();
        return ResponseEntity.ok().body(signature);
    }

    @RequestMapping("/api/saveEmailSignature")
    public ResponseEntity<Map<String,String>> updateEmailSignature(@RequestBody Map<String, String> body) {
        mailService.updateEmailSignature(body);
        return ResponseEntity.ok(Collections.singletonMap("status","OK"));
    }

    @RequestMapping("/api/departmentList")
    public ResponseEntity<List<DepartmentDTO>> departmentList() {
        List<DepartmentDTO> result = employeeService.selectByDepartmentList();
        return ResponseEntity.ok().body(result);
    }

    @RequestMapping("/api/loadSettingList")
    public ResponseEntity<List<RoleListDTO>> loadSettingList() {
        List<RoleListDTO> result = employeeService.loadSettingList();
        return ResponseEntity.ok().body(result);
    }

    @RequestMapping("/updateDepartment")
    public String updateDepartment(
            @RequestParam("deptId")      List<Integer>   ids,
            @RequestParam("deptName")    List<String> names,
            @RequestParam("deptEmail")   List<String> emails) {
        if (names.size() != emails.size() || ids.size() != names.size()) {
            throw new IllegalArgumentException("요청 파라미터 개수가 일치하지 않습니다.");
        }

        List<DepartmentDTO> dtos = new ArrayList<>();
        for (int i = 0; i < names.size(); i++) {
            String name  = names.get(i).trim();
            String email = emails.get(i).trim();
            if (name.isEmpty()) continue;
            DepartmentDTO dto = new DepartmentDTO();
            dto.setId    ( ids.get(i));
            dto.setName  ( name );
            dto.setEmail ( email );
            dtos.add(dto);
        }
        employeeService.saveAll(dtos);
        return "redirect:/admin/department-setting";
    }


    //관리자 설정
    @RequestMapping("/setting")
    public String setting() {
        return "admin/setting";
    }


}