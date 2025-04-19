package com.end2end.spring.employee.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
public class RoleListDTO {
    private String role;
    private String jobName;
    private String teamName;
    private String name;
}
