package com.end2end.spring.mail.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@Getter @Setter
@AllArgsConstructor
@NoArgsConstructor
public class MailTeamListDTO {
    private String id;
    private String emailAddress;
    private String title;
    private int fileCount;
    private String readYn;
    private String importantYn;
    private int esId;
    private Timestamp regdate;
}