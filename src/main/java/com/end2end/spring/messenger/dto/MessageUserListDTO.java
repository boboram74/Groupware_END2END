package com.end2end.spring.messenger.dto;

import lombok.*;

import java.sql.Timestamp;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MessageUserListDTO {
    private int id;
    private int messagerRoomId;
    private String employeeId;
    private Timestamp regDate;
}
