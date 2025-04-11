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

    @Transactional
    @Override
    public void messageFirstInsert(String roomName, String employeeId, String messageContent, int roomId) {
        Integer roomUserId = null;
        // 신규 채팅방 생성
        if (roomId == 0) {
            roomId = messengerDAO.messageFirstInsert(roomName);
            roomUserId = messengerDAO.messageFirstRoomInsert(roomId, employeeId);
        } else {
            // 기존 채팅방인 경우
            int count = messengerDAO.findByRoomId(roomId);
            if (count == 0) {
                // 실제로 기존 채팅방이 없다면 신규로 생성
                roomId = messengerDAO.messageFirstInsert(roomName);
                roomUserId = messengerDAO.messageFirstRoomInsert(roomId, employeeId);
            } else {
                // 채팅방이 존재하면 해당 사용자(roomUser)가 등록되어 있는지 확인
                roomUserId = messengerDAO.findRoomUser(roomId, employeeId);
                if (roomUserId == null) {
                    roomUserId = messengerDAO.messageFirstRoomInsert(roomId, employeeId);
                }
            }
        }
        messengerDAO.messageFirstContentInsert(roomId, roomUserId, messageContent);
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