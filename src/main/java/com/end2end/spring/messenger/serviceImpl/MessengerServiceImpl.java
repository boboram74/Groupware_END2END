package com.end2end.spring.messenger.serviceImpl;

import com.end2end.spring.messenger.dao.MessengerDAO;
import com.end2end.spring.messenger.dto.ChatRoomListDTO;
import com.end2end.spring.messenger.dto.MessageHistoryDTO;
import com.end2end.spring.messenger.dto.MessengerEmployeeListDTO;
import com.end2end.spring.messenger.service.MessengerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

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
    public List<MessageHistoryDTO> selectByRoomId(int roomId) {
        return messengerDAO.selectByRoomId(roomId);
    }

    @Override
    public int selectRoomByName(String roomName) {
        Integer result = messengerDAO.selectRoomByName(roomName);
        return result == null ? 0 : result;
    }

    @Override
    public void messageRoomInvite(int roomId, String employeeId) {
        messengerDAO.messageRoomInvite(roomId, employeeId);
    }

    @Override
    public int findByRoomId(String roomName) {
        Integer roomResult = messengerDAO.selectRoomByName(roomName);
        return roomResult == null ? 0 : roomResult;
    }

    @Transactional
    @Override
    public void createChatRoom(String roomName, String employeeId, String messageContent) {
        //새로운 채팅방 일때
        int messageRoomId = messengerDAO.messageFirstInsert(roomName);
        int messageRoomUserId = messengerDAO.messageFirstRoomInsert(messageRoomId, employeeId);
        messengerDAO.messageFirstContentInsert(messageRoomId, messageRoomUserId, messageContent);
    }

    @Transactional
    @Override
    public void insertMessageToRoom(int roomId, String employeeId, String messageContent) {
        Integer roomUserId = messengerDAO.findRoomUser(roomId, employeeId);
        if (roomUserId == null) {
            roomUserId = messengerDAO.messageFirstRoomInsert(roomId, employeeId);
        }
        messengerDAO.messageFirstContentInsert(roomId, roomUserId, messageContent);
    }

    @Override
    public void insertInviteUser(int roomId, String employeeId) {
        messengerDAO.messageFirstRoomInsert(roomId, employeeId);
    }
}