package com.end2end.spring.messenger.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class MessengerEmployeeListDTO {
    private String id;
    private String name;
    private String teamName;
    private String jobName;
    private String profileImg;
}
