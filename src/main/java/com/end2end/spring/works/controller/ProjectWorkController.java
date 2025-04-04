package com.end2end.spring.works.controller;


import com.end2end.spring.works.dto.ProjectWorkDTO;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/work")
@Controller
public class ProjectWorkController {
    @RequestMapping("/list")
    public String toList(Model model) {
        // TODO:모든게시물 리스트에 표시
        return "/works/list";
    }

    @RequestMapping("/list/search")
    public String toSearch(Model model) {
        // TODO: 검색 태그를 통해 나온 결과를 list.jsp에 표시
        return "/works/list";
    }

    @RequestMapping("/write")
    public String toWrite(Model model) {
        // TODO: 게시글 입력 폼으로 이동
        return "/works/write";
    }

    @RequestMapping("/write/update")
    public String toUpdate(Model model) {
        // TODO: 게시글 수정 폼으로 이동
        return "/works/write";
    }

    @RequestMapping("/{id}")
    public String toDetail(@PathVariable int id, Model model) {
        // TODO: 게시글 상세글로 이동
        return "/works/detail";
    }


    @RequestMapping("/insert")
    public void insert(ProjectWorkDTO dto) {
        // TODO: 게시글 입력을 받음
    }

    @RequestMapping("/update")
    public void update(ProjectWorkDTO dto) {
        // TODO: 게시글 수정을 받음
    }

    @RequestMapping("/delete")
    public void deleteById(int id) {
        // TODO: 작업 번호로 작업게시글삭제
    }



}
