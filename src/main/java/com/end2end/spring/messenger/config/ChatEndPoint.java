package com.end2end.spring.messenger.config;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.util.*;

@Component
@ServerEndpoint(value = "/chat", configurator = WebSocketConfig.class)
public class ChatEndPoint {

    //private ChatService chatService = SpringProvider.Spring.getBean(ChatService.class);
    private static List<Session> client = Collections.synchronizedList(new ArrayList<Session>());
    private HttpSession hSession = null;
    private final Gson gson = new Gson();
    private static final Map<String, Session> mapClients = new HashMap<>();

    @OnOpen
    public void onConnect(Session session, EndpointConfig config) {
        client.add(session);
        this.hSession = (HttpSession) config.getUserProperties().get("hSession"); //http 세션 가져오기
        EmployeeDTO dto = (EmployeeDTO) hSession.getAttribute("employee");

        // 1. end2end 톡방(6), 2. 3명 톡방(3), 3. 보랑(2)
        // 어디 톡방에 보내는 메세지 표시

    }

    @OnMessage
    public void onMessage(String message, Session session) {
        System.out.println("사용자 메시지 : " + message);

        Map<String, String> incoming;
        try {
            incoming = gson.fromJson(message, new TypeToken<Map<String, String>>(){}.getType());
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
        String targetId = incoming.get("id");       // 클라이언트에서 보낸 data-id 값
        String clientMessage = incoming.get("message");


        Map<String, String> data = new HashMap<>(); //2개의 데이터를 하나로 보내기 위해 Map형식 사용
        String sender = (String)hSession.getAttribute("sender");
        data.put("sender", (String)hSession.getAttribute("loginID"));
        data.put("message", message);

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