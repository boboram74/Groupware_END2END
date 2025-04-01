package com.end2end.spring.file.controller;

import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.service.FileService;
import com.end2end.spring.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RequestMapping("/file")
@Controller
public class FileController {
    @Autowired
    private FileService fileService;

    @Autowired
    private FileUtil fileUtil;

    @ResponseBody
    @RequestMapping("/upload/image")
    public String uploadImage(MultipartFile file) {
        try {
            return FileUtil.uploadTempImage(file);
        } catch (IOException e) {
            return e.getMessage();
        }
    }

    @ResponseBody
    @RequestMapping("/delete/image/{path}")
    public void deleteImage(@PathVariable String path) {
        fileUtil.removeFile(path);
    }

    @RequestMapping("/download")
    public void download(String path) {
        // TODO: 다운로드
    }

    @RequestMapping("/upload/test")
    public String test(MultipartFile[] files, int id) {
        FileDTO dto = FileDTO.builder()
                .boardId(id)
                .build();
        fileUtil.upload(files, dto);

        return "redirect:/";
    }

    @RequestMapping("/delete/test")
    public String delete(String path) {
        fileUtil.removeFile(path);

        return "redirect:/";
    }
}
