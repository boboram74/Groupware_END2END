package com.end2end.spring.board.serviceImpl;

import com.end2end.spring.board.dao.BoardCategoryDAO;
import com.end2end.spring.board.dao.BoardDAO;
import com.end2end.spring.board.dto.BoardCategoryDTO;
import com.end2end.spring.board.dto.BoardDTO;
import com.end2end.spring.board.dto.ComplaintDTO;
import com.end2end.spring.board.service.BoardCategoryService;
import com.end2end.spring.board.service.BoardService;
import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.service.FileService;
import com.end2end.spring.file.servieImpl.FileServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    private BoardDAO boardDAO;

    @Autowired
    private BoardCategoryDAO boardCategoryDAO;

    @Autowired
    private BoardCategoryService boardCategoryService;

    @Autowired private FileService fileService;

    @Override
    public List<BoardDTO> selectAll() {
        return boardDAO.selectAll();
        // TODO: 모든 게시글 조회 완료
    }

    @Override
    public List<BoardDTO> selectByCategoryId(int categoryId, String employeeId) {
        // TODO: 카테고리 번호의 모든 게시글 조회
        return boardDAO.selectByCategoryId(categoryId,employeeId);
    }

    @Override
    public List<BoardDTO> selectImportant(String employeeId) {
        // TODO: 해당 사원의 중요 게시글 조회
        return null;
    }

    @Override
    public List<BoardDTO> search() {
        // TODO: 검색한 모든 게시글 조회
        return null;
    }

    @Override
    public BoardDTO selectById(int id) {
        boardDAO.increaseViewCount(id);
        return boardDAO.selectById(id);
    }

    @Override
    public void insert(MultipartFile[] files, BoardDTO dto) throws Exception {
        int id = boardDAO.selectNextVal();
        dto.setId(id);

         boardDAO.insert(dto);

         FileDTO fileDTO = FileDTO.builder()
                 .boardId(dto.getId())
                 .build();
         fileService.insert(files, fileDTO);
        // TODO: 게시글 입력
    }

    @Override
    public void update(BoardDTO dto) {
        boardDAO.update(dto);
        // TODO: 게시글 수정
    }

    @Override
    public int deleteById(int id) {
        FileDTO fileDTO = FileDTO.builder()
                .boardId(id)
                .build();
        fileService.removeByParentsId(fileDTO);

        return boardDAO.deleteById(id);
        // TODO: 해당 id의 게시글 삭제
    }

    @Override
    public void complaint(ComplaintDTO dto) {
        // TODO: 게시글 신고 (insert)
    }

    @Override
    public void insertCategory(BoardCategoryDTO dto) {
        boardCategoryDAO.insertCategory(dto);
    }

    @Override
    public BoardCategoryDTO selectCategoryById(int categoryId) {
        return  boardCategoryService.selectCategoryById(categoryId);
    }

    @Override
    public List<BoardDTO> selectRecent() {
        return boardDAO.selectRecent();
    }
}
