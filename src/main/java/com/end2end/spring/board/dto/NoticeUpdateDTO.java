package com.end2end.spring.board.dto;

import com.end2end.spring.file.dto.FileDetailDTO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class NoticeUpdateDTO {
    private int id;
    private int noticeCtId;
    private String title;
    private String content;
    private List<String> updateFileList;
}
