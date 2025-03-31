package com.end2end.spring.commute.scheduler;

import com.end2end.spring.commute.service.CommuteService;
import com.end2end.spring.util.Statics;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
public class CommuteScheduler {
    @Autowired
    private CommuteService commuteService;

    @Scheduled(cron= Statics.WORK_ON_CHECK_TIME)
    public void workOnCheck() {
        // TODO: 지정한 시간에 자동으로 출근 체크
        System.out.println("출근 체크!! time:" + LocalDateTime.now());
    }

    @Scheduled(cron=Statics.WORK_OFF_CHECK_TIME)
    public void workOffCheck() {
        // TODO: 지정한 시간에 자동으로 퇴근 체크
        commuteService.checkLeaveEarly();
        System.out.println("퇴근 체크!! time:" + LocalDateTime.now());
    }
    
    @Scheduled(cron="0 42 20 * * ?")
    public void insertAllCommute() {
        // TODO: 매일 자정에 미출근 체크
        commuteService.insertAll();
        System.out.println("미출근 row 생성!! time:" + LocalDateTime.now());
    }

    @Scheduled(cron="0 9 0 * * 1-5")
    public void workOffCheckFinal() {
        // TODO: 연장 근무를 포함한 전인원 퇴근 체크
        commuteService.checkLeaveEarly();
        System.out.println("찐막 퇴근 체크!!! time:" + LocalDateTime.now());
    }
}
