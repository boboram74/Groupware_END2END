package com.end2end.spring.messenger.service;

import com.end2end.spring.messenger.dto.*;

import java.util.List;
import java.util.Map;

public interface MessengerService {
    List<MessengerEmployeeListDTO> employeeListAll(String employeeId);
    Map<String, Object> createChatRoom(String employeeId, String senderId, String roomName);
    List<ChatRoomListDTO> selectRoomListAll(String employeeId);
    List<MessageHistoryDTO> selectMessageByRoomId(int roomId, String employeeId);
    int findByRoomId(String roomName);
    MessageUserDTO selectUserByEmployeeIdAndRoomId(String employeeId, int roomId);
    int insertMessage(MessageDTO messageDTO);
    List<MessageUserListDTO> selectRoomById(int roomId);
    int selectByName(String roomName);

    List<MessageRoomDTO> findByRoomId2(int roomId);

    int insertUser(int roomId, String employeeId);
    void insertUsertoRoom(int roomId, String employeeId);
}