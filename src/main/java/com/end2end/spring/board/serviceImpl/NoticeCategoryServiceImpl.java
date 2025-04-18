package com.end2end.spring.board.serviceImpl;

import com.end2end.spring.board.dao.NoticeCategoryDAO;
import com.end2end.spring.board.dto.NoticeCategoryDTO;
import com.end2end.spring.board.service.NoticeCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class NoticeCategoryServiceImpl implements NoticeCategoryService {
    @Autowired private NoticeCategoryDAO noticeCategoryDAO;

    @Override
    public List<NoticeCategoryDTO> selectAll() {
        return noticeCategoryDAO.selectAll();
    }

    @Override
    public NoticeCategoryDTO selectById(int id) {
        return noticeCategoryDAO.selectById(id);
    }

    @Transactional
    @Override
    public void insert(NoticeCategoryDTO dto) {
        noticeCategoryDAO.insert(dto);
    }

    @Transactional
    @Override
    public void update(NoticeCategoryDTO dto) {
        noticeCategoryDAO.update(dto);
    }

    @Override
    public void deleteById(int id) {
        noticeCategoryDAO.deleteById(id);
    }
}
