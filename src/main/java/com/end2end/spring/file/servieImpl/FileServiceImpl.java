package com.end2end.spring.file.servieImpl;

import com.end2end.spring.file.dao.FileDAO;
import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.service.FileService;
import com.end2end.spring.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Service
public class FileServiceImpl implements FileService {
    @Autowired
    private FileDAO dao;

    @Override
    public List<FileDTO> selectByParentsId(String column, Object id) {
        return dao.selectByParentsId(column, id);
    }

    @Transactional
    @Override
    public void insert(MultipartFile[] files, String column, Object parentId) {
        int id = dao.insert(column, parentId);

        List<FileDTO> dtoList = FileUtil.upload(column, files);
        dtoList.forEach(dto -> {
            dto.setId(id);
        });
    }

    @Transactional
    @Override
    public void deleteById(int id) {
        FileDTO dto = dao.selectById(id);

        if (dao.deleteById(id)) {
            FileUtil.removeFile(dto.getPath());
        }
    }
}
