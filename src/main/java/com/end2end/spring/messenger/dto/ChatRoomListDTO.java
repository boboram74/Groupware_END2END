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
public class ChatRoomListDTO {
    private Integer roomId;
    private String roomName;
    private String lastMessage;
    private Timestamp lastMessageTime;
    private Integer unreadCount;
}
