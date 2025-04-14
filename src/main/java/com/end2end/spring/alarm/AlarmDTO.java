package com.end2end.spring.alarm;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AlarmDTO {
    private long id;
    private String employeeId;
    private String icons;
    private String message;
    private String url;
    private String type;
    private Timestamp sendTime;
    private boolean isRead;

    public static AlarmDTO of(AlarmType type, String employeeId, String url) {
        return AlarmDTO.builder()
                .id(AlarmEndPoint.getId())
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
                .id(AlarmEndPoint.getId())
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
