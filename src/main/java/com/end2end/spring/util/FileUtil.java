package com.end2end.spring.util;

import com.end2end.spring.file.dao.FileDAO;
import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.dto.FileDetailDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.UUID;

@Component
public class FileUtil {
    @Autowired
    private FileDAO dao;

    public void upload(MultipartFile[] files, FileDTO dto) {
        String today = LocalDate.now().toString();
        String uploadPath = Statics.FILE_UPLOAD_PATH + dto.getPath() + "/" + today;

        File filePath = new File(uploadPath);

        filePath.mkdir();

        dao.insert(dto);

        for (MultipartFile file : files) {
            if (file.isEmpty()) {
                continue;
            }

            String systemFileName = UUID.randomUUID() + file.getOriginalFilename();
            try {
                file.transferTo(new File(uploadPath + "/" + systemFileName));
                FileDetailDTO fileDetailDTO = FileDetailDTO.builder()
                        .filesId(dto.getId())
                        .originFileName(file.getOriginalFilename())
                        .systemFileName(systemFileName)
                        .fileSize(file.getSize())
                        .path(dto.getPath() + "/" + systemFileName)
                        .build();
                dao.detailInsert(fileDetailDTO);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public void removeFile(String path) {
        File file = new File(path);

        if (file.exists()) {
            file.delete();
        }

        throw new IllegalArgumentException("해당 경로의 파일이 존재하지 않습니다.");
    }

    public static String uploadTempImage(MultipartFile file) throws IOException {
        String uploadPath = Statics.FILE_UPLOAD_PATH + "image";

        File filePath = new File(uploadPath);

        filePath.mkdir();

        String systemFileName = UUID.randomUUID() + file.getOriginalFilename();
        file.transferTo(new File(uploadPath + "/" + systemFileName));

        return "/files/image/" + systemFileName;
    }
}
