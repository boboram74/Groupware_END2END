package com.end2end.spring.messenger.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;

@Getter @Setter
@AllArgsConstructor
@NoArgsConstructor
public class MessageReadDTO {
    private Integer id;
    private Integer messageId;
    private Integer messageRoomUserId;
    private Timestamp regdate;
}
