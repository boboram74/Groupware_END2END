package com.end2end.spring.schedule.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BookTargetDTO {
    private int id;
    private String targetType;
    private String name;
    private String img;

    private int capacity;
    private String location;
}
