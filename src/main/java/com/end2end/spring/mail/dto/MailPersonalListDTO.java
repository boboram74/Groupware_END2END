package com.end2end.spring.mail.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
public class MailPersonalListDTO {
    private int id;
    private String senderEmailAddress;
    private String title;
    private LocalDateTime regDate;
}