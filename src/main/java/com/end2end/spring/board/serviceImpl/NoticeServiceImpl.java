package com.end2end.spring.board.serviceImpl;

import com.end2end.spring.board.dao.NoticeDAO;
import com.end2end.spring.board.dto.NoticeDTO;
import com.end2end.spring.board.service.NoticeService;
import com.end2end.spring.util.Statics;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {
    @Autowired private NoticeDAO noticeDAO;


    @Override
    public List<NoticeDTO> selectAll() {
        return noticeDAO.selectAll();
    }

    @Override
    public List<NoticeDTO> selectAll(int page) {
        int start = (page - 1) * Statics.recordCountPerPage;
        int end = Math.min(page * Statics.recordCountPerPage, noticeDAO.selectAll().size());

        return noticeDAO.selectAllFromTo(start, end);
    }

    @Override
    public List<NoticeDTO> selectByCategoryId(int categoryId) {
        return noticeDAO.selectByCategoryId(categoryId);
    }

    @Override
    public List<NoticeDTO> selectByCategoryId(int categoryId, int page) {
        int start = (page - 1) * Statics.recordCountPerPage;
        int end = Math.min(page * Statics.recordCountPerPage, noticeDAO.selectByCategoryId(categoryId).size());

        return noticeDAO.selectByCategoryIdFromTo(categoryId, start, end);
    }

    @Override
    public NoticeDTO selectById(int id) {
        return noticeDAO.selectById(id);
    }

    @Transactional
    @Override
    public void insert(NoticeDTO dto) {
        noticeDAO.insert(dto);
    }

    @Transactional
    @Override
    public void update(NoticeDTO dto) {
        noticeDAO.update(dto);
    }

    @Transactional
    @Override
    public void deleteById(int id) {
        noticeDAO.deleteById(id);
    }

    @Override
    public List<NoticeDTO> selectRecent() {
        int start = 1;
        int end = Math.min(8, noticeDAO.selectAll().size());

        return noticeDAO.selectAllFromTo(start, end);
    }

    @Override
    public List<NoticeDTO> selectRecentByCategoryId(int categoryId) {
        int start = 1;
        int end = Math.min(8, noticeDAO.selectByCategoryId(categoryId).size());

        return noticeDAO.selectByCategoryIdFromTo(categoryId, start, end);
    }
}
