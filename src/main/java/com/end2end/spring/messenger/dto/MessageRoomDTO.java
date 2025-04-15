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
public class MessageRoomDTO {
    private Integer id;
    private String name;
    private String employeeId;
    private Timestamp regdate;
}
