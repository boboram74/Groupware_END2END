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
public class ComplaintDTO {
    private int id;
    private String employeeId;
    private int boardId;
    private String description;
    private Timestamp confirmDate;
    private String confirmYn;
}
