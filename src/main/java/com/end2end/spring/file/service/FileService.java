package com.end2end.spring.file.service;

import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.dto.FileDetailDTO;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

public interface FileService {
    List<FileDetailDTO> selectByParentsId(FileDTO dto);
    void insert(MultipartFile[] files, FileDTO dto) throws Exception;
    void removeByPath(String path);
    void removeByParentsId(FileDTO dto);
    void download(String path, HttpServletResponse response);
    List<FileDetailDTO> selectByEmail(String email);
    void update(MultipartFile[] files, FileDTO dto, List<FileDetailDTO> updatedList);
}
