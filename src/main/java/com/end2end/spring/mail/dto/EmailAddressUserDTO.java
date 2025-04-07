package com.end2end.spring.mail.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EmailAddressUserDTO {
    private int id;
    private String emailAddress;
    private String employeeId;
    private Timestamp regDate;
}
