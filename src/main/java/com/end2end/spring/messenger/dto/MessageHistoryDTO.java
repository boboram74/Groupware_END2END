package com.end2end.spring.messenger.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
@Getter @Setter
@AllArgsConstructor
@NoArgsConstructor
public class MessageHistoryDTO {
    private Integer id;
    private String employeeId;
    private String content;
    private String name;
    private String profileImg;
    private String jName;
    private String dName;
    private Timestamp regDate;
}
