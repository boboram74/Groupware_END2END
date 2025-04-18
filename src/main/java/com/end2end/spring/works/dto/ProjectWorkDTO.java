package com.end2end.spring.works.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;
import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProjectWorkDTO {
    private int id;
    private int projectId;
    private String projectUserId;
    private String employeeName;
    private String departmentName;
    private String jobName;
    private String employeeId;
    private String title;
    private String type;
    private String content;
    private String state;  // "ONGOING", "FINISH"
    private String priority; // "HIGH", "MIDDLE", "LOW"
    private Timestamp finishDate;
    private Date deadLine;
    private Timestamp regDate;
    private int workCount;


}
