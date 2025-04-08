package com.end2end.spring.works.dto;

import lombok.AllArgsConstructor;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;


import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProjectInsertDTO {
    private int projectId;
    private String title;
    private Date deadLine;
    private List<String> employeeId;
}
