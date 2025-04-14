package com.end2end.spring.alarm;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.messenger.config.WebSocketConfig;
import com.google.common.collect.EvictingQueue;
import com.google.gson.Gson;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint(value="/alarm", configurator = WebSocketConfig.class)
public class AlarmEndPoint {
    private static final Gson g = new Gson();

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
            EvictingQueue<AlarmDTO> queue = getOrCreateQueue(employee.getId());

            clients.get(employee.getId()).getBasicRemote().sendText(g.toJson(queue));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @OnClose
    public void onClose(Session session) {
        clients.values().removeIf(s -> s.equals(session));
    }

    public static void sendMessage(AlarmDTO dto, String employeeId) {
        EvictingQueue<AlarmDTO> queue = getOrCreateQueue(employeeId);
        queue.add(dto);

        try {
            clients.get(employeeId).getBasicRemote().sendText(g.toJson(queue));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

