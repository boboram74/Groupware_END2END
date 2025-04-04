package com.end2end.spring.works.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.security.Timestamp;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProjectUserDTO {

    private int id;
    private String employeeId;
    private int projectId;
    private Timestamp regDate;
}
