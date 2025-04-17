package com.end2end.spring.alarm;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.messenger.config.WebSocketConfig;
import com.google.common.collect.EvictingQueue;
import com.google.gson.Gson;
import org.apache.ibatis.jdbc.Null;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint(value="/alarm", configurator = WebSocketConfig.class)
public class AlarmEndPoint {
    private static final Gson g = new Gson();

    private static final Map<String, Session> clients = new ConcurrentHashMap<>();
    private static final Map<String, EvictingQueue<AlarmDTO>> alarmQueues = new ConcurrentHashMap<>();

    private static long id = 0L;

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
        } catch (NullPointerException ignored) {
        } catch (IOException e) {
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
        } catch (NullPointerException ignore) { // 현재 로그인 안한 사원에게는 딱히 안줘도 됨
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @OnMessage
    public void onMessage(String message) {
        Map<String, Object> json = g.fromJson(message, Map.class);

        System.out.println("onMessage : " + message);

        Double parseId = (Double) json.get("id");

        long id = parseId.longValue();
        String employeeId = (String) json.get("employeeId");

        EvictingQueue<AlarmDTO> queue = getOrCreateQueue(employeeId);
        for (AlarmDTO dto : queue) {
            if (dto.getId() == id) {
                dto.read();
                break;
            }
        }
    }

    public static long getId() {
        return id++;
    }
}

