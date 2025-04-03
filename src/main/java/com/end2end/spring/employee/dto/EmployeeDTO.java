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
<<<<<<< HEAD
}
=======
    private String jobName;
    private String contact;
}
>>>>>>> bfacc3d5c379845129c6291328b1909a3b594908
