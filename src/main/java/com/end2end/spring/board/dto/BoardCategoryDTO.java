package com.end2end.spring.board.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
public class BoardCategoryDTO {
    private int id;
    private String name;
    private String category;
    private Timestamp sysdate;
}
