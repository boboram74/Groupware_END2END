package com.end2end.spring.messenger.config;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.messenger.service.MessengerService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

@Component
@ServerEndpoint(value = "/chat", configurator = WebSocketConfig.class)
public class ChatEndPoint {

    private MessengerService messengerService = SpringProvider.Spring.getBean(MessengerService.class);
    private static List<Session> client = Collections.synchronizedList(new ArrayList<Session>());
    private static final Map<String, Session> clientSessions = new ConcurrentHashMap<>();

    private HttpSession hSession = null;
    EmployeeDTO dto = null;
    private final Gson gson = new Gson();
    private static final Map<String, Session> mapClients = new HashMap<>();

    @OnOpen
    public void onConnect(Session session, EndpointConfig config) {
        client.add(session);
        this.hSession = (HttpSession) config.getUserProperties().get("hSession"); //http 세션 가져오기
        dto = (EmployeeDTO) hSession.getAttribute("employee");

        // 1. end2end 톡방(6), 2. 3명 톡방(3), 3. 보랑(2)
        // 2. 어디 톡방에 보내는 메세지 표시
        // 3. 현재 채팅목록에 있는 채팅창인지 아닌지 아닐경우 채팅방 새로 생성(message_room)
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        JsonObject parsedMessage = gson.fromJson(message, JsonObject.class);
        String id = parsedMessage.get("id").getAsString();
        System.out.println(id + "수신자 EmployeeID");
        Map<String, String> data = new HashMap<>(); //2개의 데이터를 하나로 보내기 위해 Map형식 사용
        data.put("sender", dto.getName());
        data.put("message", parsedMessage.get("message").getAsString());

        synchronized (client) { //동시성 이슈 해결
            for (Session clients : client) {
                try {
                    clients.getBasicRemote().sendText(gson.toJson(data));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            Session recivedSession = mapClients.get(hSession.getId());
        }
    }

    @OnClose
    public void onClose(Session session) {
        client.remove(session);
    }
    @OnError
    public void onError(Session session, Throwable throwable) {
        client.remove(session);
        throwable.printStackTrace();
    }
}