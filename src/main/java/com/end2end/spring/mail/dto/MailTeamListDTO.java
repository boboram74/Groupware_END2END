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
    private String SENDEREMAILADDRESS;
    private String title;
    private Timestamp regdate;
}
