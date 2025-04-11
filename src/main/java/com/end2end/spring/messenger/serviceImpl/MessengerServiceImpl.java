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
    public void messageFirstInsert(String roomName, String employeeId, String messageContent) {

    }

    @Transactional
    @Override
    public void messageFirstInsert(String roomName, String employeeId, String messageContent, int roomId) {

        Integer room = messengerDAO.findRoomByName(roomId);
        int result = this.findByRoomId(roomId);
        if(result == 0) {
            roomId = messengerDAO.messageFirstInsert(roomName);
            roomUserId = messengerDAO.messageFirstRoomInsert(roomId, employeeId);
        } else {
            int createRoom = messengerDAO.messageFirstInsert(roomName); // 방 만들기

        }
        int roomUserId = messengerDAO.messageFirstRoomInsert(createRoom, employeeId);
        messengerDAO.messageFirstContentInsert(createRoom, roomUserId, messageContent);
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
    public int findByRoomId(int roomId) {
        return messengerDAO.findByRoomId(roomId);
    }
}