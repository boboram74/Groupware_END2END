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
    private String description;
    private String message;
    private String url;
    private Timestamp sendTime;
    private boolean isRead;

    public String toJson() {
        Map<String, Object> json = new HashMap<>();
        json.put("employeeId", employeeId);
        json.put("icons", icons);
        json.put("description", description);
        json.put("message", message);
        json.put("url", url);
        json.put("sendTime", sendTime);

        return new Gson().toJson(json);
    }

    public static AlarmDTO of(AlarmType type, String employeeId, String message, String url) {
        return AlarmDTO.builder()
                .employeeId(employeeId)
                .icons(type.getIcons())
                .description(type.getDescription())
                .url(url)
                .isRead(false)
                .message(message)
                .build();
    }

    public static AlarmDTO of(AlarmType type, String employeeId, String message) {
        return AlarmDTO.builder()
                .employeeId(employeeId)
                .icons(type.getIcons())
                .description(type.getDescription())
                .isRead(false)
                .message(message)
                .build();
    }

    public void read() {
        this.isRead = true;
    }
}
