package com.end2end.spring.file.servieImpl;

import com.end2end.spring.file.dao.FileDAO;
import com.end2end.spring.file.dto.FileColumnMapperDTO;
import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.dto.FileDetailDTO;
import com.end2end.spring.file.service.FileService;
import com.end2end.spring.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class FileServiceImpl implements FileService {
    @Autowired
    private FileDAO dao;

    @Override
    public List<FileDetailDTO> selectByParentsId(FileDTO dto) {
        FileColumnMapperDTO mapper = FileColumnMapperDTO.of(dto);
        return dao.selectByParentsId(mapper);
    }

    @Override
    public void insert(MultipartFile[] files, FileDTO dto) {
        if (Arrays.stream(files).allMatch(MultipartFile::isEmpty)) {
            return;
        }

        FileColumnMapperDTO fileColumnMapperDTO = FileColumnMapperDTO.of(dto);
        dao.insert(fileColumnMapperDTO);

        List<String> uploadedFilePathList = new ArrayList<>();
        for (MultipartFile file : files) {
            if (file.isEmpty()) {
                continue;
            }
            try {
                FileDetailDTO fileDetailDTO = FileUtil.upload(file, fileColumnMapperDTO);
                dao.detailInsert(fileDetailDTO);
                uploadedFilePathList.add(fileDetailDTO.getPath());
            } catch (IOException e) {
                for (String uploadedFilePath : uploadedFilePathList) {
                    FileUtil.removeFile(uploadedFilePath);
                }
                throw new RuntimeException(e);
            }
        }
    }

    @Override
    public void removeByPath(String path) {
        dao.deleteDetailByPath(path);
        FileUtil.removeFile(path);
    }

    @Override
    public void removeByParentsId(FileDTO dto) {
        FileColumnMapperDTO fileColumnMapperDTO = FileColumnMapperDTO.of(dto);

        List<FileDetailDTO> filesList = dao.selectByParentsId(fileColumnMapperDTO);

        for (FileDetailDTO fileDetailDTO : filesList) {
            FileUtil.removeFile(fileDetailDTO.getPath());
        }

        dao.deleteById(fileColumnMapperDTO);
    }

    @Override
    public void download(String path, HttpServletResponse response) {
        try {
            FileUtil.download(path, response);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void update(MultipartFile[] files, FileDTO dto) {

    }

    @Override
    public List<FileDetailDTO> selectByEmail(String email) {
        return dao.selectByEmail(email);
    }
}
