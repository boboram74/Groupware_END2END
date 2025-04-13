package com.end2end.spring.commute.scheduler;

import com.end2end.spring.commute.service.VacationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class VacationScheduler {
    @Autowired private VacationService vacationService;

    @Scheduled(cron= "0 0 0 * * ?")
    public void workOnCheck() throws Exception {
        // TODO: 연차 지급 확인
        vacationService.insertUsableVacationHired1st();
        vacationService.insertUsableVacation();
    }
}
