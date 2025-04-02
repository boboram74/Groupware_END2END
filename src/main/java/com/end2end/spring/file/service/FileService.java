package com.end2end.spring.file.service;

import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.dto.FileDetailDTO;
import org.springframework.web.multipart.MultipartFile;

<<<<<<< HEAD
import java.io.IOException;
=======
import javax.servlet.http.HttpServletResponse;
>>>>>>> bfacc3d5c379845129c6291328b1909a3b594908
import java.util.List;

public interface FileService {
    List<FileDetailDTO> selectByParentsId(FileDTO dto);
<<<<<<< HEAD
    void deleteById(int id) throws IOException;
=======
    void insert(MultipartFile[] files, FileDTO dto) throws Exception;
    void removeByPath(String path);
    void removeByParentsId(FileDTO dto);
    void download(String path, HttpServletResponse response);
>>>>>>> bfacc3d5c379845129c6291328b1909a3b594908
}
