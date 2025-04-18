package com.end2end.spring.board.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class NoticeDTO {
    private int id;
    private int noticeCtId;
    private String noticeCtName;
    private String title;
    private String content;
    private String openYn;
    private Timestamp regDate;
}
