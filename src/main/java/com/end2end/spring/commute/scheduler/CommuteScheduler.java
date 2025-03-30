package com.end2end.spring.commute.scheduler;

import com.end2end.spring.util.Statics;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
public class CommuteScheduler {
    @Autowired
    private RestTemplate restTemplate;

    @Scheduled(cron= Statics.WORK_ON_CHECK_TIME)
    public void workOnCheck() {
        System.out.println("출근 체크!!");
    }

    @Scheduled(cron=Statics.WORK_OFF_CHECK_TIME)
    public void workOffCheck() {
        System.out.println("퇴근 체크!!");
    }
}
