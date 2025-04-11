package com.end2end.spring.messenger.service;

import com.end2end.spring.messenger.dto.ChatRoomListDTO;
import com.end2end.spring.messenger.dto.MessageHistoryDTO;
import com.end2end.spring.messenger.dto.MessengerEmployeeListDTO;

import java.util.List;
import java.util.Map;

public interface MessengerService {
    List<MessengerEmployeeListDTO> employeeListAll(String employeeId);
    void messageFirstInsert(String roomName, String employeeId, String messageContent, int roomId);
    List<ChatRoomListDTO> selectRoomListAll(String employeeId);
    List<MessageHistoryDTO> selectByRoomId(int roomId);

    int findByRoomId(int roomId);
}