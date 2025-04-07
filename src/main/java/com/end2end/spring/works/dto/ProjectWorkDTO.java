package com.end2end.spring.works.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProjectWorkDTO {
    private int id;
    private int projectId;
    private int projectUserId;
    private String title;
    private String content;
    private String state;  // "ONGOING", "FINISH"
    private String priority; // "HIGH", "MIDDLE", "LOW"
    private Timestamp finishDate;
    private Timestamp deadLine;
    private Timestamp regDate;


}
