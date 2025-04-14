package com.end2end.spring.works.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class WorkUpdateDTO {
private int id;
    private String title;
    private String type;
    private String priority;
    private String state;
    private String content;


}

