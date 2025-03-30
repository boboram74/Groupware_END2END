package com.end2end.spring.commute.scheduler;

import com.end2end.spring.util.Statics;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
public class VacationScheduler {
    @Autowired
    private RestTemplate restTemplate;

    @Scheduled(cron= "0 0 0 1 * ?")
    public void workOnCheck() {
        System.out.println("휴가 체크!!");
    }
}
