package com.end2end.spring.file.service;

import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.dto.FileDetailDTO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface FileService {
    List<FileDetailDTO> selectByParentsId(FileDTO dto);
    void insert(MultipartFile[] files, FileDTO dto);
    void removeByPath(String path);
    void removeByParentsId(FileDTO dto);
}
