package com.end2end.spring.file.service;

import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.dto.FileDetailDTO;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
<<<<<<< HEAD
=======

>>>>>>> 565ca15d07c69e1c5718af77596ed244035d797c
import java.util.List;

public interface FileService {
    List<FileDetailDTO> selectByParentsId(FileDTO dto);
    void insert(MultipartFile[] files, FileDTO dto) throws Exception;
    void removeByPath(String path);
    void removeByParentsId(FileDTO dto);
    void download(String path, HttpServletResponse response);
}
