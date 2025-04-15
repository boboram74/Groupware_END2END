package com.end2end.spring.messenger.dto;

import lombok.*;

import java.sql.Timestamp;

@Getter @Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MessageUserDTO {
    private int id;
    private int messagerRoomId;
    private String employeeId;
    private String name;
    private String profileImg;
    private Timestamp regDate;
}