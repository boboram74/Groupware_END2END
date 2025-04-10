//package com.end2end.spring.messenger.config;
//
//import com.end2end.spring.employee.dto.EmployeeDTO;
//import com.end2end.spring.messenger.dto.*;
//import com.end2end.spring.messenger.service.*;
//import com.google.gson.Gson;
//import com.google.gson.JsonObject;
//import com.google.gson.JsonParser;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Component;
//
//import javax.servlet.http.HttpSession;
//import javax.websocket.*;
//import javax.websocket.server.ServerEndpoint;
//import java.io.IOException;
//import java.sql.Timestamp;
//import java.util.*;
//import java.util.concurrent.ConcurrentHashMap;
//import java.util.stream.Collectors;
//
//@Component
//@ServerEndpoint(value = "/chat", configurator = WebSocketConfig.class)
//public class ChatEndPoint_bak_v2 {
//
//    private static final Map<String, Session> clientSessions = new ConcurrentHashMap<>();
//    private static final Map<String, Map<String, Integer>> unreadCounts = new ConcurrentHashMap<>();
//
//    @Autowired
//    private MessageService messageService;
//
//    @Autowired
//    private MessageRoomService messageRoomService;
//
//    @Autowired
//    private MessageReadService messageReadService;
//
//    @Autowired
//    private MessageRoomUserService messageRoomUserService;
//
//    private final Gson gson = new Gson();
//    private HttpSession httpSession;
//
//    @OnOpen
//    public void onConnect(Session session, EndpointConfig config) {
//        this.httpSession = (HttpSession) config.getUserProperties().get(HttpSession.class.getName());
//        String userId = getUserId();
//        System.out.println("사용자 연결: " + userId);
//
//        if (userId != null) {
//            clientSessions.put(userId, session);
//            try {
//                sendInitialData(session, userId);
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//        }
//    }
//
//    @OnMessage
//    public void onMessage(String message, Session session) {
//        try {
//            JsonObject jsonMessage = JsonParser.parseString(message).getAsJsonObject();
//            String type = jsonMessage.get("type").getAsString();
//            String userId = getUserId();
//
//            if (userId == null) {
//                sendError(session, "User not authenticated");
//                return;
//            }
//            switch (type) {
//                case "CHAT":
//                    handleChatMessage(jsonMessage, userId);
//                    break;
//                case "CREATE_ROOM":
//                    handleCreateRoom(jsonMessage, userId);
//                    break;
//                case "INVITE":
//                    handleInvite(jsonMessage, userId);
//                    break;
//                case "READ_RECEIPT":
//                    handleReadReceipt(jsonMessage, userId);
//                    break;
//                case "GET_USER_LIST":
//                    handleGetUserList(userId);
//                    break;
//                case "GET_ROOM_LIST":
//                    handleGetRoomList(userId);
//                    break;
//                case "GET_MESSAGE_HISTORY":
//                    handleGetMessageHistory(jsonMessage, userId);
//                    break;
//                case "CHECK_UNREAD":
//                    handleCheckUnread(userId);
//                    break;
//                default:
//                    System.out.println("Unknown message type: " + type);
//                    sendError(session, "Unknown message type: " + type);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            sendError(session, "Invalid message format");
//        }
//    }
//
//    private void handleChatMessage(JsonObject message, String senderId) throws IOException {
//        String roomId = message.get("roomId").getAsString();
//        String content = message.get("content").getAsString();
//
//        // 메시지 저장
//        MessageDTO newMessage = new MessageDTO();
//        newMessage.setMessageRoomId(Integer.parseInt(roomId));
//        newMessage.setEmployeeId(senderId);
//        newMessage.setContent(content);
//        newMessage.setRegdate(new Timestamp(System.currentTimeMillis()));
//        int messageId = messageService.insertMessage(newMessage);
//
//        // 채팅방 참여자 조회
//        List<MessageRoomUserDTO> participants = messageRoomUserService.getRoomUsers(Integer.parseInt(roomId));
//
//        // 메시지 객체 생성
//        JsonObject chatMessage = new JsonObject();
//        chatMessage.addProperty("type", "CHAT");
//        chatMessage.addProperty("messageId", messageId);
//        chatMessage.addProperty("roomId", roomId);
//        chatMessage.addProperty("senderId", senderId);
//        chatMessage.addProperty("senderName", getUserName(senderId));
//        chatMessage.addProperty("content", content);
//        chatMessage.addProperty("timestamp", System.currentTimeMillis());
//
//        for (MessageRoomUserDTO participant : participants) {
//            String participantId = participant.getEmployeeId();
//
//            if (!participantId.equals(senderId)) {
//                // 읽지 않은 메시지 카운트 증가 (메모리)
//                unreadCounts.computeIfAbsent(participantId, k -> new ConcurrentHashMap<>())
//                        .merge(roomId, 1, Integer::sum);
//
//                // 알림용 메시지에 unread 플래그 추가
//                chatMessage.addProperty("isUnread", true);
//            }
//
//            // 참여자에게 메시지 전송
//            Session participantSession = clientSessions.get(participantId);
//            if (participantSession != null && participantSession.isOpen()) {
//                participantSession.getBasicRemote().sendText(gson.toJson(chatMessage));
//            }
//        }
//    }
//
//    private void handleCreateRoom(JsonObject message, String creatorId) throws IOException {
//        String targetId = message.get("targetId").getAsString();
//
//        // 채팅방 생성
//        MessageRoomDTO newRoom = new MessageRoomDTO();
//        newRoom.setName(getUserName(creatorId) + ", " + getUserName(targetId));
//        newRoom.setRegdate(new Timestamp(System.currentTimeMillis()));
//        int roomId = messageRoomService.insertRoom(newRoom);
//
//        // 채팅방 사용자 추가
//        addUserToRoom(roomId, creatorId);
//        addUserToRoom(roomId, targetId);
//
//        // 생성자에게 응답
//        JsonObject response = new JsonObject();
//        response.addProperty("type", "ROOM_CREATED");
//        response.addProperty("roomId", roomId);
//        response.addProperty("targetId", targetId);
//        response.addProperty("targetName", getUserName(targetId));
//
//        Session creatorSession = clientSessions.get(creatorId);
//        if (creatorSession != null) {
//            creatorSession.getBasicRemote().sendText(gson.toJson(response));
//        }
//
//        // 상대방에게 초대 메시지 전송
//        Session targetSession = clientSessions.get(targetId);
//        if (targetSession != null && targetSession.isOpen()) {
//            JsonObject inviteMessage = new JsonObject();
//            inviteMessage.addProperty("type", "INVITE");
//            inviteMessage.addProperty("roomId", roomId);
//            inviteMessage.addProperty("inviterId", creatorId);
//            inviteMessage.addProperty("inviterName", getUserName(creatorId));
//            inviteMessage.addProperty("message", getUserName(creatorId) + "님이 채팅을 시작했습니다.");
//
//            targetSession.getBasicRemote().sendText(gson.toJson(inviteMessage));
//        }
//    }
//
//    private void handleInvite(JsonObject message, String inviterId) throws IOException {
//        String roomId = message.get("roomId").getAsString();
//        String inviteeId = message.get("inviteeId").getAsString();
//
//        // 채팅방 참여자 추가 (DB)
//        addUserToRoom(Integer.parseInt(roomId), inviteeId);
//
//        // 초대받은 사용자에게 알림 전송
//        Session inviteeSession = clientSessions.get(inviteeId);
//        if (inviteeSession != null && inviteeSession.isOpen()) {
//            JsonObject inviteMessage = new JsonObject();
//            inviteMessage.addProperty("type", "INVITE");
//            inviteMessage.addProperty("roomId", roomId);
//            inviteMessage.addProperty("inviterId", inviterId);
//            inviteMessage.addProperty("inviterName", getUserName(inviterId));
//            inviteMessage.addProperty("message", getUserName(inviterId) + "님이 당신을 채팅방에 초대했습니다.");
//
//            inviteeSession.getBasicRemote().sendText(gson.toJson(inviteMessage));
//        }
//    }
//
//    private void handleReadReceipt(JsonObject message, String userId) {
//        String roomId = message.get("roomId").getAsString();
//        String messageId = message.get("messageId").getAsString();
//
//        // DB에 읽음 표시 저장
//        MessageReadDTO read = new MessageReadDTO();
//        read.setMessageId(Integer.parseInt(messageId));
//
//        // roomId와 userId로 message_room_user의 ID 조회
//        Integer roomUserId = messageRoomUserService.getRoomUserId(Integer.parseInt(roomId), userId);
//        if (roomUserId != null) {
//            read.setMessageRoomUserId(roomUserId);
//            read.setRegdate(new Timestamp(System.currentTimeMillis()));
//            messageReadService.insertReadRecord(read);
//
//            // 메모리에서 읽지 않은 메시지 카운트 제거
//            if (unreadCounts.containsKey(userId)) {
//                unreadCounts.get(userId).remove(roomId);
//            }
//        }
//    }
//
//    private void handleGetUserList(String userId) throws IOException {
//        // 사원 목록 조회 (자신 제외)
//        List<EmployeeDTO> employees = messageService.getAllEmployeesExcluding(userId);
//
//        JsonObject response = new JsonObject();
//        response.addProperty("type", "USER_LIST");
//        response.add("users", gson.toJsonTree(employees.stream()
//                .map(emp -> {
//                    Map<String, String> user = new HashMap<>();
//                    user.put("id", emp.getId());
//                    user.put("name", emp.getName());
//                    user.put("teamName", "임시");
//                    user.put("jobName", emp.getJobName());
//                    user.put("profileImage", emp.getProfileImg());
//                    return user;
//                })
//                .collect(Collectors.toList())));
//
//        sendToUser(userId, response);
//    }
//
//    private void handleGetRoomList(String userId) throws IOException {
//        // 사용자의 채팅방 목록 조회
//        List<MessageRoomDTO> rooms = messageRoomService.getRoomsByUser(userId);
//
//        JsonObject response = new JsonObject();
//        response.addProperty("type", "ROOM_LIST");
//        response.add("rooms", gson.toJsonTree(rooms.stream()
//                .map(room -> {
//                    Map<String, Object> roomInfo = new HashMap<>();
//                    roomInfo.put("roomId", room.getId());
//                    roomInfo.put("roomName", room.getName());
//
//                    // 마지막 메시지 조회
//                    MessageDTO lastMessage = messageService.getLastMessageByRoom(room.getId());
//                    if (lastMessage != null) {
//                        roomInfo.put("lastMessage", lastMessage.getContent());
//                        roomInfo.put("lastMessageTime", lastMessage.getRegdate().getTime());
//                    }
//
//                    // 읽지 않은 메시지 수
//                    int unreadCount = messageService.getUnreadCount(room.getId(), userId);
//                    roomInfo.put("unreadCount", unreadCount);
//
//                    return roomInfo;
//                })
//                .collect(Collectors.toList())));
//
//        sendToUser(userId, response);
//    }
//
//    private void handleGetMessageHistory(JsonObject message, String userId) throws IOException {
//        String roomId = message.get("roomId").getAsString();
//
//        // 메시지 기록 조회
//        List<MessageDTO> messages = messageService.getMessagesByRoom(Integer.parseInt(roomId));
//
//        JsonObject response = new JsonObject();
//        response.addProperty("type", "MESSAGE_HISTORY");
//        response.add("messages", gson.toJsonTree(messages.stream()
//                .map(msg -> {
//                    Map<String, Object> msgMap = new HashMap<>();
//                    msgMap.put("messageId", msg.getId());
//                    msgMap.put("senderId", msg.getEmployeeId());
//                    msgMap.put("senderName", getUserName(msg.getEmployeeId()));
//                    msgMap.put("content", msg.getContent());
//                    msgMap.put("timestamp", msg.getRegdate().getTime());
//
//                    // 읽음 여부 확인
//                    boolean isRead = messageReadService.isMessageRead(msg.getId(), userId);
//                    msgMap.put("isRead", isRead);
//
//                    return msgMap;
//                })
//                .collect(Collectors.toList())));
//
//        sendToUser(userId, response);
//    }
//
//    private void handleCheckUnread(String userId) throws IOException {
//        // 전체 읽지 않은 메시지 수 계산
//        int totalUnread = messageService.getTotalUnreadCount(userId);
//
//        JsonObject response = new JsonObject();
//        response.addProperty("type", "UNREAD_COUNT");
//        response.addProperty("count", totalUnread);
//
//        sendToUser(userId, response);
//    }
//
//    private void sendInitialData(Session session, String userId) throws IOException {
//        // 초기 데이터 전송 (읽지 않은 메시지 수 등)
//        handleCheckUnread(userId);
//    }
//
//    private void sendError(Session session, String errorMessage) {
//        try {
//            JsonObject error = new JsonObject();
//            error.addProperty("type", "ERROR");
//            error.addProperty("message", errorMessage);
//
//            if (session != null && session.isOpen()) {
//                session.getBasicRemote().sendText(gson.toJson(error));
//            }
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//    }
//
//    private void sendToUser(String userId, JsonObject message) throws IOException {
//        Session session = clientSessions.get(userId);
//        if (session != null && session.isOpen()) {
//            session.getBasicRemote().sendText(gson.toJson(message));
//        }
//    }
//
//    private void addUserToRoom(int roomId, String employeeId) {
//        MessageRoomUserDTO roomUser = new MessageRoomUserDTO();
//        roomUser.setMessageRoomId(roomId);
//        roomUser.setEmployeeId(employeeId);
//        roomUser.setRegdate(new Timestamp(System.currentTimeMillis()));
//        messageRoomUserService.addUserToRoom(roomUser);
//    }
//
//    private String getUserName(String employeeId) {
//        EmployeeDTO employee = messageService.getEmployeeById(employeeId);
//        return employee != null ? employee.getName() : "알 수 없음";
//    }
//
//    private String getUserId() {
//        if (httpSession == null) return null;
//        EmployeeDTO employee = (EmployeeDTO) httpSession.getAttribute("employee");
//        return employee != null ? employee.getId() : null;
//    }
//
//    private String getUserName() {
//        return getUserName(getUserId());
//    }
//
//    @OnClose
//    public void onClose(Session session) {
//        String userId = getUserId();
//        if (userId != null) {
//            clientSessions.remove(userId);
//            System.out.println("사용자 연결 종료: " + userId);
//        }
//    }
//
//    @OnError
//    public void onError(Session session, Throwable thr) {
//        thr.printStackTrace();
//    }
//}