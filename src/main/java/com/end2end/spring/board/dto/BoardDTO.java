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
public class BoardDTO {
    private int id;
    private int boardCtId;
    private String employeeId;
    private String title;
    private String content;
    private int viewCount;
    private String hideYn;
    private Timestamp regDate;
    private String employeeName;
    private String profileImg;
    private int replyCount;
    private String importantYn;

    public void setFilePath(String s) {
    }
}
