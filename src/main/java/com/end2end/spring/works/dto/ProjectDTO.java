package com.end2end.spring.works.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;
import java.sql.Timestamp;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProjectDTO {

    private int id;
    private String name;
    private String hideYn;
    private String status;
    private Timestamp regDate;
    private Date deadLine;
    private String nearDeadline;


}
