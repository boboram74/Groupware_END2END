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
public class ReplyDTO {
    private int id;
    private int boardId;
    private String employeeId;
    private String content;
    private Timestamp regDate;
    private String employeeName;
    private String profileImg;
}
