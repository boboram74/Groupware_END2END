package com.end2end.spring.messenger.config;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.messenger.dto.MessageDTO;
import com.end2end.spring.messenger.dto.MessageHistoryDTO;
import com.end2end.spring.messenger.dto.MessageUserDTO;
import com.end2end.spring.messenger.dto.MessageUserListDTO;
import com.end2end.spring.messenger.service.MessengerService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint(value = "/chat", configurator = WebSocketConfig.class)
public class ChatEndPoint {

    private MessengerService messengerService = SpringProvider.Spring.getBean(MessengerService.class);

    // 사용자 ID로 세션 매핑 (동시성 처리)
    private static final Map<String, Session> clientSessions = new ConcurrentHashMap<>();

    private HttpSession hSession = null;
    private EmployeeDTO dto = null;
    private final Gson gson = new Gson();

    @OnOpen
    public void onConnect(Session session, EndpointConfig config) {
        this.hSession = (HttpSession) config.getUserProperties().get("hSession");
        dto = (EmployeeDTO) hSession.getAttribute("employee");
        if(dto != null) {
            System.out.println("유저 추가됨 : " + dto.getName() + " session ID : " + session.getId());
            clientSessions.put(dto.getId(), session); // 사용자 ID로 세션 매핑
        }
    }

    @OnMessage
    public void onMessage(String message, Session session) throws Exception {
        JsonObject parsedMessage = gson.fromJson(message, JsonObject.class);
        System.out.println(parsedMessage);
        String type = parsedMessage.has("type") ? parsedMessage.get("type").getAsString() : "";
        int roomId = 0;
        if (parsedMessage.has("roomId") && !parsedMessage.get("roomId").getAsString().trim().isEmpty()) {
            roomId = Integer.parseInt(parsedMessage.get("roomId").getAsString());
        }
        switch (type) {
            case "roomEnter": //방 입장
                loadAndSendChatHistory(parsedMessage, roomId);
                break;
            case "newRoom": //새로운 방
                addEmployeeToRoom(parsedMessage, roomId);
                break;
            case "invite": //방 초대 - 미완성
                processRoomInvitation(parsedMessage, roomId);
                break;
            case "message": //메세지전송?
                processAndBroadcastMessage(parsedMessage, roomId);
                break;
            default:
                System.out.println("기본출력");
        }
    }

    // newRoom
    public void addEmployeeToRoom(JsonObject parsedMessage, int roomId) throws IOException {
        String employeeId = parsedMessage.get("employeeId").getAsString();
        String id1 = dto.getId();
        String id2 = employeeId;
        long num1 = Long.parseLong(id1);
        long num2 = Long.parseLong(id2);
        String roomName = (num1 < num2) ? id1 + "|" + id2 : id2 + "|" + id1;
         int selectByName = messengerService.selectByName(roomName); // <- SELECT COUNT(*) FROM MEESAGE_ROOM WHERE NAME = #{}
         if (selectByName == 0) {
             Map<String,Object> result = messengerService.createChatRoom(employeeId,dto.getId(), roomName);
             String newRoomId = result.get("messageRoomId").toString();
             String messageRoomUserId = result.get("messageRoomUserId").toString();
             JsonObject response = new JsonObject();
             response.addProperty("type", "NEW_CHAT_ROOM");
             response.addProperty("roomId", newRoomId);
             response.addProperty("messageRoomUserId", messageRoomUserId);

             clientSessions.get(employeeId).getBasicRemote().sendText(gson.toJson(response));
             clientSessions.get(dto.getId()).getBasicRemote().sendText(gson.toJson(response));
         } else {
             int newRoomId = messengerService.findByRoomId(roomName);
             JsonObject response = new JsonObject();
             response.addProperty("type", "NEW_CHAT_ROOM");
             response.addProperty("roomId", newRoomId);
             clientSessions.get(employeeId).getBasicRemote().sendText(gson.toJson(response));
             clientSessions.get(dto.getId()).getBasicRemote().sendText(gson.toJson(response));
         }
    }

    // invite
    public void processRoomInvitation(JsonObject parsedMessage, int roomId) {
//        List<MessageUserDTO> dtos = messageService.selectRoomById(roomId); //select * from message_room where id = roomId
//        //인원이 몇명인지 체크
//        for (MessageUserDTO dto : dtos) {
//            if (dto.getEmployeeId().equals(parsedMessage.get("employeeId").getAsString())) {
//                // 이미 초대 되었음
//                enterChatRoom(message);
//                return;
//            }
//        }
//        if(dtos.size() <= 2) {
//            // 개인
//            // insertRoom(select key) -> dtos.getEmploteeId 얘들도 다 방금 만든 기존 User roomUser insert
//            // 개인방이면 room을 만듬 roomId = 위에서 insert한 roomId meesage_room_user
//        }
//        // 처음 들어온 경우
//        messageService.insertUser(roomId, parsedMessage.get("employeeId").getAsString());
//        enterChatRoom(message);
    }

    // roomEnter
    public void loadAndSendChatHistory(JsonObject parsedMessage, int roomId) throws IOException {
        // select count(*) from message_room where id = roomId;
        List<MessageHistoryDTO> messages = messengerService.selectMessageByRoomId(roomId);
        String employeeId = parsedMessage.get("employeeId").getAsString();
        JsonObject response = new JsonObject();
        response.addProperty("type", "history");
        // messages 배열을 JSON 트리 형태로 추가합니다.
        response.add("messages", gson.toJsonTree(messages));

        String jsonResponse = gson.toJson(response);
        try {
            clientSessions.get(dto.getId()).getBasicRemote().sendText(jsonResponse);
        } catch (NullPointerException ignored) {}
    }

    // message
    public void processAndBroadcastMessage(JsonObject parsedMessage, int roomId) throws IOException {
        MessageUserDTO dto = messengerService.selectUserByEmployeeIdAndRoomId(parsedMessage.get("employeeId").getAsString(), roomId);
        System.out.println(parsedMessage.get("employeeId").getAsString()+ " : " + roomId);
        //{"type":"message","employeeId":"2307276","message":"안녕하세요ㅎ","roomId":"428"}
        MessageDTO messageDTO = MessageDTO.builder()
                .messagerRoomId(roomId)
                .messagerRoomuserId(dto.getId())
                .content(parsedMessage.get("message").getAsString())
                .name(dto.getName())
                .build();
        messengerService.insertMessage(messageDTO);

        List<MessageUserListDTO> dtos = messengerService.selectRoomById(roomId);
        for (MessageUserListDTO dto2 : dtos) {
            String employeeId = dto2.getEmployeeId();
            try {
                clientSessions.get(employeeId).getBasicRemote().sendText(gson.toJson(messageDTO));
            } catch (NullPointerException ignored) {}
        }
    }

    @OnClose
    public void onClose(Session session) {
        System.out.println("유저 나감 " + session.getId());
        clientSessions.values().removeIf(s -> s.equals(session));
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        clientSessions.values().removeIf(s -> s.equals(session));
        throwable.printStackTrace();
    }

}