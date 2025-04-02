package com.end2end.spring.util;

import com.end2end.spring.file.dto.FileColumnMapperDTO;
import com.end2end.spring.file.dto.FileDetailDTO;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.UUID;

public class FileUtil {
    public static FileDetailDTO upload(MultipartFile file, FileColumnMapperDTO dto) throws IOException {
        String today = LocalDate.now().toString();
        String uploadPath = Statics.FILE_UPLOAD_PATH + dto.getPath() + "/" + today;
        String mappedPath = Statics.MAPPED_FILE_UPLOAD_PATH + dto.getPath() + "/" + today;

        File filePath = new File(uploadPath);

        filePath.mkdir();

        String systemFileName = UUID.randomUUID() + file.getOriginalFilename();
        file.transferTo(new File(uploadPath + "/" + systemFileName));

        return FileDetailDTO.builder()
                .filesId(dto.getFilesId())
                .originFileName(file.getOriginalFilename())
                .systemFileName(systemFileName)
                .fileSize(file.getSize())
                .path(mappedPath + "/" + systemFileName)
                .build();
    }

    public static void removeFile(String path) {
        String fileLocation = Statics.FILE_UPLOAD_PATH + path.substring("/files/".length());

        File file = new File(fileLocation);

        if (!file.exists()) {
            throw new IllegalArgumentException("해당 경로의 파일이 존재하지 않습니다.");
        }

        file.delete();
    }

    public static String uploadImage(MultipartFile file) throws IOException {
        String uploadPath = Statics.FILE_UPLOAD_PATH + "image";

        File filePath = new File(uploadPath);

        filePath.mkdir();

        String systemFileName = UUID.randomUUID() + file.getOriginalFilename();
        file.transferTo(new File(uploadPath + "/" + systemFileName));

        return "/files/image/" + systemFileName;
    }

    public static void removeImage(String path) {
        File filePath = new File(path);
        if (!filePath.exists()) {
            filePath.delete();
            return;
        }

        throw new IllegalArgumentException("해당 경로의 파일이 존재하지 않습니다.");
    }
}
