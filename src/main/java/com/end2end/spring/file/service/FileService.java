package com.end2end.spring.file.service;

import com.end2end.spring.file.dto.FileDTO;

import java.util.List;

public interface FileService {
    List<FileDTO> selectByParentsId(String column, Object id);
    void insert(FileDTO dto, String column, Object parentId);
    void deleteById(int id);
    void deleteByParentsId(String column, Object id);
}
