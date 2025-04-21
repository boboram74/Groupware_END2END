package com.end2end.spring.board.serviceImpl;

import com.end2end.spring.board.dao.BoardCategoryDAO;
import com.end2end.spring.board.dao.BoardDAO;
import com.end2end.spring.board.dto.BoardCategoryDTO;
import com.end2end.spring.board.dto.BoardDTO;
import com.end2end.spring.board.dto.BoardUpdateDTO;
import com.end2end.spring.board.service.BoardCategoryService;
import com.end2end.spring.board.service.BoardService;
import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.service.FileService;
import com.end2end.spring.util.Statics;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    private BoardDAO boardDAO;

    @Autowired
    private BoardCategoryDAO boardCategoryDAO;

    @Autowired
    private BoardCategoryService boardCategoryService;

    @Autowired
    private FileService fileService;

    @Override
    public List<BoardDTO> selectAll() {
        return boardDAO.selectAll();
        // TODO: 모든 게시글 조회 완료
    }

    @Override
    public List<BoardDTO> selectAll(int page) {
        int start = (page - 1) * Statics.recordCountPerPage;
        int end = Math.min(page * Statics.recordCountPerPage, boardDAO.selectAll().size());

        return boardDAO.selectAllFromTo(start, end);
    }

    @Override
    public List<BoardDTO> selectByCategoryId(int categoryId, String employeeId) {
        // TODO: 카테고리 번호의 모든 게시글 조회
        return boardDAO.selectByCategoryId(categoryId, employeeId);
    }

    @Override
    public List<BoardDTO> selectImportant(String employeeId) {
        // TODO: 해당 사원의 중요 게시글 조회
        return null;
    }

    @Override
    public List<BoardDTO> search(String option, String keyword) {
        return boardDAO.search(option,keyword);
    }

    @Override
    public List<BoardDTO> search(String option, String keyword, int page) {
        int start = (page - 1) * Statics.recordCountPerPage;
        int end = Math.min(page * Statics.recordCountPerPage, boardDAO.search(option,keyword).size());

        return boardDAO.searchFromTo(option,keyword,start,end);
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
    }

    @Override
    public void update(MultipartFile[] files, BoardUpdateDTO dto) {
        FileDTO fileDTO = FileDTO.builder()
                .boardId(dto.getId())
                .build();
        fileService.update(files, fileDTO, dto.getFileId());

        BoardDTO boardDTO = BoardDTO.builder()
                .id(dto.getId())
                .title(dto.getTitle())
                .content(dto.getContent())
                .boardCtId(dto.getBoardCtId())
                .build();
        boardDAO.update(boardDTO);
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
    public void insertCategory(BoardCategoryDTO dto) {
        boardCategoryDAO.insertCategory(dto);
    }

    @Override
    public BoardCategoryDTO selectCategoryById(int categoryId) {
        return boardCategoryService.selectCategoryById(categoryId);
    }

    @Override
    public List<BoardDTO> selectRecent() {
        return boardDAO.selectRecent();
    }
}
