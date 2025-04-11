package com.end2end.spring.board.controller;

import com.end2end.spring.board.dto.BoardCategoryDTO;
import com.end2end.spring.board.dto.BoardDTO;
import com.end2end.spring.board.dto.ComplaintDTO;
import com.end2end.spring.board.service.BoardService;
import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.dto.FileDetailDTO;
import com.end2end.spring.file.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.List;

@RequestMapping("/board")
@Controller
public class BoardController {
    @Autowired
    private BoardService boardService;
@Autowired
FileService fileService;
    @RequestMapping("/list")
    public String list(Model model) {
        List<BoardDTO> boardList = boardService.selectAll();
        System.out.println(boardList);
        model.addAttribute("boardList", boardList);
        // TODO: 모든 리스트

        return "/board/list";
    }
    @RequestMapping("/delete")
    public String deleteById(@RequestParam("id") int id){
        int deleteId = boardService.deleteById(id);
        System.out.println(deleteId);
        return "redirect:/board/list";
}
//    @RequestMapping("/detail")
//    public String list(Model model) {
//        return "board/detail";
//    }

    @RequestMapping("/list/{categoryId}")
    public String toList(@PathVariable int categoryId, HttpSession session, Model model) {
        // TODO: 카테고리 id를 받아 해당 카테고리의 모든 게시글을 list.jsp에 표시
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
        if (employee == null) {
            return "redirect:/login";
        }
        List<BoardDTO> boardList = boardService.selectByCategoryId(categoryId, employee.getId());
        System.out.println("카테고리 게시판 출력: " + boardList);
        model.addAttribute("employeeDTO", employee);
        model.addAttribute("boardList", boardList);

        return "/board/list";
    }

    @RequestMapping("/list/search")
    public String toSearch(Model model) {
        // TODO: 검색 태그를 통해 나온 결과를 list.jsp에 표시
        return "/board/list";
    }

    @RequestMapping("/list/important/{employeeId}")
    public String toImportant(@PathVariable String employeeId, Model model) {
        // TODO: 내가 선택한 모든 중요 게시글을 list.jsp에 표시
        return "/board/list";
    }

    @RequestMapping("/write")
    public String toWrite(HttpSession session, Model model) {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
        model.addAttribute("employeeDTO", employee);
        System.out.println(employee);
        // TODO: 게시글 입력 폼으로 이동
        return "/board/write";
    }

    @RequestMapping("/write/update")
    public String toUpdate(@RequestParam("id") int id, Model model) {
    BoardDTO board = boardService.selectById(id);
    model.addAttribute("board", board);
        // TODO: 게시글 수정 폼으로 이동
        return "/board/update";
    }

    @RequestMapping("/detail/{id}")
    public String toDetail(@PathVariable int id, Model model) {
        model.addAttribute("board", boardService.selectById(id));
        // TODO: 게시글 상세글로 이동

        FileDTO fileDTO = FileDTO.builder()
                .boardId(id)
                .build();
        List<FileDetailDTO> file = fileService.selectByParentsId(fileDTO);
        System.out.println(file);
          model.addAttribute("fileList", file);
//        Map<String, Object> response = new HashMap<>();
//        response.put("files", files);
//        response.put("worksDTO", wdto);

        return "/board/detail";
    }

    @RequestMapping("/category")
    public String toCategory(Model model) {
        // TODO: 게시판 추가 폼으로 이동
        return "/board/category";
    }

    @RequestMapping("/insert")
    public String insert(HttpSession session, BoardDTO dto,  @RequestParam("file") MultipartFile[]file)throws Exception {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");

        boardService.insert(dto,file);
        // TODO: 게시글 입력을 받음
        return "redirect:/board/list";
    }

    @RequestMapping("/update")
    public String update(BoardDTO dto) {
        boardService.update(dto);
        return "redirect:/board/list";
        // TODO: 게시글 수정을 받음
    }

//    @RequestMapping("/delete")
//    public void deleteById(int id) {
//        // TODO: 게시글 번호로 삭제
//    }

    @RequestMapping("/category/insert")
    public void insertCategory(BoardCategoryDTO dto) {
        // TODO: 카테고리 입력을 받음
    }

    @RequestMapping("/category/update")
    public void updateCategory(BoardCategoryDTO dto) {
        // TODO: 카테고리 수정을 받음
    }

    @RequestMapping("/category/delete/{id}")
    public void deleteCategoryById(@PathVariable int id) {
        // TODO: 카테고리 번호로 삭제
    }

    @RequestMapping("/complaint/insert")
    public void complaint(ComplaintDTO dto) {
        // TODO: 신고를 받음
    }
}
