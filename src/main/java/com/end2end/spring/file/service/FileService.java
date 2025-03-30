package com.end2end.spring.file.service;

import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.dto.FileInsertDTO;

import java.util.List;

public interface FileService {
    List<FileDTO> selectById(String tableName, int id);
    void insert(FileInsertDTO dto);
}
