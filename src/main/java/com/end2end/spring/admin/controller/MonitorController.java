package com.end2end.spring.admin.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;

@RestController
public class MonitorController {

    @GetMapping("/api/server-status")
    public Map<String, Object> getServerStatus() throws IOException {
        Map<String, Object> status = new HashMap<>();
        status.put("cpu", getCpuUsage());
        status.put("memory", getMemoryUsage());
        status.put("network", getNetworkTraffic());
        status.put("timestamp", System.currentTimeMillis());
        return status;
    }

    private double getCpuUsage() throws IOException {
        String result = execCmd("top -bn1 | grep Cpu | awk '{print $2+$4}'");
        return Double.parseDouble(result);
    }

    private double getMemoryUsage() throws IOException {
        String result = execCmd("free | grep Mem | awk '{print ($3/$2)*100}'");
        return Double.parseDouble(result);
    }

    private double getNetworkTraffic() throws IOException {
        String result = execCmd("ifstat -i eth0 1 1 | tail -n 1 | awk '{print $1}'");
        return Double.parseDouble(result);
    }

    private String execCmd(String cmd) throws IOException {
        Process process = Runtime.getRuntime().exec(new String[]{"/bin/sh", "-c", cmd});
        BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
        return reader.readLine().trim();
    }
}
