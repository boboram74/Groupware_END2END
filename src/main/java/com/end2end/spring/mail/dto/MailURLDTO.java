package com.end2end.spring.mail.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MailURLDTO {
    private int id;
    private int emailStateId;
    private String employeeId;
}
