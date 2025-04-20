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
public class ProjectWorkUpdateDTO {
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
    private List<Integer> fileId;
}
