package com.end2end.spring.messenger.controller;

import com.end2end.spring.messenger.dto.MessengerEmployeeListDTO;
import com.end2end.spring.messenger.service.MessengerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/messenger")
@Controller
public class MessengerController {

    @Autowired
    private MessengerService messengerService;

    @ResponseBody
    @RequestMapping("/employeeListAll")
    public ResponseEntity<Map<String, Object>> employeeListAll() {
        List<MessengerEmployeeListDTO> result = new ArrayList<>(messengerService.employeeListAll());
        Map<String, Object> data = new HashMap<>();
        data.put("employeeListAll", result);
        return ResponseEntity.ok(data);
    }

    @RequestMapping("/list/{chattingRoomId}")
    public void list(@PathVariable String chattingRoomId, Model model) {
        // TODO: 채팅방의 모든 채팅 내역을 출력
    }

    @RequestMapping("/insert")
    public void insert(String dto) {
        // TODO: 채팅 입력
    }

    @RequestMapping("/update")
    public void update(String dto) {
        // TODO: 채팅 수정
    }
}