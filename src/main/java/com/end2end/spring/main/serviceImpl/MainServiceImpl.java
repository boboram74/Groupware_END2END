package com.end2end.spring.main.serviceImpl;

import com.end2end.spring.main.dao.ExamDAO;
import com.end2end.spring.main.dto.ExamDTO;
import com.end2end.spring.main.service.MainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MainServiceImpl implements MainService {

    @Autowired
    private ExamDAO examDAO;

    @Override
    @Transactional
    public int insertByMember(ExamDTO dto) throws Exception {
        return examDAO.exam(dto);
    }
}
