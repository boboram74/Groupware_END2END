package com.end2end.spring.works.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProjectSelectDTO {
    private int id;
    private String name;
    private String hideYn;
    private String status;
    private List<String> profileImg;
    private Date deadLine;
    private Timestamp regDate;
    private String nearDeadline;
}
