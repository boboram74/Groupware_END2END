package com.end2end.spring.employee.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.sql.Timestamp;
import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EmployeeDetailDTO {
    private String id;
    private String name;
    private String email;
    private String profileImg;
    private int departmentId;
    private int jobId;
    private String role;
    private String loginId;
    private String password;
    private int postCode;
    private String address;
    private String detailAddress;
    private String contact;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Timestamp birthday;
    private Timestamp hireDate;

    private String departmentName;
    private String jobName;
}
