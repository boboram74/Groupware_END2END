package com.end2end.spring.mail.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;

@Getter @Setter
@AllArgsConstructor
@NoArgsConstructor
public class SendMailListDTO {
    private String id;
    private int fileCount;
    private String recipientemailaddress;
    private String title;
    private Timestamp regdate;
}