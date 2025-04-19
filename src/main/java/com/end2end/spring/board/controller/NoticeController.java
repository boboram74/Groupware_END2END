package com.end2end.spring.board.controller;

import com.end2end.spring.board.dto.NoticeDTO;
import com.end2end.spring.board.service.NoticeCategoryService;
import com.end2end.spring.board.service.NoticeService;
import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.service.FileService;
import com.end2end.spring.util.PageNaviUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/notice")
@Controller
public class NoticeController {
    @Autowired private NoticeService noticeService;
    @Autowired private NoticeCategoryService noticeCategoryService;
    @Autowired private FileService fileService;

    @RequestMapping("/list")
    public String toList(Model model, int page) {
        model.addAttribute("boardList", noticeService.selectAll(page));
        model.addAttribute("noticeCategoryList", noticeCategoryService.selectAll());

        PageNaviUtil.PageNavi pageNavi =
                new PageNaviUtil(page, noticeService.selectAll().size()).generate();
        model.addAttribute("pageNavi", pageNavi);

        model.addAttribute("active", "notice");

        return "board/notice";
    }

    @RequestMapping("/list/{categoryId}")
    public String toList(@PathVariable int categoryId, int page, Model model) {
        if (categoryId == 0) {
            return "redirect:/notice/list?page=1";
        }

        model.addAttribute("boardList", noticeService.selectByCategoryId(categoryId));
        model.addAttribute("noticeCategoryList", noticeCategoryService.selectAll());

        PageNaviUtil.PageNavi pageNavi =
                new PageNaviUtil(page, noticeService.selectByCategoryId(categoryId).size()).generate();
        model.addAttribute("pageNavi", pageNavi);

        model.addAttribute("noticeCategory", noticeCategoryService.selectById(categoryId));
        model.addAttribute("active", "notice");

        return "board/notice";
    }

    @RequestMapping("/detail/{id}")
    public String toDetail(@PathVariable int id, Model model) {
        model.addAttribute("board", noticeService.selectById(id));

        FileDTO fileDTO = FileDTO.builder()
                .noticeId(id)
                .build();
        model.addAttribute("fileList", fileService.selectByParentsId(fileDTO));
        model.addAttribute("active", "notice");

        return "board/detail";
    }

    @RequestMapping("/write")
    public String toWrite(Model model) {
        model.addAttribute("noticeCategoryList", noticeCategoryService.selectAll());
        model.addAttribute("action", "/notice/insert");
        model.addAttribute("active", "write");

        return "board/write";
    }

    @RequestMapping("/insert")
    public String insert(MultipartFile[] files, NoticeDTO dto) throws Exception {
        noticeService.insert(files, dto);
        return "redirect:/notice/detail/" + dto.getId();
    }

    @RequestMapping("/update")
    public String update(NoticeDTO dto) {
        noticeService.update(dto);
        return "redirect:/notice/detail/" + dto.getId();
    }

    @RequestMapping("/delete/{id}")
    public String deleteById(@PathVariable int id) {
        noticeService.deleteById(id);
        return "redirect:/notice/list?page=1";
    }

    @ResponseBody
    @RequestMapping("/recent")
    public Map<String, Object> listRecent() {
        Map<String, Object> json = new HashMap<>();
        json.put("noticeList", noticeService.selectRecent());
        json.put("categoryList", noticeCategoryService.selectAll());

        return json;
    }

    @ResponseBody
    @RequestMapping("recent/{categoryId}")
    public List<NoticeDTO> listRecent(@PathVariable int categoryId) {
        return noticeService.selectRecentByCategoryId(categoryId);
    }
}
