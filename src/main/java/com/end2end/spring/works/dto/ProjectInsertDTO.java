package com.end2end.spring.works.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProjectInsertDTO {
    private int projectId;
    private String title;
    private LocalDateTime deadLine;
    private List<String> employeeId;
}
