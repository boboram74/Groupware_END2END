package com.end2end.spring.messenger.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;
@Getter @Setter
@AllArgsConstructor
@NoArgsConstructor
public class MessageRoomUserDTO {
    private Integer id;
    private Integer messageRoomId;
    private String employeeId;
    private Timestamp regdate;
}
