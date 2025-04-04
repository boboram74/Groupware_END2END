package com.end2end.spring.works.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.security.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProjectDTO {

    private int id;
    private String name;
    private String hideYn;
    private Timestamp regDate;
}
