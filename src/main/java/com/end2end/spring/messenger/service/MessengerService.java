package com.end2end.spring.messenger.service;

import com.end2end.spring.messenger.dto.*;

import java.util.List;
import java.util.Map;

public interface MessengerService {
    List<MessengerEmployeeListDTO> employeeListAll(String employeeId);
    Map<String, Object> createChatRoom(String employeeId, String senderId, String roomName);
    List<ChatRoomListDTO> selectRoomListAll(String employeeId);
    List<MessageHistoryDTO> selectMessageByRoomId(int roomId);
    int findByRoomId(String roomName);
    MessageUserDTO selectUserByEmployeeIdAndRoomId(String employeeId, int roomId);
    int insertMessage(MessageDTO messageDTO);
    List<MessageUserListDTO> selectRoomById(int roomId);
    int selectByName(String roomName);
}