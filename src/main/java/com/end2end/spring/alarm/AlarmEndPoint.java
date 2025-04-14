package com.end2end.spring.alarm;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.messenger.config.WebSocketConfig;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint(value="/alarm", configurator = WebSocketConfig.class)
public class AlarmEndPoint {
    private static Map<String, Session> clients = new ConcurrentHashMap<>();

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

    public static void sendMessage(AlarmDTO dto, List<EmployeeDTO> employees) {
        for (EmployeeDTO employee : employees) {
            try {
                clients.get(employee.getId()).getBasicRemote().sendText(dto.toJson());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

