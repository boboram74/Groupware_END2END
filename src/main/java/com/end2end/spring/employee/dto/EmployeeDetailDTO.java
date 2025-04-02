package com.end2end.spring.employee.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.sql.Timestamp;
import java.time.LocalDate;

@Data
@AllArgsConstructor
public class EmployeeDetailDTO {
    private String id;
    private String name;
    private String email;
    private String profileImage;
    private int departmentId;
    private int jobId;
    private String role;
    private String loginId;
    private String password;
    private int address;
    private String detailAddress;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate birthday;
    private Timestamp hireDate;
}
