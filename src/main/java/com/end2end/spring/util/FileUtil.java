package com.end2end.spring.util;

import com.end2end.spring.file.dto.FileColumnMapperDTO;
import com.end2end.spring.file.dto.FileDetailDTO;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
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

        file.delete();
    }

    public static String uploadImage(MultipartFile file) throws IOException {
        String today = LocalDate.now().toString();
        String uploadPath = Statics.FILE_UPLOAD_PATH + "image/" + today;
        String mappedPath = Statics.MAPPED_FILE_UPLOAD_PATH + "image/" + today;

        File filePath = new File(uploadPath);

        filePath.mkdirs();

        // 원본 파일명에서 확장자만 추출
        String originalFilename = file.getOriginalFilename();
        String fileExtension = "";
        if (originalFilename != null && originalFilename.contains(".")) {
            fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
        }

        // UUID에 확장자만 붙여서 고유 파일명을 생성
        String systemFileName = UUID.randomUUID().toString() + fileExtension;
        file.transferTo(new File(uploadPath + "/" + systemFileName));
        return mappedPath + "/" + systemFileName;
    }

    public static void removeImage(String path) {
        File filePath = new File(path);
        if (filePath.exists()) {
            filePath.delete();
            return;
        }

        throw new IllegalArgumentException("해당 경로의 파일이 존재하지 않습니다.");
    }

    public static void download(String path, HttpServletResponse response) throws IOException {
        String fileLocation = Statics.FILE_UPLOAD_PATH + path.substring("/files/".length());

        File file = new File(fileLocation);

        if (file.exists()) {
            response.setContentType("application/octet-stream");  // 바이너리 데이터로 설정
            response.setHeader("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"");

            try(OutputStream os = response.getOutputStream();
                FileInputStream fileInputStream = new FileInputStream(file);) {
                FileCopyUtils.copy(fileInputStream, os);
            }
        }
    }

    private static String getExtension(String filePath) {
        return "." + filePath.substring(filePath.lastIndexOf(".") + 1);
    }
}
