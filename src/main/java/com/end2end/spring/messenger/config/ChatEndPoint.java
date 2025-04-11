package com.end2end.spring.messenger.config;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.messenger.dto.MessageHistoryDTO;
import com.end2end.spring.messenger.service.MessengerService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint(value = "/chat", configurator = WebSocketConfig.class)
public class ChatEndPoint {

    private MessengerService messengerService = SpringProvider.Spring.getBean(MessengerService.class);

    //동시성 처리를 위한 클라이언트 세션 저장소
    private static final Set<Session> clients = Collections.newSetFromMap(new ConcurrentHashMap<>());
    private static final Map<String, Session> clientSessions = new ConcurrentHashMap<>();

    private HttpSession hSession = null;
    EmployeeDTO dto = null;
    private final Gson gson = new Gson();

    @OnOpen
    public void onConnect(Session session, EndpointConfig config) {
        this.hSession = (HttpSession) config.getUserProperties().get("hSession");
        dto = (EmployeeDTO) hSession.getAttribute("employee");
        if(dto != null) {
            clientSessions.put(dto.getId(), session); // 사용자 ID로 세션 매핑
        }
        clients.add(session);
        // 1. end2end 톡방(6), 2. 3명 톡방(3), 3. 보랑(2)
        // 2. 어디 톡방에 보내는 메세지 표시
        // 3. 현재 채팅목록에 있는 채팅창인지 아닌지 아닐경우 채팅방 새로 생성(message_room)
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        JsonObject parsedMessage = gson.fromJson(message, JsonObject.class);
        System.out.println(parsedMessage);
        String type = parsedMessage.has("type") ? parsedMessage.get("type").getAsString() : "";
        if ("roomEnter".equals(type)) {
            int roomId = Integer.parseInt(parsedMessage.get("roomId").getAsString());
            System.out.println(dto.getName() + "님이 " + roomId + " 채팅방에 입장했습니다.");
            // TODO: 여기에 roomId 기반 처리 (ex: 세션 매핑, DB 저장 등)
            List<MessageHistoryDTO> result = messengerService.selectByRoomId(roomId);

            for (MessageHistoryDTO msg : result) {
                System.out.println(msg.getName() +":" +msg.getContent());
                Map<String, String> data = new HashMap<>();
                data.put("type", "history");
                data.put("id", String.valueOf(msg.getId()));
                data.put("employeeId", msg.getEmployeeId());
                data.put("sender", msg.getName());
                data.put("message", msg.getContent());
                data.put("profileImg", msg.getProfileImg());
                data.put("timestamp", String.valueOf(msg.getRegDate()));
                sendMessage(session, data); // 현재 사용자에게만 전송
            }
            messengerService.findByRoomId(roomId);
            return;
        }

//        messengerService.findByRoomId(roomId);

        String id = parsedMessage.get("id").getAsString();
        String messageContent = parsedMessage.get("message").getAsString();

        Map<String, String> data = new ConcurrentHashMap<>();
        data.put("senderId", dto.getId());
        data.put("sender", dto.getName());
        data.put("message", messageContent);

        messengerService.messageFirstInsert(dto.getName(), dto.getId(),messageContent);

        if (parsedMessage.has("recipient")) {
            String recipientId = parsedMessage.get("recipient").getAsString();
            Session recipientSession = clientSessions.get(recipientId);
            Session senderSession = clientSessions.get(id);
            if (recipientSession != null && recipientSession.isOpen()) {
                sendMessage(recipientSession, data);
            }
            if (session.isOpen()) {
                sendMessage(session, data);
            }
        } else {
            broadcastMessage(data);
        }

    }

    @OnClose
    public void onClose(Session session) {
        clientSessions.values().removeIf(s -> s.equals(session));
    }
    @OnError
    public void onError(Session session, Throwable throwable) {
        clientSessions.values().removeIf(s -> s.equals(session));
        throwable.printStackTrace();
    }

    //모두에게 전송
    private void broadcastMessage(Map<String, String> data) {
        clients.forEach(session -> {
            if (session.isOpen()) {
                System.out.println(clientSessions.get(session.getId()) + " : " + data);
                sendMessage(session, data);
            } else {
                clients.remove(session);
            }
        });
    }
    private void sendMessage(Session session, Map<String, String> data) {
        try {
            session.getBasicRemote().sendText(gson.toJson(data));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}