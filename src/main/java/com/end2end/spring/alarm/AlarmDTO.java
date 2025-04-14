package com.end2end.spring.alarm;

import com.google.gson.Gson;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AlarmDTO {
    private String employeeId;
    private String icons;
    private String message;
    private String url;
    private String type;
    private Timestamp sendTime;
    private boolean isRead;

    public static AlarmDTO of(AlarmType type, String employeeId, String url) {
        return AlarmDTO.builder()
                .employeeId(employeeId)
                .icons(type.getIcons())
                .url(url)
                .isRead(false)
                .message(type.getDescription())
                .type(type.getType())
                .build();
    }

    public static AlarmDTO of(AlarmType type, String employeeId) {
        return AlarmDTO.builder()
                .employeeId(employeeId)
                .icons(type.getIcons())
                .isRead(false)
                .message(type.getDescription())
                .type(type.getType())
                .build();
    }

    public void read() {
        this.isRead = true;
    }
}
