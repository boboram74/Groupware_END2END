package com.end2end.spring.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admin")
@Controller
public class AdminController {

    @RequestMapping
    public String admin() {
        return "admin/index";
    }

    //부서관리
    @RequestMapping("/department-setting")
    public String departmentSetting() {
        return "admin/department-setting";
    }

    //결재 문서 양식 설정
    @RequestMapping("/approval-templates")
    public String approvalTemplates() {
        return "admin/approval-templates";
    }

    //메일 설정
    @RequestMapping("/mail-setting")
    public String mailSetting() {
        return "admin/mail-setting";
    }

    //관리자 설정
    @RequestMapping("/setting")
    public String setting() {
        return "admin/setting";
    }
}