package com.end2end.spring.employee.controller;

import com.end2end.spring.employee.dto.EmployeeDetailDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/hr")
@Controller
public class HRController {
    @RequestMapping("/list")
    public String toList(Model model) {
        // TODO: 직원 관리 페이지로 이동
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
        return "hr/write";
    }

    @RequestMapping("/insert")
    public void insert(EmployeeDetailDTO dto) {
        // TODO: 직원 데이터 추가
    }

    @RequestMapping("/update")
    public void update(EmployeeDetailDTO dto) {
        // TODO: 직원 데이터 수정
    }

    @RequestMapping("/delete/{id}")
    public void deleteById(@PathVariable int id) {
        // TODO: 해당 id의 직원 데이터 삭제
    }
}
