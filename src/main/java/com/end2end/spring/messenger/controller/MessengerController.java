package com.end2end.spring.messenger.controller;

import com.end2end.spring.messenger.dto.MessageDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/messenger")
@Controller
public class MessengerController {
    @RequestMapping("/list/{chattingRoomId}")
    public void list(@PathVariable String chattingRoomId, Model model) {
        // TODO: 채팅방의 모든 채팅 내역을 출력
    }

    @RequestMapping("/insert")
    public void insert(MessageDTO dto) {
        // TODO: 채팅 입력
    }

    @RequestMapping("/update")
    public void update(MessageDTO dto) {
        // TODO: 채팅 수정
    }
}
