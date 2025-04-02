package com.end2end.spring.file.servieImpl;

import com.end2end.spring.file.dao.FileDAO;
import com.end2end.spring.file.service.FileService;
import com.end2end.spring.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public class FileServiceImpl implements FileService {
    @Autowired
    private FileDAO dao;

    @Autowired
    private FileUtil fileUtil;
/*
    @Override
    public List<FileDetailDTO> selectByParentsId(FileDTO dto) {
        FileColumnMapperDTO mapper = FileColumnMapperDTO.of(dto);
        return dao.selectByParentsId(mapper);
    }
    */
}
