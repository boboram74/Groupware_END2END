package com.end2end.spring.approval.controller;

import com.end2end.spring.approval.dto.ApprovalCategoryDTO;
import com.end2end.spring.approval.dto.ApprovalFormDTO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/form")
@Controller
public class ApprovalFormController {
    @RequestMapping("/list")
    public void list() {
        // TODO: 모든 결재 문서 양식을 출력
    }

    @RequestMapping("/list/{categoryId}")
    public void list(@PathVariable int categoryId) {
        // TODO: 해당 카테고리의 모든 문서 양식을 출력
    }

    @RequestMapping("/list/{employeeId}")
    public void list(@PathVariable String employeeId) {
        // TODO: 해당 사원의 자주 쓰는 문서 양식을 출력
    }

    @RequestMapping("/insert")
    public void insert(ApprovalFormDTO dto) {
        // TODO: 문서 양식 추가
    }

    @RequestMapping("/update")
    public void update(ApprovalFormDTO dto) {
        // TODO: 문서 양식 수정
    }

    @RequestMapping("/delete/{id}")
    public void deleteById(@PathVariable int id) {
        // TODO: 해당 id의 문서 양식 삭제
    }

    @RequestMapping("/frequency/insert")
    public void frequencyInsert(int formId) {
        // TODO: 해당 id의 문서를 로그인 중인 사용자의 자주 쓰는 양식으로 추가
    }

    @RequestMapping("/frequency/delete/{id}")
    public void deleteFrequencyById(@PathVariable int id) {
        // TODO: 해당 id의 문서를 로그인 중인 사용자의 자주 쓰는 양식에서 삭제
    }

    @RequestMapping("/category")
    public void category() {
        // TODO: 모든 문서 양식 카테고리를 출력
    }

    @RequestMapping("/category/insert")
    public void categoryInsert(String name) {
        // TODO: 문서 양식 카테고리를 추가
    }

    @RequestMapping("/category/update")
    public void updateCategory(ApprovalCategoryDTO dto) {
        // TODO: 문서 양식 카테고리 수정
    }

    @RequestMapping("/category/delete/{id}")
    public void deleteCategoryById(@PathVariable int id) {
        // TODO: 해당 id의 문서 양식 카테고리를 삭제
    }
}
