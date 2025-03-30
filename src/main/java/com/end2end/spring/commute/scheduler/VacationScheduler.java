package com.end2end.spring.commute.scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class VacationScheduler {
    @Scheduled(cron= "0 0 0 1 * ?")
    public void workOnCheck() {
        // TODO: 매달 연차 지급
        System.out.println("휴가 체크!!");
    }
}
