package com.end2end.spring.file.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@RequestMapping("/file")
@Controller
public class FileController {
    @ResponseBody
    @RequestMapping("/upload/image/temp")
    public void uploadTemp(MultipartFile file) {
        // TODO: summernote의 임시 이미지 파일 업로드
    }

    @RequestMapping("/download")
    public void download() {
        // TODO: 다운로드
    }
}
