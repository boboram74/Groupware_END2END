package com.end2end.spring.messenger.dto;

import lombok.*;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;

@Getter @Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MessageDTO {
    private Integer id;
    private Integer messagerRoomId;
    private Integer messagerRoomuserId;
    private String employeeId;
    private String name;
    private String content;
    private Timestamp regDate;
    private String profileImg;
}
