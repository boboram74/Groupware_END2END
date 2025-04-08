package com.end2end.spring.mail.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;

@Getter @Setter
@AllArgsConstructor
@NoArgsConstructor
public class MailListDTO {
    private String id;
    private String emailAddress;
    private String title;
    private int fileCount;
    private String readYn;
    private String importantYn;
    private int esId;
    private Timestamp regdate;
}