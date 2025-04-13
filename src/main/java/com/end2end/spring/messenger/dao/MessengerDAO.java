package com.end2end.spring.messenger.dao;

import com.end2end.spring.messenger.dto.ChatRoomListDTO;
import com.end2end.spring.messenger.dto.MessageHistoryDTO;
import com.end2end.spring.messenger.dto.MessengerEmployeeListDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class MessengerDAO {

    @Autowired
    private SqlSession mybatis;

    public List<MessengerEmployeeListDTO> selectByEmployeeId(String employeeId) {
        return mybatis.selectList("messenger.selectEmployeeAll", employeeId);
    }

    public int messageFirstInsert(String roomName) {
        Map<String, Object> param = new HashMap<>();
        param.put("value", roomName);
        int result = mybatis.insert("messenger.messageFirstInsert",param);
        return (int) param.get("id");
    }

    public int messageFirstRoomInsert(int roomSeq, String employeeId) {
        Map<String, Object> param = new HashMap<>();
        param.put("roomSeq", roomSeq);
        param.put("employeeId", employeeId);
        int result = mybatis.insert("messenger.messageFirstRoomInsert", param);
        return (int) param.get("id");
    }

    public void messageFirstContentInsert(int messageRoomId, int messageRoomUserId, String messageContent) {
        Map<String, Object> param = new HashMap<>();
        param.put("messageRoomId", messageRoomId);
        param.put("messageRoomUserId", messageRoomUserId);
        param.put("messageContent", messageContent);
        mybatis.insert("messenger.messageFirstContentInsert", param);
    }
    public List<ChatRoomListDTO> selectRoomListAll (String employeeId) {
        return mybatis.selectList("messenger.selectRoomListAll", employeeId);
    }

    public List<MessageHistoryDTO> selectByRoomId(int roomId) {
        return mybatis.selectList("messenger.selectByRoomId", roomId);
    }

    public int findByRoomId(String roomName) {
        return mybatis.selectOne("messenger.findByRoomId", roomName);
    }

    public Integer findRoomUser(int roomId, String employeeId) {
        Map<String, Object> param = new HashMap<>();
        param.put("roomId", roomId);
        param.put("employeeId", employeeId);
        return mybatis.selectOne("messenger.findRoomUser", param);
    }

    public List<String> selectRoomMemberIds(int roomId) {
        Map<String, Object> param = new HashMap<>();
        param.put("roomId", roomId);
        return mybatis.selectList("messenger.selectRoomMemberIds", param);
    }
    public Integer selectRoomByName(String roomName) {
        return mybatis.selectOne("messenger.selectRoomByName", roomName);
    }
    public void messageRoomInvite(int roomId, String employeeId) {
        Map<String, Object> param = new HashMap<>();
        param.put("roomId", roomId);
        param.put("employeeId", employeeId);
        mybatis.update("messenger.messageRoomInvite", param);
    }
 }