package com.end2end.spring.messenger.service;

import com.end2end.spring.messenger.dto.*;

import java.util.List;
import java.util.Map;

public interface MessengerService {
    List<MessengerEmployeeListDTO> employeeListAll(String employeeId);
    void createChatRoom(String employeeId, String roomName);
    void insertMessageToRoom(int roomId, String employeeId, String messageContent);
    List<ChatRoomListDTO> selectRoomListAll(String employeeId);
    List<MessageHistoryDTO> selectMessageByRoomId(int roomId);
    int selectRoomByName(String roomName);
    void messageRoomInvite(int roomId, String employeeId);
    int findByRoomId(String roomName);
    void insertInviteUser(int roomId, String employeeId);

    int findByRoomSeq();
    MessageUserDTO selectUserByEmployeeIdAndRoomId(String employeeId, int roomId);

    int insertMessage(MessageDTO messageDTO);

    List<MessageUserListDTO> selectRoomById(int roomId);
}