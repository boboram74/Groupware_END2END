package com.end2end.spring.messenger.serviceImpl;

import com.end2end.spring.messenger.dao.MessengerDAO;
import com.end2end.spring.messenger.dto.*;
import com.end2end.spring.messenger.service.MessengerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MessengerServiceImpl implements MessengerService {

    @Autowired
    private MessengerDAO messengerDAO;

    @Override
    public List<MessengerEmployeeListDTO> employeeListAll(String employeeId) {
        return messengerDAO.selectByEmployeeId(employeeId);
    }

    @Override
    public List<ChatRoomListDTO> selectRoomListAll(String employeeId) {
        return messengerDAO.selectRoomListAll(employeeId);
    }

    @Override
    public List<MessageHistoryDTO> selectMessageByRoomId(int roomId, String employeeId) {
        return messengerDAO.selectMessageByRoomId(roomId, employeeId);
    }

    @Override
    public int findByRoomId(String roomName) {
        Integer roomResult = messengerDAO.selectRoomByName(roomName);
        return roomResult == null ? 0 : roomResult;
    }

    @Transactional
    @Override
    public Map<String, Object> createChatRoom(String employeeId, String senderId, String roomName) {
        //새로운 채팅방 일때
        int messageRoomId = messengerDAO.messageFirstInsert(roomName);
        int messageRoomUserId = messengerDAO.messageFirstRoomInsert(messageRoomId, employeeId);
        messengerDAO.messageFirstRoomInsert(messageRoomId, senderId);
        Map<String, Object> result = new HashMap<>();
        result.put("messageRoomId", messageRoomId);
        result.put("messageRoomUserId", messageRoomUserId);
        return result;
    }

    @Override
    public MessageUserDTO selectUserByEmployeeIdAndRoomId(String employeeId, int roomId) {
        return messengerDAO.selectUserByEmployeeIdAndRoomId(employeeId, roomId);
    }

    @Override
    public int insertMessage(MessageDTO messageDTO) {
        return messengerDAO.insertMessage(messageDTO);
    }

    @Override
    public List<MessageUserListDTO> selectRoomById(int roomId) {
        return messengerDAO.selectRoomById(roomId);
    }

    @Override
    public int selectByName(String roomName) {
        return messengerDAO.selectByName(roomName);
    }

    @Override
    public List<MessageRoomDTO> findByRoomId2(int roomId) {
        return messengerDAO.findByRoomId2(roomId);
    }

    @Override
    public int insertUser(int roomId, String employeeId) {
        return messengerDAO.insertUser(roomId, employeeId);
    }

    @Override
    public void insertUsertoRoom(int roomId, String employeeId) {
        messengerDAO.insertUsertoRoom(roomId, employeeId);
    }
}