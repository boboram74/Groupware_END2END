package com.end2end.spring.admin.controller;

import com.end2end.spring.mail.dto.AliasMappingDTO;
import com.end2end.spring.mail.service.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@RequestMapping("/admin")
@Controller
public class AdminController {

    @Autowired
    private MailService mailService;

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

    @RequestMapping("/api/loadEmailSignature")
    public ResponseEntity<String> loadEmailSignature() {
        String signature = mailService.loadEmailSignature();
        System.out.println(signature);
        return ResponseEntity.ok().body(signature);
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

    //관리자 설정
    @RequestMapping("/setting")
    public String setting() {
        return "admin/setting";
    }
}