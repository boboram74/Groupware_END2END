package com.end2end.spring.main.service;

import com.end2end.spring.main.dto.ExamDTO;

public interface MainService {
    //서비스 파일 규칙
    //리턴타입 메서드명(매개변수) 예외전가

    /**
     * Todo : 서비스 파일 규칙
    **/
    int insertByMember(ExamDTO dto) throws Exception;
}