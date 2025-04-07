package com.end2end.spring.employee.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EmployeeDTO {
    private String id;
    private int departmentId;
    private int jobId;
    private String name;
    private String email;
    private String profileImg;
    private String role;
    private String jobName;
    private String departmentName;
    private String contact;
}

