package com.end2end.spring.file.service;

import com.end2end.spring.file.dto.FileDTO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface FileService {
    List<FileDTO> selectByParentsId(String column, Object id);
    void insert(MultipartFile[] files, String column, Object parentId);
    void deleteById(int id);
}
