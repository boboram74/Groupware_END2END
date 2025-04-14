package com.end2end.spring.alarm;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.messenger.config.WebSocketConfig;
import com.google.common.collect.EvictingQueue;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint(value="/alarm", configurator = WebSocketConfig.class)
public class AlarmEndPoint {
    private static Map<String, Session> clients = new ConcurrentHashMap<>();
    private static Map<String, EvictingQueue<AlarmDTO>> alarmQueues = new ConcurrentHashMap<>();

    private static EvictingQueue<AlarmDTO> getOrCreateQueue(String employeeId) {
        return alarmQueues.computeIfAbsent(employeeId, k -> EvictingQueue.create(20));
    }

    @OnOpen
    public void onOpen(Session session, EndpointConfig config) {
        HttpSession hSession = (HttpSession) config.getUserProperties().get("hSession");
        EmployeeDTO employee = (EmployeeDTO) hSession.getAttribute("employee");
        System.out.println("onOpen : " + employee.getId());

        try {
            clients.put(employee.getId(), session);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @OnClose
    public void onClose(Session session) {
        clients.values().removeIf(s -> s.equals(session));
    }

    public static void sendMessage(AlarmDTO dto, String employeeId) {
        try {
            clients.get(employeeId).getBasicRemote().sendText(dto.toJson());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

