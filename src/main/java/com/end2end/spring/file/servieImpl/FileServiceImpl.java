package com.end2end.spring.file.servieImpl;

import com.end2end.spring.file.dao.FileDAO;
import com.end2end.spring.file.dto.FileColumnMapperDTO;
import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.dto.FileDetailDTO;
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

    @Override
    public List<FileDTO> selectByParentsId(String column, Object id) {
        return dao.selectByParentsId(column, id);
    }

    @Transactional
    @Override
    public void insert(MultipartFile[] files, FileDTO dto) {
        dao.insert(dto);

        //List<FileDetailDTO> dtoList = fileUtil.upload(files, dto.getId(), fileColumnMapperDTO.getPath());
        //dao.detailInsertAll(dtoList);
    }

    @Transactional
    @Override
    public void deleteById(int id) {
        // FileDetailDTO dto = dao.selectById(id);

        if (dao.deleteById(id)) {
            fileUtil.removeFile("");
        }
    }
}
