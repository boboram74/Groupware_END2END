package com.end2end.spring.file.servieImpl;

import com.end2end.spring.file.dao.FileDAO;
import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FileServiceImpl implements FileService {
    @Autowired
    private FileDAO dao;

    @Override
    public List<FileDTO> selectByParentsId(String column, Object id) {
        return dao.selectByParentsId(column, id);
    }

    @Override
    public void insert(FileDTO dto, String column, Object parentId) {
        int id = dao.insert(column, parentId);
        dto.setId(id);
        dao.detailInsert(dto);
    }

    @Override
    public void deleteById(int id) {

    }

    @Override
    public void deleteByParentsId(String column, Object id) {

    }
}
