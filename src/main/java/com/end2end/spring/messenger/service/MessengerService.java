package com.end2end.spring.messenger.service;

import com.end2end.spring.messenger.dto.ChatRoomListDTO;
import com.end2end.spring.messenger.dto.MessageHistoryDTO;
import com.end2end.spring.messenger.dto.MessengerEmployeeListDTO;

import java.util.List;
import java.util.Map;

public interface MessengerService {
    List<MessengerEmployeeListDTO> employeeListAll(String employeeId);
    void createChatRoom(String roomName, String employeeId, String messageContent);
    void insertMessageToRoom(int roomId, String employeeId, String messageContent);
    List<ChatRoomListDTO> selectRoomListAll(String employeeId);
    List<MessageHistoryDTO> selectByRoomId(int roomId);
    int selectRoomByName(String roomName);
    void messageRoomInvite(int roomId, String employeeId);
    int findByRoomId(String roomName);
    void insertInviteUser(int roomId, String employeeId);
}