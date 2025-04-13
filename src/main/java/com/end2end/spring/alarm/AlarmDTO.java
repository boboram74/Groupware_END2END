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
}
