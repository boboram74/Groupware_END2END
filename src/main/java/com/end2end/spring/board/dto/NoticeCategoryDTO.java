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
public class NoticeCategoryDTO {
    private int id;
    private String name;
    private Timestamp regDate;
}
