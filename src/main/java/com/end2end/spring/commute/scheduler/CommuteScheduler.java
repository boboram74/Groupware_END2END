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

    @Scheduled(cron="0 59 23 * * 1-5")
    public void lateCheck() {
        // TODO: 지각자 체크
        commuteService.checkLate();
    }

    @Scheduled(cron="0 59 23 * * 1-5")
    public void workOffCheckFinal() {
        // TODO: 연장 근무를 포함한 전인원 퇴근 체크
        commuteService.checkLeaveEarly();
        System.out.println("찐막 퇴근 체크!!! time:" + LocalDateTime.now());
    }
}
