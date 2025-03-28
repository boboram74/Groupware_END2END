package com.end2end.spring.board.controller;

import com.end2end.spring.board.dto.BoardCategoryDTO;
import com.end2end.spring.board.dto.BoardDTO;
import com.end2end.spring.board.dto.ComplaintDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/board")
@Controller
public class BoardController {
    @RequestMapping("/list")
    public String toList(int categoryId, Model model) {
        // TODO: 카테고리 id를 받아 해당 카테고리의 모든 게시글을 list.jsp에 표시
        return "/board/list";
    }

    @RequestMapping("/list/search")
    public String toSearch(Model model) {
        // TODO: 검색 태그를 통해 나온 결과를 list.jsp에 표시
        return "/board/list";
    }

    @RequestMapping("/list/important")
    public String toImportant(Model model) {
        // TODO: 내가 선택한 모든 중요 게시글을 list.jsp에 표시
        return "/board/list";
    }

    @RequestMapping("/write")
    public String toWrite(Model model) {
        // TODO: 게시글 입력 폼으로 이동
        return "/board/write";
    }

    @RequestMapping("/write/update")
    public String toUpdate(Model model) {
        // TODO: 게시글 수정 폼으로 이동
        return "/board/write";
    }

    @RequestMapping("/detail")
    public String toDetail(int id, Model model) {
        // TODO: 게시글 상세글로 이동
        return "/board/detail";
    }

    @RequestMapping("/category")
    public String toCategory(Model model) {
        // TODO: 게시판 추가 폼으로 이동
        return "/board/category";
    }

    @RequestMapping("/insert")
    public void insert(BoardDTO dto) {
        // TODO: 게시글 입력을 받음
    }

    @RequestMapping("/update")
    public void update(BoardDTO dto) {
        // TODO: 게시글 수정을 받음
    }

    @RequestMapping("/delete")
    public void deleteById(int id) {
        // TODO: 게시글 번호로 삭제
    }

    @RequestMapping("/category/insert")
    public void insertCategory(BoardCategoryDTO dto) {
        // TODO: 게시판 입력을 받음
    }

    @RequestMapping("/category/update")
    public void updateCategory(BoardCategoryDTO dto) {
        // TODO: 게시글 수정을 받음
    }

    @RequestMapping("/category/delete")
    public void deleteCategoryById(int id) {
        // TODO: 게시글 번호로 삭제
    }

    @RequestMapping("/complaint/insert")
    public void complaint(ComplaintDTO dto) {
        // TODO: 신고를 받음
    }
}
