package com.end2end.spring.mail.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
public class MailListDTO {
    private int id;
    private String senderEmailAddress;
    private String title;
    private Timestamp regDate;
}