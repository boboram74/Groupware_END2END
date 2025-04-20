package com.end2end.spring.board.controller;

import com.end2end.spring.board.dto.BoardCategoryDTO;
import com.end2end.spring.board.dto.BoardDTO;
import com.end2end.spring.board.dto.ComplaintDTO;
import com.end2end.spring.board.service.BoardCategoryService;
import com.end2end.spring.board.service.BoardService;
import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.file.dto.FileDTO;
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
    private BoardCategoryService boardCategoryService;

    @Autowired private FileService fileService;

    @RequestMapping("/list")
    public String list(Model model) {
        List<BoardDTO> boardList = boardService.selectAll();
        List<BoardCategoryDTO> boardCategoryList = boardCategoryService.selectAll();
//        System.out.println(boardList);
//        System.out.println(boardCategoryList);
        model.addAttribute("boardList", boardList);
        model.addAttribute("boardCategoryList",boardCategoryList);

        return "/board/list";
    }
    
    @RequestMapping("/delete")
    public String deleteById(@RequestParam("id") int id, HttpSession session){
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
        BoardDTO board = boardService.selectById(id);
        if(!employee.getId().equals(board.getEmployeeId())){
            return "redirect:/board/list?error=unauthorized";
        }
        int deleteId = boardService.deleteById(id);
//        System.out.println(deleteId);
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
        BoardCategoryDTO category = boardCategoryService.selectCategoryById(categoryId);
        if(category == null) {
            return "redirect:/board/list";
        }

        List<BoardDTO> boardList = boardService.selectByCategoryId(categoryId, employee.getId());
//        System.out.println("카테고리 게시판 출력: " + boardList);
        model.addAttribute("category", category);
        model.addAttribute("boardList", boardList);
        model.addAttribute("employeeDTO", employee);

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

    @RequestMapping("/search")
    public String toSearch(Model model,String option,String keyword) {
        List<BoardDTO> result = boardService.search(option,keyword);
        model.addAttribute("boardList", result);
        return "/board/list";
    }

    @RequestMapping("/write")
    public String toWrite(HttpSession session, Model model) {
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
//        System.out.println(employee);
        if (employee == null) {
            return "redirect:/login";
        }

        // 게시판 카테고리 목록을 모델에 추가
        List<BoardCategoryDTO> categoryList = boardCategoryService.selectAll();
        model.addAttribute("employeeDTO", employee);
//        System.out.println(categoryList);
        model.addAttribute("categoryList", categoryList);


        return "/board/write";
    }

    @RequestMapping("/write/update")
    public String toUpdate(@RequestParam("id") int id, Model model) {
        BoardDTO board = boardService.selectById(id);
        model.addAttribute("board", board);

        FileDTO fileDTO = FileDTO.builder()
                .boardId(id)
                .build();
        model.addAttribute("fileList", fileService.selectByParentsId(fileDTO));

        return "/board/update";
    }

    @RequestMapping("/detail/{id}")
    public String toDetail(@PathVariable int id, Model model) {
        model.addAttribute("board", boardService.selectById(id));

        FileDTO fileDTO = FileDTO.builder()
                .boardId(id)
                .build();
        model.addAttribute("fileList", fileService.selectByParentsId(fileDTO));

        return "board/detail";
    }

    @RequestMapping("/category")
    public String toCategory(Model model) {
        // TODO: 게시판 추가 폼으로 이동
        return "/board/category";
    }

    @RequestMapping("/insert")
    public String insert(HttpSession session, BoardDTO dto, MultipartFile[] files)throws Exception {
//        System.out.println("insert 메서드 호출");
        EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
        if (employee == null) {
            return "redirect:/login"; // 세션이 없으면 로그인 페이지로 리다이렉트
        }

        dto.setEmployeeId(employee.getId()); // 작성자 ID 설정
        dto.setBoardCtId(1);
        boardService.insert(files, dto);

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


    @PostMapping("/category/insert")
    public String insertCategory(@ModelAttribute BoardCategoryDTO dto) {

//        System.out.println("Category Name: " + dto.getName());
//        System.out.println("Category Description: " + dto.getCategory());
//        System.out.println(dto.getId()+dto.getName()+dto.getCategory()+dto.getRegDate());
        boardCategoryService.insertCategory(dto);
        return "redirect:/board/list";
        // TODO: 카테고리 입력을 받음
    }

    @ResponseBody
    @RequestMapping("/recent")
    public List<BoardDTO> recent() {
        return boardService.selectRecent();
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
