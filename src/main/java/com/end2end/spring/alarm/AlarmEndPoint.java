package com.end2end.spring.alarm;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.messenger.config.WebSocketConfig;
import com.google.common.collect.EvictingQueue;
import com.google.gson.Gson;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint(value="/alarm", configurator = WebSocketConfig.class)
public class AlarmEndPoint {
    private static final Gson g = new Gson();

    private static final Map<String, Session> clients = new ConcurrentHashMap<>();  // 로그인한 사람의 session 보관
    private static final Map<String, EvictingQueue<AlarmDTO>> alarmQueues = new ConcurrentHashMap<>();  // 알람 리스트 보관

    private static long id = 0L;  // 알람 고유 id

    private static EvictingQueue<AlarmDTO> getOrCreateQueue(String employeeId) {  // 알람 리스트 반환
        return alarmQueues.computeIfAbsent(employeeId, k -> EvictingQueue.create(20));
    }

    @OnOpen
    public void onOpen(Session session, EndpointConfig config) throws IOException {
        HttpSession hSession = (HttpSession) config.getUserProperties().get("hSession");

        try {
            EmployeeDTO employee = (EmployeeDTO) hSession.getAttribute("employee");
            clients.put(employee.getId(), session);
            EvictingQueue<AlarmDTO> queue = getOrCreateQueue(employee.getId());

            clients.get(employee.getId()).getBasicRemote().sendText(g.toJson(queue));
        } catch (NullPointerException ignored) {} // 로그인 하지 않은 사원은 무시
    }

    @OnClose
    public void onClose(Session session) {
        clients.values().removeIf(s -> s.equals(session));
    }

    public static void sendMessage(AlarmDTO dto, String employeeId) throws IOException{
        EvictingQueue<AlarmDTO> queue = getOrCreateQueue(employeeId);
        queue.add(dto);
        try {
            clients.get(employeeId).getBasicRemote().sendText(g.toJson(queue));
        } catch (NullPointerException ignored) {} // 로그인 하지 않은 사원은 무시
    }

    @OnMessage
    public void onMessage(String message) {
        Map<String, Object> json = g.fromJson(message, Map.class);
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

