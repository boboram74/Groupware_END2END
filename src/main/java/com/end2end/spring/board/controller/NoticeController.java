package com.end2end.spring.board.controller;

import com.end2end.spring.board.dto.NoticeDTO;
import com.end2end.spring.board.service.NoticeCategoryService;
import com.end2end.spring.board.service.NoticeService;
import com.end2end.spring.util.PageNaviUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@RequestMapping("/notice")
@Controller
public class NoticeController {
    @Autowired private NoticeService noticeService;
    @Autowired private NoticeCategoryService noticeCategoryService;

    @RequestMapping("/list")
    public String toList(Model model, int page) {
        model.addAttribute("boardList", noticeService.selectAll(page));
        model.addAttribute("noticeCategoryList", noticeCategoryService.selectAll());

        PageNaviUtil.PageNavi pageNavi =
                new PageNaviUtil(page, noticeService.selectAll().size()).generate();
        model.addAttribute("pageNavi", pageNavi);

        return "board/notice";
    }

    @RequestMapping("/list/{categoryId}")
    public String toList(@PathVariable int categoryId, int page, Model model) {
        model.addAttribute("boardList", noticeService.selectByCategoryId(categoryId));
        model.addAttribute("noticeCategory", noticeCategoryService.selectById(categoryId));

        PageNaviUtil.PageNavi pageNavi =
                new PageNaviUtil(page, noticeService.selectByCategoryId(categoryId).size()).generate();
        model.addAttribute("pageNavi", pageNavi);

        return "board/notice";
    }

    @RequestMapping("/detaile/{id}")
    public String toDetail(@PathVariable int id, Model model) {
        model.addAttribute("notice", noticeService.selectById(id));
        return "notice/detail";
    }

    @RequestMapping("/insert")
    public String insert(NoticeDTO dto) {
        noticeService.insert(dto);
        return "redirect:/board/detail/" + dto.getId();
    }

    @RequestMapping("/update")
    public String update(NoticeDTO dto) {
        noticeService.update(dto);
        return "redirect:/notice/list";
    }

    @RequestMapping("/delete/{id}")
    public String deleteById(@PathVariable int id) {
        noticeService.deleteById(id);
        return "redirect:/notice/list";
    }

    @ResponseBody
    @RequestMapping("/recent/list")
    public List<NoticeDTO> listRecent() {
        return noticeService.selectRecent();
    }

    @ResponseBody
    @RequestMapping("recent//list/{categoryId}")
    public List<NoticeDTO> listRecent(@PathVariable int categoryId) {
        return noticeService.selectRecentByCategoryId(categoryId);
    }
}
